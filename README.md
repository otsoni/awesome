# awesome widgets

Mostly widgets that I use every day

## install

You need to put those .lua files in the directory where rc.lua is stored

Also add some lines to rc.lua

For battery widget

```lua
require("battery")

batterywidget = widget({ type = "textbox", name = "batterywidget", align = "right" })

bat_clo = battery.batclosure("BAT0")
batterywidget.text = bat_clo()
batterytimer = timer({ timeout = 30 })
batterytimer:add_signal("timeout", function() batterywidget.text = bat_clo() end)
batterytimer:start()
```

And for volume widget


```lua
require("volume")

volumewidget = widget({ type = "textbox", name = "volumewidget", align = "right" })
volumewidget:buttons({
    button({ }, 4, function () volume.up(volumewidget) end),
    button({ }, 5, function () volume.down(volumewidget) end),
    button({ }, 3, function () volume.mute(volumewidget) end)
})
volume.update(volumewidget)
volumetimer = timer({ timeout = 10 })
volumetimer:add_signal("timeout", function() volume.update(volumewidget) end)
volumetimer:start()
```

And you need to add those widgets to your wibox of course.

You can add key bindings for media buttons for volume widget.

```lua
awful.key({ }, "#123",function () volume.up(volumewidget) end),
awful.key({ }, "#122",function () volume.down(volumewidget) end),
awful.key({ }, "#121",function () volume.mute(volumewidget) end)
```
