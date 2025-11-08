MAXINT = 2 ^ 53

-- +----------------------------------+
-- | Consts for buyable book messages |
-- +----------------------------------+

CitiesWithOrdinators = {
    "vivec",
    "mournhold",
    "necrom",
}
MANY_VENDORS_THRESHOLD = 3
LOW_DISPOSITION = 30

-- +------------------------------------+
-- | Consts for NPC owned book messages |
-- +------------------------------------+

MagicClasses = {
    -- criteria for adding is:
    -- Specialization: Magic
    -- And at least 3/5 major skills need to be magic (may have exceptions)

    -- vanilla playable
    battlemage = true,
    healer = true,
    mage = true,
    nightblade = true,
    sorcerer = true,
    spellsword = true,
    witchhunter = true,
    -- vanilla NPC
    alchemist = true,
    enchanter = true,
    ["guild guide"] = true,
    mabrigash = true,
    necromancer = true,
    priest = true,
    warlock = true,
    ["wise woman"] = true,
    witch = true,
    -- bloodmoon NPC
    shaman = true,
    -- TD
    astrologer = true,
    naturalist = true,
    ["clever-man"] = true,
}
LOW_INT = 30
HIGH_ENCH = 75
