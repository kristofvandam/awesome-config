local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local timer = require("gears.timer")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local thumbnail = require('modules.thumbnail')

screen.connect_signal("request::desktop_decoration", function(s)

    local dock = wibox({
        position = "left",
        ontop = true,
        stretch = false,
        width = dpi(64),
        height = s.workarea.height,
        visible = true,
        y = 48
    })
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.allscreen,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
                local t = c.first_tag
                t:view_only()
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx( 1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx(-1) end),
        },
        layout   = {
            layout  = wibox.layout.fixed.vertical
        },
        widget_template = {
          {
            wibox.widget.base.make_widget(),
            forced_height = 5,
            id            = 'background_role',
            widget        = wibox.container.background,
          },
          {
            {
              id     = 'clienticon',
              widget = awful.widget.clienticon,
            },
            margins = 10,
            widget  = wibox.container.margin
          },
          nil,
          create_callback = function(self, c, index, objects)
            self:get_children_by_id('clienticon')[1].client = c
            local tooltip = awful.tooltip({
              objects = { self },
              timer_function = function()
                return c.name
              end,
            })

            -- Then you can set tooltip props if required (should work as is)
            tooltip.align = "left"
            tooltip.mode = "outside"
            tooltip.preferred_positions = {"left"}
            tooltip.preferred_alignments = {"middle"}
          end,
          layout = wibox.layout.align.vertical,
        },
      }

      dock:setup {
        expand = "none",
        layout = wibox.layout.align.vertical,
        s.mytasklist,
      }
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
