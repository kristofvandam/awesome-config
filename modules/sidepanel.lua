local awful = require('awful')
local wibox = require('wibox')
local timer = require("gears.timer")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

screen.connect_signal("request::desktop_decoration", function(s)
    local dock = awful.wibox({
        x = s.workarea.width,
        y = 0,
        ontop = true,
        stretch = false,
        width = dpi(64),
        height = s.workarea.height,
        visible = false
        })
    local dock_trigger = awful.wibox({
        position = "left",
        width = 1,
        bg = "#00000000",
        opacity = 0,
        ontop = true,
        visible = true
    })
    local dock_hide_timer = timer({ timeout = 1})
    
    dock_trigger:geometry({ width = 5, height = s.workarea.height })
    dock_hide_timer:connect_signal("timeout", function() dock.visible = false; dock_hide_timer:stop() end )
    
    dock_trigger:connect_signal("mouse::enter", function() dock.visible = true end)
    dock:connect_signal("mouse::enter", function() if dock_hide_timer.started then dock_hide_timer:stop() end end)
    dock:connect_signal("mouse::leave", function() dock_hide_timer:again() end)
end)