local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local timer = require("gears.timer")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

screen.connect_signal("request::desktop_decoration", function(s)

    local entries = {
      {
        name = "firefox",
        command = "firefox"
      },
      {
        name = "terminal",
        command = "alacritty"
      },
      {
        name = "slack",
        command = "slack"
      },
      {
        name = "inkscape",
        command = "inkscape"
      }
    }

    local dock = wibox({
        position = "left",
        ontop = true,
        stretch = false,
        width = dpi(64),
        height = s.workarea.height,
        visible = false,
        y = beautiful.panel_height
    })


--[[   client.connect_signal("manage", function(c)
      local completed_entries = {}
      for entry in pairs(entries) do
        if c.name:lower():match(entry.name:lower()) then
          completed_entries[entry] = {}
          completed_entries[entry].count = completed_entries[entry].count + 1
        else
          entry[count] = 1
          table.insert(completed_entries, entry)
        end
      end
    end) ]]--

    s.mytasklist = awful.widget.tasklist {
          screen = s,
    filter = function() return true end, -- Filtering is already done in source
    source = function()
        -- Get all clients
        local cls = client.get()

        -- Filter by an existing filter function and allowing only one client per class
        local result = {}
        local class_seen = {}
        for _, c in pairs(cls) do
            if awful.widget.tasklist.filter.allscreen(c, s) then
                if not class_seen[c.class] then
                    class_seen[c.class] = true
                    table.insert(result, c)
                end
            end
        end
        return result
    end,
    --screen   = s,
    --filter   = awful.widget.tasklist.filter.allscreen,
    buttons = {
      awful.button({ }, 1, function (c)

        if cl_menu then
          cl_menu:hide()
          cl_menu=nil
        else
          client_num=0
          client_list={}
          for i, cl in pairs(client.get()) do
            if cl.class == c.class then
              client_num = client_num + 1
              client_list[i]=
              {cl.name,
              function()
                client.focus = cl
                awful.tag.viewonly(cl:tags()[1])
                cl:raise()
              end,
              cl.icon
            }
          end
        end

        if client_num > 1 then
          cl_menu=awful.menu({items = client_list, theme = {width=900}})
          cl_menu.align = "left"
          cl_menu.mode = "outside"
          cl_menu.preferred_positions = {"left"}
          cl_menu.preferred_alignments = {"middle"}
          cl_menu:show()
        else
          client.focus = c
          awful.tag.viewonly(c:tags()[1])
          c:raise()
        end
      end
    end),

    --awful.button({ }, 1, function (c)
    --c:activate { context = "tasklist", action = "toggle_minimization" }
    --local t = c.first_tag
    --t:view_only()
    --end),
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
  {
    s.mytasklist,
    awful.widget.launcher({
      image = beautiful.apps_slack,
      command = "slack"
    }),
    layout = wibox.layout.align.vertical
  }
}

local dock_trigger = awful.wibar({
  position = "left",
  width = 1,
  bg = "#00000000",
  opacity = 0,
  ontop = true,
  visible = true
})

local dock_hide_timer = gears.timer({ timeout = 1})

dock_trigger:geometry({ width = 5, height = s.workarea.height })
dock_hide_timer:connect_signal("timeout", function() dock.visible = false; dock_hide_timer:stop() end )
dock_trigger:connect_signal("mouse::enter", function() dock.visible = true end)
dock:connect_signal("mouse::enter", function() if dock_hide_timer.started then dock_hide_timer:stop() end end)
dock:connect_signal("mouse::leave", function() dock_hide_timer:again() end)

end)
