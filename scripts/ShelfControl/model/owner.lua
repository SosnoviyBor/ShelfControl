local types = require("openmw.types")
local storage = require("openmw.storage")

require("scripts.ShelfControl.utils")

local sectionMisc = storage.globalSection("ShelfControl_misc")

--- Collect information about a book's owner.
--- @param book any   The book being inspected.
--- @param player any The player actor reference.
--- @return table owner A table containing all known owner information.
function CollectOwnerData(book, player)
    --[[
        Owner table schema:

        owner = {
            recordId     = string|nil,  -- The NPC's record ID (if the book has a direct owner).
            factionId    = string|nil,  -- The owning faction's ID (if faction-owned).
            self         = Actor|nil,   -- The active actor reference in the current cell (nil if not loaded).
            isDead       = boolean,     -- Whether the owner is dead (or not in the same cell → treated as dead).
            disposition  = integer,     -- Disposition of the owner towards the player (-1 if unavailable).
            sellsBooks   = boolean,     -- Whether the owner sells books.
        }
    ]]

    local owner = {
        recordId    = book.owner and book.owner.recordId or nil,
        factionId   = book.owner and book.owner.factionId or nil,
        disposition = -1,
    }

    -- Active actor reference
    if owner.recordId then
        owner.self = GetActiveActorByRecordId(owner.recordId)
    end

    -- Dead check
    if owner.self then
        owner.isDead = types.Actor.isDead(owner.self)
        owner.disposition = types.NPC.getDisposition(owner.self, player)
    else
        owner.isDead = true -- not in same cell = fair game
    end

    -- Services check
    if owner.recordId and not owner.factionId then
        owner.record = types.NPC.record(owner.recordId)
        owner.sellsBooks = owner.record.servicesOffered["Books"] or false
    else
        owner.sellsBooks = false
    end

    PrintOwnerInfo(owner)
    return owner
end

function PrintOwnerInfo(owner)
    if not sectionMisc:get("enableDebug") then return end
    print("\nCurrent book owner info" ..
        "\nrecordId ->      " .. tostring(owner.recordId) ..
        "\nfactionId ->     " .. tostring(owner.factionId) ..
        "\nrecord ->        " .. tostring(owner.record) ..
        "\nsellsBooks ->    " .. tostring(owner.sellsBooks) ..
        "\nself ->          " .. tostring(owner.self) ..
        "\nisDead ->        " .. tostring(owner.isDead) ..
        "\ndisposition ->   " .. tostring(owner.disposition)
    )
end
