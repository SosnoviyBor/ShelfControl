local types = require("openmw.types")

require("scripts.ShelfControl.model.owner")

local function itsACultShrine(cell, owner)
    -- if cult srine is nearby
    for _, activator in pairs(cell:getAll(types.Activator)) do
        if types.Activator.record(activator).mwscript == "shrineimperial" then
            -- if owner is imperical cult member
            for _, ownerFactionId in pairs(types.NPC.getFactions(owner.self)) do
                if ownerFactionId == "imperial cult" then
                    return true
                end
            end
            -- if owner is a priest (class description says they work at imperial shrines + it )
            -- why TF Vala Catraso is not a member of the cult
            if owner.record.class == "priest" then
                return true
            end
        end
    end
end

function LocationIsWhitelisted(book, owner)
    local cell = book.cell
    local cellName = string.lower(cell.name)

    if string.find(cellName, "library") then return true end
    if string.find(cellName, "temple") then return true end
    if string.find(cellName, "chapel") then return true end
    if string.find(cellName, "shrine") then return true end
    if owner.self and itsACultShrine(cell, owner) then return true end

    return false
end