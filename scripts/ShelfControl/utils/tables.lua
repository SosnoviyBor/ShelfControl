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
