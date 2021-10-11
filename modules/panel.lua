local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local lain      = require('../lain')

local bat = lain.widget.bat {
  settings = function()
    widget:set_markup("BAT " .. bat_now.perc .. "% ")
  end
}

local sysload = lain.widget.sysload {
  settings = function()
    widget:set_markup("LOAD " .. load_1 .. ", " .. load_5 .. ", " .. load_15 .. " ")
  end
}

local cpu = lain.widget.cpu {
  settings = function()
    widget:set_markup("CPU " .. cpu_now.usage .. "% ")
  end
}

local mem = lain.widget.mem {
  settings = function()
    widget:set_markup("MEM " .. mem_now.perc .. "% ")
  end
}

local net = lain.widget.net {
  settings = function()
    widget:set_markup("NET " .. net_now.sent .. "B/" .. net_now.received .. "B ")
  end
}

modkey = "Mod4"

screen.connect_signal("request::desktop_decoration", function(s)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top" ,height = beautiful.panel_height, screen = s })

  -- Each screen has its own tag table.
  awful.tag({ "main", "term", "dev", "browse", "social", "misc" }, s, awful.layout.layouts[1])

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    widget_template = {
      {
        {
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 18,
        right = 18,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
    buttons = {
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end),
    }
  }

  -- Add widgets to the wibox
  s.mywibox.widget = {
    layout = wibox.layout.stack,
    {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
      },
      nil,
      {
        layout = wibox.layout.fixed.horizontal,
        cpu,
        mem,
        -- net,
        bat,
        -- sysload,
        -- wibox.widget.systray(),
      }
    },
    { -- Right widgets
      layout = wibox.container.place,
      valign = "center",
      halign = "center",
      wibox.widget.textclock
    },
  }
end)

