local storage = require("openmw.storage")
local types = require("openmw.types")
local world = require("openmw.world")
local core = require("openmw.core")

require("scripts.ShelfControl.messages.utils")
require("scripts.ShelfControl.utils.tables")
require("scripts.ShelfControl.utils.consts")
require("scripts.ShelfControl.utils.random")

local l10n = core.l10n("ShelfControl_messages")
local sectionMsgs = storage.globalSection("ShelfControl_messages")
local msgSrc = "buyable_"

local function ordinatorCity(ctx)
    -- by city name
    local cell = ctx.book.cell
    local cellName = string.lower(cell.name)
    for _, city in pairs(CitiesWithOrdinators) do
        if string.find(string.lower(cellName), city) then
            return true
        end
    end
    -- by ordinators nearby
    for _, actor in pairs(world.activeActors) do
        if actor.type ~= types.NPC then goto continue end
        if string.find(string.lower(actor.recordId), "ordinator") > 0 then
            return true
        end
        ::continue::
    end
    return false
end

local function multipleVendorsNearby(ctx)
    local vendorCount = 0

    for _, actor in pairs(world.activeActors) do
        if actor.type ~= types.NPC then goto continue end

        local actorRecord = actor.type.records[actor.recordId]

        local isVendor = false
        for _, isOffered in pairs(actorRecord.servicesOffered) do
            if isOffered then
                isVendor = true
                break
            end
        end
        if not isVendor then goto continue end

        vendorCount = vendorCount + 1
        if vendorCount >= MANY_VENDORS_THRESHOLD then
            return true
        end

        ::continue::
    end
    return false
end

local specificRules = {
    {
        cond = function(ctx)
            local playerQuests = ctx.player.type.quests(ctx.player)
            return playerQuests["A1_1_FindSpymaster"].stage >= 14
        end,
        key = "caiusMet",
    },
    {
        cond = function(ctx) return ctx.owner.recordId == "jobasha" end,
        key = "ownedByJobasha",
    },
    {
        cond = ordinatorCity,
        key = "ordinatorsNearby",
    },
    {
        cond = multipleVendorsNearby,
        key = "multipleVendorsNearby",
    },
    {
        cond = function(ctx)
            local ownerRace = ctx.owner.self.type.records[ctx.owner.recordId]
            local playerRace = ctx.player.type.records[ctx.player.recordId]
            return ownerRace == "dunmer" and playerRace ~= "dunmer"
        end,
        key = "dunmerVendorToOutlander",
    },
}

local function collectGenericMessages(subgroups, ctx)
    local prefix = msgSrc .. "generic"
    return CollectAllMessagesByPrefix(prefix, l10n)
end

local function collectRacialMessages(subgroups, ctx)
    local msgs = {}
    for group, _ in pairs(subgroups) do
        local actor = ctx[group].self
        local race = actor.type.records[actor.recordId]
        local prefix = msgSrc .. "racial_" .. group .. race
        local collectedMsgs = CollectAllMessagesByPrefix(prefix, l10n)
        AppendArray(msgs, collectedMsgs)
    end
    return msgs
end

local function collectSpecificMessages(subgroups, ctx)
    local msgs = {}
    for group, _ in pairs(subgroups) do
        local prefix = msgSrc .. "specific_" .. group
        local collectedMsgs = CollectAllMessagesByPrefix(prefix, l10n)
        AppendArray(msgs, collectedMsgs)
    end
    return msgs
end

local msgCollectors = {
    generic = collectGenericMessages,
    racial = collectRacialMessages,
    specific = collectSpecificMessages,
}

local function checkRacialMessages(actor)
    local race = actor.type.records[actor.recordId].race
    local firstRacialMessageKey = "racial_" .. race .. "_1"
    return l10n(firstRacialMessageKey) ~= firstRacialMessageKey
end

function PickBuyableMessage(ctx)
    local msgGroups = {
        generic = true,
        racial = {
            player = false,
            owner = false,
        },
        specific = {
            caiusMet = false,
            ownedByJobasha = false,
            ordinatorsNearby = false,
            multipleVendorsNearby = false,
            dunmerVendorToOutlander = false,
        },
    }
    local weights = {
        generic  = sectionMsgs:get("buyableGenericMsgWeight"),
        racial   = sectionMsgs:get("buyableRacialMsgWeight"),
        specific = sectionMsgs:get("buyableSpecificMsgWeight"),
    }

    -- collect all possible message groups
    -- racial
    msgGroups.racial.owner = checkRacialMessages(ctx.owner.self)
    msgGroups.racial.player = checkRacialMessages(ctx.player)
    -- specific
    for _, rule in ipairs(specificRules) do
        if rule.cond(ctx) then
            msgGroups.specific[rule.key] = true
        end
    end

    PruneMessageGroups(msgGroups, weights)

    local pickedGroup = PickRandomWeightedKey(NormalizeWeights(weights))

    local msgCollector = msgCollectors[pickedGroup]
    local msgs = msgCollector(msgGroups[pickedGroup], ctx)
    if msgs then
        return RandomChoice(msgs)
    else
        return l10n("error")
    end
end
