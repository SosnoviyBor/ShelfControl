local core = require("openmw.core")

local l10n = core.l10n("ShelfControl_msgNPCs")

function CollectNPCOwnedMessages(ctx)
    local messages = {
        ["generic"] = l10n("generic")
    }
    local weights = {
        ["generic"] = 30,
    }

    local generic

    return messages
end