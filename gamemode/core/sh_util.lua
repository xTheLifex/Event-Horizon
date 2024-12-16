ev.util = ev.util or {}

/* -------------------------------------------------------------------------- */
/*                                   Include                                  */
/* -------------------------------------------------------------------------- */

function ev.util.Include(fname, realm)
    if (!fname) then
        error("[Event Horizon] No file specified to include.")
        return
    end

    -- Server-side
    if (realm == "server" or fname:find("sv_") and SERVER) then
        return include(fname)
    -- Shared
    elseif (realm == "shared" or fname:find("shared.lua") or fname:find("sh_")) then
        if (SERVER) then AddCSLuaFile(fname) end -- Send file to client if its shared.
        return include(fname)
    -- Client
    elseif(realm == "client" or fname:find("cl_")) then
        if (SERVER) then AddCSLuaFile(fname)
        else
            return include(fname)
        end
    end
end

function ev.util.IncludeDir(directory, fromLua)
	local baseDir = "eventhorizon"


	-- Find all of the files within the directory.
	for _, v in ipairs(file.Find((fromLua and "" or baseDir)..directory.."/*.lua", "LUA")) do
		-- Include the file from the prefix.
		ev.util.Include(directory.."/"..v)
	end
end

/* -------------------------------------------------------------------------- */
/*                                   Logging                                  */
/* -------------------------------------------------------------------------- */

ev.util.verbose = GM.version and GM.version == "indev" and true or false

function ev.util.Log(msg)
    print("[Event Horizon] " .. msg)
end

function ev.util.Error(msg)
    error("[Event Horizon] " .. msg)
end

function ev.util.ErrorNoHalt(msg)
    ErrorNoHalt("[Event Horizon] " .. msg)
end

function ev.util.LogVerbose(msg)
    if (ev.util.verbose) then
        ev.util.Log(msg)
    end
end

-- Global for easy typing
printv = ev.util.LogVerbose


/* -------------------------------------------------------------------------- */
/*                                 Pick Random                                */
/* -------------------------------------------------------------------------- */

function ev.util.Pick2(options, weights)
    if not options or #options == 0 then
        return nil
    end
    
    -- If weights are not provided, assume equal chances for all options
    if not weights then
        return options[math.random(1, #options)]
    end
    
    -- Calculate the total weight
    local totalWeight = 0
    for _, weight in ipairs(weights) do
        totalWeight = totalWeight + weight
    end
    
    -- Generate a random number between 0 and the total weight
    local randomValue = math.random() * totalWeight
    
    -- Find the option corresponding to the random value
    local cumulativeWeight = 0
    for i, weight in ipairs(weights) do
        cumulativeWeight = cumulativeWeight + weight
        if randomValue <= cumulativeWeight then
            return options[i]
        end
    end
    
    -- This should never happen, but just in case
    return nil
end


function ev.util.Pick(options)
    if not options or next(options) == nil then
        return nil
    end

    -- Extract keys and values from the options table
    local keys = {}
    local values = {}
    for key, value in pairs(options) do
		if not (isnumber(value)) then
			return util.Pick2(options)
		end
        table.insert(keys, key)
        table.insert(values, value or 1)
    end

    -- Calculate the total weight
    local totalWeight = 0
    for _, weight in ipairs(values) do
        totalWeight = totalWeight + weight
    end

    -- Generate a random number between 0 and the total weight
    local randomValue = math.random() * totalWeight

    -- Find the option corresponding to the random value
    local cumulativeWeight = 0
    for i, weight in ipairs(values) do
        cumulativeWeight = cumulativeWeight + weight
        if randomValue <= cumulativeWeight then
            return keys[i]
        end
    end

    -- This should never happen, but just in case
    return nil
end