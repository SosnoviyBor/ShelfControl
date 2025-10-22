local storage = require("openmw.storage")
local I = require("openmw.interfaces")
local types = require("openmw.types")

require("scripts.ShelfControl.bookChecker")
require("scripts.ShelfControl.cellChecker")
require("scripts.ShelfControl.model.owner")
require("scripts.ShelfControl.utils")

local sectionBuyable = storage.globalSection("ShelfControl_buyable")
local sectionOwned = storage.globalSection("ShelfControl_owned")
local sectionMisc = storage.globalSection("ShelfControl_misc")

local function checkOwnership(section, ownershipChecker, reason, owner, book)
    if section:get("supress")
        and ownershipChecker(owner)
        and section:get("minDisposition") > owner.disposition
        and not LocationIsWhitelisted(book, owner)
    then
        ShowMessage(reason)
        return true
    end
    return false
end

-- true = allow activation, false = block activation
local function onBookActivation(book, actor)
    -- if not player
    if not types.Player.objectIsInstance(actor) then return true end
    -- if book has an mwscript attached and ignore setting is on
    if sectionMisc:get("ignoreBooksWithMWScripts")
        and types.Book.record(book).mwscript
    then
        return true
    end

    local owner = CollectOwnerData(book, actor)
    -- check buyable and owned conditions
    if checkOwnership(sectionBuyable, IsBuyable, BUYABLE, owner, book)
        or checkOwnership(sectionOwned, IsOwned, OWNED, owner, book)
    then
        return false
    end

    return true
end

I.Activation.addHandlerForType(types.Book, onBookActivation)
