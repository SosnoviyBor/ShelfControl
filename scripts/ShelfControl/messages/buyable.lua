local nearby = require("openmw.nearby")
local types = require("openmw.types")
local core = require("openmw.core")

require("scripts.ShelfControl.utils.tables")
require("scripts.ShelfControl.utils.consts")
require("scripts.ShelfControl.utils.random")

local l10n = core.l10n("ShelfControl_msgVendors")
local racialVendorMessages = l10n("racialVendor")
local racialPlayerMessages = l10n("racialPlayer")
local specificMessages = l10n("specific")

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
    for _, actor in pairs(nearby.actors) do
        if actor.type ~= types.NPC then goto continue end
        if string.find(string.lower(actor.recordId), "ordinator") > 0 then
            return true
        end
        ::continue::
    end
    return false
end

local function multipleVendorsNearby()
    local vendorCount = 0

    for _, actor in pairs(nearby.actors) do
        if actor.type ~= types.NPC then goto continue end

        local actorRecord = actor.type.records[actor.recordId]

        if TableIsEmpty(actorRecord.servicesOffered) then goto continue end

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
        cond = function(ctx) return ctx.owner.recordId == "Jobasha" end,
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
            local vendorRace = ctx.owner.type.records[ctx.owner.recordId]
            local playerRace = ctx.player.type.records[ctx.player.recordId]
            return vendorRace == "dunmer" and playerRace ~= "dunmer"
        end,
        key = "dunmerVendorToOutlander",
    },
}

function CollectBuyableMessages(ctx)
    local messages = {
        ["generic"] = l10n("generic"),
        ["specific"] = {},
        ["racialPlayer"] = {},
        ["racialVendor"] = {},
    }
    local weights = {
        ["generic"]      = 30,
        ["specific"]     = 50,
        ["racialPlayer"] = 10,
        ["racialVendor"] = 10,
    }

    -- racial
    local vendorRace = ctx.owner.type.records[ctx.owner.recordId]
    local playerRace = ctx.player.type.records[ctx.player.recordId]
    messages.racialVendor = racialVendorMessages[vendorRace] or {}
    messages.racialPlayer = racialPlayerMessages[playerRace] or {}

    -- specific
    for _, rule in ipairs(specificRules) do
        if rule.cond(ctx) then
            messages.specific:extend(specificMessages[rule.key])
        end
    end

    -- prune empty groups
    for group in pairs(weights) do
        if TableIsEmpty(messages[group]) then
            messages[group] = nil
            weights[group] = nil
        end
    end

    return { messages, NormalizeWeights(weights) }
end
