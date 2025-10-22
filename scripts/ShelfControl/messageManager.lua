local storage = require("openmw.storage")

local sectionMisc = storage.globalSection("ShelfControl_misc")

function ShowMessage(owner, bookStatus)
    if not sectionMisc:get("enableMessages") then return end
end

local function collectContext(bookStatus)

end