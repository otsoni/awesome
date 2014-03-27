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

function list_devices ()
    devices = {}
    devices[1] = {}
    devices[1][1] = "Analog audio"
    devices[1][2] = "pacmd set-card-profile 0 output:analog-stereo"
    next_index = 2
    hdmi_connected = get_connected_HDMI()
    for i=1,3 do
        if hdmi_connected == 1 then
            local ending = ""
            if i > 1 then
                ending = "-extra"..i-1
            end
            devices[next_index][1] = "HDMI "..i
            devices[next_index][2] = "pacmd set-card-profile 0 output:hdmi-stereo"..ending
            next_index = next_index+1
        end
    end
    return devices
end
