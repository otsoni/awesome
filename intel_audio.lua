local io = io
local string = string

module("intel_audio")

function get_connected_HDMI ()
    connected = {}
    -- I have three HDMI ports in my laptop, that's why from 1 to 3
    -- You can find count of your ports by checking "ls /sys/class/drm"
    for i=1,3 do
        local fd = io.open("/sys/class/drm/card0-HDMI-A-"..i.."/status")
        local status = fd:read()
        fd:close()
        if status:match("connected") then
            connected[i] = 1
        else
            connected[i] = 0
        end
    end
    return connected
end
