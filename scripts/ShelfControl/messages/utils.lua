local function tableIsEmptyOrFalse(tbl)
    if type(tbl) ~= "table" then
        return tbl == false
    end
    for _, v in pairs(tbl) do
        if type(v) == "table" then
            if not tableIsEmptyOrFalse(v) then
                return false
            end
        elseif v ~= false then
            return false
        end
    end
    return true
end

function PruneMessageGroups(messages, weights)
    for key, weight in pairs(weights) do
        if weight == 0 or (messages[key] ~= nil and tableIsEmptyOrFalse(messages[key])) then
            messages[key] = nil
            weights[key] = nil
        end
    end
end

function CollectAllMessagesByPrefix(prefix, l10n)
    local msgs = {}
    for i = 1, MAXINT do
        local key = prefix .. "_" .. tostring(i)
        local msg = l10n(key)
        if msg ~= key then
            table.insert(msgs, msg)
        else
            break
        end
    end
    return msgs
end
