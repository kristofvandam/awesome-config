local vicious = require("../vicious")
local wibox   = require("wibox")
local gears   = require("gears")
require("../modules.widget")


local function pill_color()
    battery_level = tonumber(vicious.call(vicious.widgets.bat, "$2", "BAT0"))
    if     (battery_level < 5) then
        return "#f15a5bff"
    elseif (battery_level <= 99) then
        return "#fec35aff"
    else
        return "#20bec6ff"
    end
end

local textbox = wibox.widget.textbox()
battery       = pill(textbox, pill_color())

local timer   = gears.timer.start_new(1, function()
    battery:emit_signal("battery::redraw_needed")
end)

timer:emit_signal("timeout")

-- battery = update_batter(textbox)

-- Register battery widget
vicious.register(textbox, vicious.widgets.bat, "$2%", 61, "BAT0")



return battery