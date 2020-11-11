local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

client.connect_signal("request::titlebars", function(c)
  local buttons = {
    awful.button({ }, 1, function()
      c:activate { context = "titlebar", action = "mouse_move"  }
    end),
    awful.button({ }, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize"}
    end),
  }

  local titlebar_image_top    = gears.surface(beautiful.titlebar_image_top)
  local titlebar_image_middle = gears.surface(beautiful.titlebar_image_middle)
  local titlebar_image_bottom = gears.surface(beautiful.titlebar_image_bottom)
  local titlebar_image_top_width, titlebar_image_top_height       = gears.surface.get_size(titlebar_image_top)
  local titlebar_image_middle_width, titlebar_image_middle_height = gears.surface.get_size(titlebar_image_middle)
  local titlebar_image_bottom_width, titlebar_image_bottom_height = gears.surface.get_size(titlebar_image_bottom)
  local function bg_image_function(_, cr, width, height)
    -- draw vertical top image
    cr:set_source_surface(titlebar_image_top, 0, 0)
    cr:paint()

    -- clip/mask the filing middle image
    cr:save()
    local mask_height = height - titlebar_image_top_height - titlebar_image_bottom_height
    cr:set_source_rgba(0,1,0,1)
    cr:rectangle(0, titlebar_image_top_height, width, mask_height)
    cr:clip()

    for count=1, math.floor(height / titlebar_image_middle_height), 1 do
      cr:set_source_surface(titlebar_image_middle, 0, count * titlebar_image_middle_height)
      cr:paint()
    end
    cr:restore()

    -- draw vertical bottom image
    cr:set_source_surface(titlebar_image_bottom, 0, height - titlebar_image_bottom_height)
    cr:paint()
  end

  local function decorate_titlebar(c, pos, bg, size)
    print('Decorating titlebar')
    c.titlebar_position = pos
    local args = {
      size = beautiful.titlebar_size or titlebar_image_middle_width,
      position = 'left',
      bg_normal = '#FFFFFF00',
      bg_focus = '#FFFFFF00',
      bgimage_normal = bg_image_function,
      bgimage_focus = bg_image_function
    }
    awful.titlebar(c, args) : setup {
      { -- Top
        {
          awful.titlebar.widget.closebutton(c),
          awful.titlebar.widget.minimizebutton(c),
          awful.titlebar.widget.maximizedbutton(c),
          spacing = dpi(beautiful.titlebar_button_spacing),
          layout = wibox.layout.fixed.vertical
        },
        left    = dpi(beautiful.titlebar_button_margin_left),
        right   = dpi(beautiful.titlebar_button_margin_right),
        top     = dpi(beautiful.titlebar_button_margin_top),
        bottom  = dpi(beautiful.titlebar_button_margin_bottom),
        widget  = wibox.container.margin
      },
      { -- Middle
        wibox.container {
          { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
          }, 
          direction = 'east',
          widget    = wibox.container.rotate
        },
        buttons = buttons,
        layout  = wibox.layout.flex.vertical
      },
      { -- Bottom
        {
          awful.titlebar.widget.ontopbutton(c),
          awful.titlebar.widget.floatingbutton(c),
          spacing = dpi(beautiful.titlebar_button_spacing),
          layout = wibox.layout.fixed.vertical
        },
        left    = dpi(beautiful.titlebar_button_margin_left),
        right   = dpi(beautiful.titlebar_button_margin_right),
        top     = dpi(beautiful.titlebar_button_margin_top),
        bottom  = dpi(beautiful.titlebar_button_margin_bottom),
        widget  = wibox.container.margin
      },
      layout = wibox.layout.align.vertical
    }
  end

  decorate_titlebar(c)
end)

