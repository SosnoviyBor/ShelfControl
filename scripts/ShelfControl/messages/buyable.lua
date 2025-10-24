local core = require("openmw.core")

local l10n = core.l10n("ShelfControl_msgVendors")

function CollectBuyableMessages(ctx)
    local messages = {
        ["generic"] = l10n("generic"),
        ["specific"] = nil,
        ["racialPlayer"] = nil,
        ["racialVendor"] = nil,
    }
    local weights = {
        ["generic"] = 30,
        ["specific"] = 50,
        ["racialPlayer"] = 10,
        ["racialVendor"] = 10,
    }

    local generic
    -- racial
    local vendorRace
    local playerRace
    -- specific
    local isCaiusMet
    local ownedByJobasha
    local ordinatorsNearby
    local multipleVendorsNearby

    -- truncate weights for message groups that have no messages collected
    for group, _ in pairs(weights) do
        if not messages[group] then
            weights[group] = nil
        end
    end

    return { messages, weights }
end
