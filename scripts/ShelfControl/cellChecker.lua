local types = require("openmw.types")

require("scripts.ShelfControl.model.owner")

local whitelistedCellNames = {
    "library",
    "temple",
    "chapel",
    "shrine",
}
local blacklistedCells = {
    -- ["example"] = true,
}

local function itsACultShrine(cell, owner)
    -- if cult srine is nearby
    for _, activator in pairs(cell:getAll(types.Activator)) do
        if types.Activator.record(activator).mwscript ~= "shrineimperial" then goto continue end
        -- if owner is imperical cult member
        -- or if owner is a priest (class description says they work at imperial shrines + it make sense)
        -- on an unrelated note: why TF Vala Catraso is not a member of the cult???
        local cultRank = types.NPC.getFactionRank(owner.self, "imperial cult")
        if cultRank > 0 or owner.record.class == "priest" then return true end
        ::continue::
    end
    return false
end

function LocationIsWhitelisted(book, owner)
    local cell = book.cell
    local cellName = string.lower(cell.name)

    if blacklistedCells[cellName] then return false end

    for _, namePart in pairs(whitelistedCellNames) do
        if string.find(cellName, namePart) then
            return true
        end
    end
    -- double check if it's a cult shrine
    if owner.self and itsACultShrine(cell, owner) then return true end

    return false
end