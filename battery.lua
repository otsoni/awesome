local io = io
local math = math

module("battery")

function get_bat_state (adapter)
    local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
    local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
    local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
    local cur = fcur:read()
    local cap = fcap:read()
    local sta = fsta:read()
    fcur:close()
    fcap:close()
    fsta:close()
    local battery = math.floor(cur * 100 / cap)
    if sta:match("Charging") then
        dir = 1
    elseif sta:match("Discharging") then
        dir = -1
    else
        dir = 0
        battery = ""
    end
    return battery, dir
end


function batclosure (adapter)
    return function ()
        local prefix = "⚡"
        local battery, dir = get_bat_state(adapter)
        if dir == -1 then
            dirsign = "↓"
            prefix = "Bat:"
        elseif dir == 1 then
            dirsign = "↑"
            prefix = "Bat:"
        else
            dirsign = ""
        end
        if dir ~= 0 then battery = battery.."%" end
        return prefix..dirsign..battery..dirsign.." "
    end
end
