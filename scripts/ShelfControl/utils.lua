local world = require("openmw.world")

BUYABLE = "buyable"
OWNED = "owned"

function GetActiveActorByRecordId(recordId)
    for _, activeActor in ipairs(world.activeActors) do
        if activeActor.recordId == recordId then
            return activeActor
        end
    end
end