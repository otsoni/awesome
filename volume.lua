local io = io
local string = string

module("volume")

channel = "Master"

function up (widget)
    io.popen("amixer -D pulse sset " .. channel .. " 5%+"):read("*all")
    update(widget)
end

function down (widget)
    io.popen("amixer -D pulse sset " .. channel .. " 5%-"):read("*all")
    update(widget)
end

function mute (widget)
    io.popen("amixer -D pulse sset " .. channel .. " toggle"):read("*all")
    update(widget)
end

function update (widget)
    local famix = io.popen("amixer -D pulse sget " .. channel)
    local status = famix:read("*all")
    famix:close()

    local volume = string.match(status, "(%d?%d?%d)%%")
    volume = string.format("% 3d", volume)
    
    status = string.match(status, "%[(o[^%]]*)%]")

    if string.find(status, "on", 1, true) then
        volume = "🔉" .. volume .. "% "
    else
        volume = "🔇" .. volume .. "% "
    end
    widget.text = volume
end
