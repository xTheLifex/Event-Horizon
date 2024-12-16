ev.faction = ev.faction or {}
ev.faction.teams = ev.faction.teams or {}
ev.faction.indices = ev.faction.indices or {}


--- Loads factions from a directory.
-- @realm shared
-- @string directory The path to the factions files.
function ev.faction.LoadFromDir(directory)
    printv(string.format("Loading factions from directory: %s", directory))
    for _,v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
        local niceName = v:sub(4, -5)

        FACTION = ev.faction.teams[niceName] or {index = table.Count(ev.faction.teams) + 1}
            ev.util.Include(directory.."/"..v, "shared")

            if (!FACTION.name) then
                FACTION.name = "Unknown"
                ErrorNoHalt("Faction '"..niceName.."' is missing a name. You need to add a FACTION.name = \"Name\"\n")
            end

            if (!FACTION.color) then
                FACTION.color = Color(150, 150, 150)
                ErrorNoHalt("Faction '"..niceName.."' is missing a color. You need to add FACTION.color = Color(1, 2, 3)\n")
            end

            team.SetUp(FACTION.index, FACTION.name or "Unknown", FACTION.color or Color(125, 125, 125))

            FACTION.uniqueID = FACTION.uniqueID or niceName

            ev.faction.indices[FACTION.index] = FACTION
            ev.faction.teams[niceName] = FACTION
            printv(string.format("Loaded faction [%s] with ID [%s]", niceName, FACTION.index))
        FACTION = nil
    end
end

--- Retrieves a faction table.
-- @realm shared
-- @param identifier Index or name of the faction
-- @treturn table Faction table
-- @usage print(ev.faction.Get(Entity(1):Team()).name)
-- > "Citizen"
function ev.faction.Get(identifier)
	return ev.faction.indices[identifier] or ev.faction.teams[identifier]
end

--- Retrieves a faction index.
-- @realm shared
-- @string uniqueID Unique ID of the faction
-- @treturn number Faction index
function ev.faction.GetIndex(uniqueID)
	for k, v in ipairs(ev.faction.indices) do
		if (v.uniqueID == uniqueID) then
			return k
		end
	end
end