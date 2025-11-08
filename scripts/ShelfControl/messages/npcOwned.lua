local core = require("openmw.core")

require("scripts.ShelfControl.messages.utils")
require("scripts.ShelfControl.utils.tables")
require("scripts.ShelfControl.utils.consts")
require("scripts.ShelfControl.utils.random")

local l10n = core.l10n("ShelfControl_messages")
local msgSrc = "npcOwned_"

-- +------------------------------+
-- | Rules for conditional groups |
-- +------------------------------+

local unlockableRules = {
    {
        cond = function(ctx)
            local int = ctx.player.type.stats.attributes.intelligence(ctx.player)
            local race = GetRecord(ctx.player).race
            return int.modified <= LOW_INT and race == "orc"
        end,
        key = "dumbOrc"
    },
    {
        cond = function(ctx)
            local int = ctx.player.type.stats.attributes.intelligence(ctx.player)
            return int.modified <= LOW_INT
        end,
        key = "lowInt"
    },
    {
        cond = function(ctx)
            local ench = ctx.player.type.skills.attributes.enchant(ctx.player)
            return ench.modified >= HIGH_ENCH
        end,
        key = "highEnch"
    },
}

local specificRules = {
    {
        cond = function(ctx)
            local class = GetRecord(ctx.owner).class
            return MagicClasses[class] == true
        end,
        key = "ownerIsOfMagicClass",
    },
}

-- +-------------------------------------------------------+
-- | Functions for collecting all messages based on groups |
-- +-------------------------------------------------------+

local function collectGenericMessages(subgroups, ctx)
    local prefix = msgSrc .. "generic"
    local name = GetRecord(ctx.owner.self).name
    return CollectAllMessagesByPrefix(prefix, l10n, {npc_name = name})
end

local function collectEggMessages(subgroups, ctx)
    local prefix = msgSrc .. "easterEgg"
    return CollectAllMessagesByPrefix(prefix, l10n)
end

local function collectUnlockableMessages(subgroups, ctx)
    local msgs = {}
    local name = GetRecord(ctx.owner.self).name
    for group, _ in pairs(subgroups) do
        local prefix = msgSrc .. "unlockable_" .. group
        local collectedMsgs = CollectAllMessagesByPrefix(prefix, l10n, {npc_name = name})
        AppendArray(msgs, collectedMsgs)
    end
    return msgs
end

local function collectSpecificMessages(subgroups, ctx)
    local msgs = {}
    local name = GetRecord(ctx.owner.self).name
    for group, _ in pairs(subgroups) do
        local prefix = msgSrc .. "specific_" .. group
        local collectedMsgs = CollectAllMessagesByPrefix(prefix, l10n, {npc_name = name})
        AppendArray(msgs, collectedMsgs)
    end
    return msgs
end

local msgCollectors = {
    generic = collectGenericMessages,
    easterEgg = collectEggMessages,
    unlockable = collectUnlockableMessages,
    specific = collectSpecificMessages,
}

function PickNPCOwnedMessage(ctx)
    local msgGroups = {
        generic = true,
        easterEgg = true,
        unlockable = {
            dumbOrc = false,
            lowInt = false,
            highEnch = false,
        },
        specific = {
            ownerIsOfMagicClass = false,
        },
    }
    local weights = {
        generic    = 30,
        easterEgg  = .05,
        unlockable = 10,
        specific   = 100,
    }

    -- unlockable
    for _, rule in ipairs(unlockableRules) do
        if rule.cond(ctx) then
            msgGroups.unlockable[rule.key] = true
        end
    end
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
