local storage = require("openmw.storage")
local ui = require("openmw.ui")

require("scripts.ShelfControl.messages.buyable")
require("scripts.ShelfControl.messages.npcOwned")
require("scripts.ShelfControl.messages.factionOwned")

local sectionMisc = storage.globalSection("ShelfControl_misc")

local dispatch = {
    { check = function(o) return o.recordId end,   fn = CollectNPCOwnedMessages },
    { check = function(o) return o.sellsBooks end, fn = CollectBuyableMessages },
    { check = function(o) return o.factionId end,  fn = CollectFactionOwnedMessages },
}

local function collectMessages(ctx)
    for _, rule in ipairs(dispatch) do
        if rule.check(ctx.owner) then
            return rule.fn(ctx)
        end
    end
end

function ShowMessage(ctx)
    if not sectionMisc:get("enableMessages") then return end

    local result   = collectMessages(ctx)
    local messages = result[1] or result.messages
    local weights  = result[2] or result.weights
    if not messages or not weights then return end

    -- Pick a random group based on weight
    local r = math.random()
    local cumulative = 0
    local chosenGroup = nil

    for group, weight in pairs(weights) do
        cumulative = cumulative + weight
        if r <= cumulative then
            chosenGroup = group
            break
        end
    end
    if not chosenGroup then return end

    -- Pick a random message
    local groupMessages = messages[chosenGroup]
    if not groupMessages or #groupMessages == 0 then return end

    local index = math.random(1, #groupMessages)
    ui.ShowMessage(groupMessages[index])
end
