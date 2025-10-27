---Checks if table is empty.
---
---Edgecases:
---
--- - list == nil -> true
---@param list table
---@return boolean
function TableIsEmpty(list)
    if list == nil then
        return true
    end
    return next(list) == nil
end

function AppendArray(dest, src)
    for _, v in ipairs(src) do
        table.insert(dest, v)
    end
end
