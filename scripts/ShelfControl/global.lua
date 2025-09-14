local storage = require("openmw.storage")
local I = require("openmw.interfaces")
local types = require("openmw.types")

require("scripts.ShelfControl.bookChecker")
require("scripts.ShelfControl.cellChecker")
require("scripts.ShelfControl.messageManager")
require("scripts.ShelfControl.model.owner")

local sectionBuyable = storage.globalSection("ShelfControl_buyable")
local sectionOwned = storage.globalSection("ShelfControl_owned")
local sectionMisc = storage.globalSection("ShelfControl_misc")

local function handleBlocked(owner, reason)
    if sectionMisc:get("enableMessages") then
        ShowMessage(reason)
    end
    if sectionMisc:get("enableDebug") then
        PrintOwnerInfo(owner)
    end
    return false
end

local function onBookActivation(book, actor)
    if not types.Player.objectIsInstance(actor) then
        return true
    end

    if sectionMisc:get("ignoreBooksWithMWScripts")
       and types.Book.record(book).mwscript then
        return true
    end

    local owner = CollectOwnerData(book, actor)

    -- Buyable books check
    if sectionBuyable:get("supressBuyable")
       and IsBuyable(owner)
       and sectionBuyable:get("buyableMinimumDisposition") > owner.disposition
       and not LocationIsWhitelisted(book, owner) then
        return handleBlocked(owner, BUYABLE)
    end

    -- Owned books check
    if sectionOwned:get("supressOwned")
       and IsOwned(owner)
       and sectionOwned:get("ownedMinimumDisposition") > owner.disposition
       and not LocationIsWhitelisted(book, owner) then
        return handleBlocked(owner, OWNED)
    end

    -- Fallback: allowed
    if sectionMisc:get("enableDebug") then
        PrintOwnerInfo(owner)
    end
    return true
end

I.Activation.addHandlerForType(types.Book, onBookActivation)
