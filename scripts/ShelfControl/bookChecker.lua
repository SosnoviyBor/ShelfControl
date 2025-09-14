--- Check if a book is considered *owned* by someone/faction.
--- A book is owned if:
---   - It is owned by a faction, OR
---   - It has a living NPC owner.
--- Dead or unloaded NPCs don't count as owners.
---
--- @param owner any  Info about book's owner.
--- @return boolean   True if the book is owned.
function IsOwned(owner)
    if not owner.recordId and not owner.factionId then return false end
    if owner.factionId then return true end
    if owner.isDead then return false end
    return true
end

--- Check if a book is considered *buyable*.
--- A book is buyable if:
---   - It has a living NPC owner,
---   - The owner sells books,
---   - It is not faction-owned.
--- Dead or unloaded NPCs don't count as owners.
---
--- @param owner any  Info about book's owner.
--- @return boolean   True if the book is buyable.
function IsBuyable(owner)
    if not owner.recordId then return false end
    if owner.factionId then return false end
    if not owner.sellsBooks then return false end
    if owner.isDead then return false end
    return true
end