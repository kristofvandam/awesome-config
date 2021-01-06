local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local timer = require("gears.timer")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

screen.connect_signal("appdrawer::open", function(s)

  local drawer = wibox({
    position = "left",
    ontop = true,
    stretch = false,
    width = dpi(64),
    height = s.workarea.height,
    visible = true,
    y = 48
  })

  drawer:setup {
    expand = "none",
    layout = wibox.layout.align.vertical,
  }

end)
