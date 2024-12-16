GM.Name = "Event Horizon"
GM.Author = "TheLife"
GM.Email = "N/A"
GM.Website = "N/A"
GM.Version = "indev"

if (not ev.reloaded) then
    print("--------------------------------------------------------------------------")
    print("                                EVENT HORIZON                             ")
    print("--------------------------------------------------------------------------")
else
    print("Reloading Event Horizon...")
end

ev.util.IncludeDir("core/libs/thirdparty")
ev.util.IncludeDir("core/libs")
ev.util.IncludeDir("core/derma")
ev.util.IncludeDir("core/hooks")

function GM:OnReloaded()
    ev.reloaded = true
end