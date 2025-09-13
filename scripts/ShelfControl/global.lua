local storage = require("openmw.storage")
local I = require("openmw.interfaces")
local types = require("openmw.types")

require("scripts.ShelfControl.bookStatusChecker")
require("scripts.ShelfControl.messageManager")

local sectionBuyable = storage.globalSection("ShelfControl_buyable")
local sectionOwned = storage.globalSection("ShelfControl_owned")
local sectionMisc = storage.globalSection("ShelfControl_misc")

I.Activation.addHandlerForType(types.Book, function(book, actor)
    -- player need to activate the book
    if not types.Player.objectIsInstance(actor) then return true end
    if sectionMisc:get("ignoreBooksWithMWScripts") and book.record.mwscript then return true end

    ---@class owner
    ---@field recordId string
    ---@field record any
    ---@field sellsBooks boolean
    ---@field self any
    ---@field isDead boolean
    ---@field disposition number
    local owner = {}

    if sectionBuyable:get("supressBuyable") and IsBuyable(book, owner, actor)
       and sectionBuyable:get("buyableMinimumDisposition") <= owner.disposition then
        if sectionMisc:get("enableMessages") then
            ShowMessage(owner, BUYABLE)
        end
        return false

    elseif sectionOwned:get("supressOwned") and IsOwned(book, owner, actor)
       and sectionBuyable:get("ownedMinimumDisposition") <= owner.disposition then
        if sectionMisc:get("enableMessages") then
            ShowMessage(owner, OWNED)
        end
        return false

    else
        return true
    end
end)
