local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local cairo = require("lgi").cairo
local dpi = beautiful.xresources.apply_dpi

local widget_pill_top_left                                            = gears.surface(beautiful.widget_pill_top_left)
local widget_pill_top_right                                           = gears.surface(beautiful.widget_pill_top_right)
local widget_pill_bottom_left                                         = gears.surface(beautiful.widget_pill_bottom_left)
local widget_pill_bottom_right                                        = gears.surface(beautiful.widget_pill_bottom_right)
local widget_pill_top_left_width, widget_pill_top_left_height         = gears.surface.get_size(widget_pill_top_left)
local widget_pill_top_right_width, widget_pill_top_right_height       = gears.surface.get_size(widget_pill_top_right)
local widget_pill_bottom_left_width, widget_pill_bottom_left_height   = gears.surface.get_size(widget_pill_bottom_left)
local widget_pill_bottom_right_width, widget_pill_bottom_right_height = gears.surface.get_size(widget_pill_bottom_right)

function pill(content, color)
  local color_default = "#00ff00"

  local function compose_background(_, cr, width, height)
  
    cr:push_group_with_content(cairo.Content.ALPHA)
  
    -- draw top left
    cr:set_source_surface(widget_pill_top_left, 0, 0)
    cr:paint()
  
    -- draw top right
    cr:set_source_surface(widget_pill_top_right, width - widget_pill_top_right_width, 0)
    cr:paint()
  
    -- draw bottom left
    cr:set_source_surface(widget_pill_bottom_left, 0, height - widget_pill_bottom_left_height)
    cr:paint()
  
    -- draw bottom right
    cr:set_source_surface(widget_pill_bottom_right, width - widget_pill_bottom_right_width, height - widget_pill_bottom_left_height)
    cr:paint()
  
    -- fill horizontal
    cr:set_source_rgba(0,0,0,1)
    cr:rectangle(0, widget_pill_top_left_height, width, height - (widget_pill_top_left_height + widget_pill_bottom_left_height))    
    cr:fill()
  
    -- fill vertical
    cr:set_source_rgba(0,0,0,1)
    cr:rectangle(widget_pill_top_left_width, 0, width - (widget_pill_top_left_width + widget_pill_top_right_width), height)    
    cr:fill()
  
    local mask = cr:pop_group()
    
    cr:set_operator(cairo.Operator.SOURCE)
    cr:set_source_rgba(gears.color.parse_color(color or color_default))
    cr:rectangle(0, 0, width, height)
  
    cr:mask(mask)
  end

  return wibox.container {
    {
      {
        content,
        left    = dpi(10),
        right   = dpi(10),
        top     = dpi(5),
        bottom  = dpi(5),
        widget  = wibox.container.margin
      },
      bgimage   = compose_background,
      widget    = wibox.container.background
    },
    left    = dpi(2),
    right   = dpi(2),
    top     = dpi(2),
    bottom  = dpi(2),
    widget = wibox.container.margin
  }
end

