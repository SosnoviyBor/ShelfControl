local types = require("openmw.types")
local world = require("openmw.world")

local function getBookOwner(ownerRecordId)
    for _, activeActor in ipairs(world.activeActors) do
        if activeActor.recordId == ownerRecordId then
            return activeActor
        end
    end
end

local function getBookOwnerDisposition(owner, player)
    owner.disposition = types.NPC.getDisposition(owner.self, player)
    return owner.disposition
end

local function bookHasAnOwner(book, owner)
    -- checking only owner record might backfire me in the ass
    -- yolo
    owner.recordId = book.owner.recordId
    return owner.recordId
end

local function bookOwnerSellsBooks(owner)
    owner.record = types.NPC.record(owner.recordId)
    owner.sellsBooks = owner.record.servicesOffered["Books"]
    return owner.sellsBooks
end

local function bookOwnerIsDead(owner)
    owner.self = getBookOwner(owner.recordId)
    -- if owner is not in the same cell, then it's a fair game
    if not owner.self then return true end
    owner.isDead = types.Actor.isDead(owner)
    return owner.isDead
end

function IsOwned(book, owner, player)
    if not bookHasAnOwner(book, owner) then return false end
    if bookOwnerIsDead(owner) then return false end
    owner.disposition = getBookOwnerDisposition(owner, player)
    return true
end

function IsBuyable(book, owner, player)
    if not bookHasAnOwner(book, owner) then return false end
    if not bookOwnerSellsBooks(owner) then return false end
    if bookOwnerIsDead(owner) then return false end
    owner.disposition = getBookOwnerDisposition(owner, player)
    return true
end