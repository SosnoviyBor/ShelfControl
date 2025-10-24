local storage = require("openmw.storage")

require("scripts.ShelfControl.messages.buyable")
require("scripts.ShelfControl.messages.npcOwned")
require("scripts.ShelfControl.messages.factionOwned")

local sectionMisc = storage.globalSection("ShelfControl_misc")

local dispatch = {
    { check = function(o) return o.recordId end,  fn = CollectNPCOwnedMessages },
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
    local messages, weights = collectMessages(ctx)
end