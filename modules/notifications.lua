local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local naughty = require('naughty')
local dpi = beautiful.xresources.apply_dpi

screen.connect_signal("request::desktop_decoration", function(s)

  local panel_width = dpi(300)
  local notify_center = wibox({
    ontop = true,
    stretch = false,
    width = panel_width,
    height = s.workarea.height,
    visible = false,
    y = beautiful.panel_height,
    x = s.workarea.width - panel_width
  })

  notify_center:setup {
    -- Add a button to dismiss all notifications, because why not.
    {
      {
        text   = 'Dismiss all',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
      },
      buttons = gears.table.join(
      awful.button({ }, 1, function() naughty.destroy_all_notifications() end)
      ),
      forced_width       = 75,
      shape              = gears.shape.rounded_bar,
      shape_border_width = 1,
      shape_border_color = beautiful.bg_highlight,
      widget = wibox.container.background
    },
    {
      base_layout = wibox.widget {
        spacing_widget = wibox.widget {
          orientation = 'vertical',
          span_ratio  = 0.5,
          widget      = wibox.widget.separator,
        },
        forced_height = 30,
        spacing       = 3,
        layout        = wibox.layout.fixed.vertical
      },
      widget_template = {
        {
          naughty.widget.icon,
          {
            naughty.widget.title,
            naughty.widget.message,
            {
              layout = wibox.widget {
                -- Adding the wibox.widget allows to share a
                -- single instance for all spacers.
                spacing_widget = wibox.widget {
                  orientation = 'horizontal',
                  span_ratio  = 0.9,
                  widget      = wibox.widget.separator,
                },
                spacing = 3,
                layout  = wibox.layout.flex.horizontal
              },
              widget = naughty.list.widgets,
            },
            layout = wibox.layout.align.vertical
          },
          spacing = 10,
          fill_space = true,
          layout  = wibox.layout.fixed.horizontal
        },
        margins = 5,
        widget  = wibox.container.margin
      },
      widget = naughty.list.notifications,
    },
    layout = wibox.layout.align.vertical
  }


  local notify_center_trigger = awful.wibar({
    position = "right",
    width = 1,
    bg = "#00000000",
    opacity = 0,
    ontop = true,
    visible = true
  })

  local notify_center_hide_timer = gears.timer({ timeout = 1})

  notify_center_trigger:geometry({ width = 5, height = s.workarea.height })
  notify_center_hide_timer:connect_signal("timeout", function() notify_center.visible = false; notify_center_hide_timer:stop() end )
  notify_center_trigger:connect_signal("mouse::enter", function() notify_center.visible = true end)
  notify_center:connect_signal("mouse::enter", function() if notify_center_hide_timer.started then notify_center_hide_timer:stop() end end)
  notify_center:connect_signal("mouse::leave", function() notify_center_hide_timer:again() end)

end)
