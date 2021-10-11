local filesystem = require('gears.filesystem')
local beautiful  = require('beautiful')
local gears      = require('gears')
local dpi        = beautiful.xresources.apply_dpi

local assets     = filesystem.get_configuration_dir() .. '/theme/assets/'

local theme      = {}

-- Icon
theme.icon_theme = 'Papirus-Dark'

-- Font
-- theme.font = 'ProggyCleanTTCE Nerd Font Mono 12'
-- theme.font = 'VictorMono Nerd Font Mono 10'
theme.font = 'Iosevka Nerd Font Mono 10'

-- Misc
-- -- Wallpaper Image
theme.wallpaper = assets .. 'wallpaper/wallpaper5.jpg'
-- -- Solid Color
gears.wallpaper.set("#20BEC6")

theme.useless_gap = 10

-- Colors
theme.color_transparent = '#00000000'
theme.background = '#1F242588'

theme.fg_normal = '#ffffffff'
theme.fg_focus = '#e4e4e4'
theme.fg_urgent = '#CC9393'

theme.bg_normal = theme.background
theme.bg_focus = '#5a5a5a'
theme.bg_urgent = '#3F3F3F'

-- Tooltip
theme.tooltip_bg = theme.background
theme.tooltip_border_width = 0
theme.tooltip_shape = gears.shape.rounded_rect

-- Notifications
theme.notification_bg = theme.background
theme.notification_border_width = 0
theme.notification_border_color = "#FFFFFFFF"
theme.notification_shape = gears.shape.rounded_rect

-- Panel
theme.panel_height = 38

-- Menu
theme.menu_height = 40
theme.menu_bg_focus = theme.background
theme.menu_bg_normal = theme.background

-- Taglist
theme.taglist_bg_empty = theme.background .. '00'
theme.taglist_bg_occupied =  '#ffffff' .. '11'
theme.taglist_bg_urgent = '#E91E63' .. '99'
theme.taglist_bg_focus = '#ffffff' .. '22'
theme.taglist_spacing = dpi(0)

theme.apps_slack = assets .. 'titlebar/buttons/button_red.png'

-- Tasklist
theme.tasklist_bg_normal = theme.background .. '99'
theme.tasklist_bg_focus = theme.background
theme.tasklist_bg_urgent = '#E91E63' .. '99'
theme.tasklist_fg_focus = '#DDDDDD'
theme.tasklist_fg_urgent = '#ffffff'
theme.tasklist_fg_normal = '#AAAAAA'

-- Notification
theme.notification_position = 'top_right'
theme.notification_bg = theme.transparent
theme.notification_margin = dpi(5)
theme.notification_border_width = dpi(0)
theme.notification_border_color = theme.transparent
theme.notification_spacing = dpi(5)
theme.notification_icon_resize_strategy = 'center'
theme.notification_icon_size = dpi(32)

theme.widget_pill_top_left     = assets .. 'widget/widget_pill_top_left.png'
theme.widget_pill_top_right    = assets .. 'widget/widget_pill_top_right.png'
theme.widget_pill_bottom_left  = assets .. 'widget/widget_pill_bottom_left.png'
theme.widget_pill_bottom_right = assets .. 'widget/widget_pill_bottom_right.png'

-- Titlebar
theme.titlebar_size         = nil -- use image width/height
theme.titlebar_image_top    = assets .. 'titlebar/titlebar_top.png'
theme.titlebar_image_middle = assets .. 'titlebar/titlebar_middle.png'
theme.titlebar_image_bottom = assets .. 'titlebar/titlebar_bottom.png'
theme.titlebar_bgimage_normal = theme.titlebar_middle

-- Titlebar Buttons
theme.titlebar_button_spacing       = dpi(2.5)
theme.titlebar_button_margin_left   = dpi(2.5)
theme.titlebar_button_margin_right  = dpi(3)
theme.titlebar_button_margin_top    = dpi(3)
theme.titlebar_button_margin_bottom = dpi(3)

theme.titlebar_button_close                   = assets .. 'titlebar/buttons/button_red.png'
theme.titlebar_button_close_hover             = assets .. 'titlebar/buttons/button_red_hover.png'

theme.titlebar_button_minimize                = assets .. 'titlebar/buttons/button_yellow.png'
theme.titlebar_button_minimize_hover          = assets .. 'titlebar/buttons/button_yellow_hover.png'

theme.titlebar_button_maximize_inactive       = assets .. 'titlebar/buttons/button_blue_inactive.png'
theme.titlebar_button_maximize_inactive_hover = assets .. 'titlebar/buttons/button_blue_inactive_hover.png'
theme.titlebar_button_maximize_active         = assets .. 'titlebar/buttons/button_blue_active.png'
theme.titlebar_button_maximize_active_hover   = assets .. 'titlebar/buttons/button_blue_active_hover.png'

theme.titlebar_button_floating_inactive       = assets .. 'titlebar/buttons/button_blue_inactive.png'
theme.titlebar_button_floating_inactive_hover = assets .. 'titlebar/buttons/button_blue_inactive_hover.png'
theme.titlebar_button_floating_active         = assets .. 'titlebar/buttons/button_blue_active.png'
theme.titlebar_button_floating_active_hover   = assets .. 'titlebar/buttons/button_blue_active_hover.png'

theme.titlebar_button_ontop_inactive          = assets .. 'titlebar/buttons/button_blue_inactive.png'
theme.titlebar_button_ontop_inactive_hover    = assets .. 'titlebar/buttons/button_blue_inactive_hover.png'
theme.titlebar_button_ontop_active            = assets .. 'titlebar/buttons/button_blue_active.png'
theme.titlebar_button_ontop_active_hover      = assets .. 'titlebar/buttons/button_blue_active_hover.png'


-- Don't touch, it's for semantics
theme.titlebar_close_button_normal                    = theme.titlebar_button_close
theme.titlebar_close_button_normal_hover              = theme.titlebar_button_close_hover
theme.titlebar_close_button_focus                     = theme.titlebar_button_close
theme.titlebar_close_button_focus_hover               = theme.titlebar_button_close_hover

theme.titlebar_minimize_button_normal                 = theme.titlebar_button_minimize
theme.titlebar_minimize_button_normal_hover           = theme.titlebar_button_minimize_hover
theme.titlebar_minimize_button_focus                  = theme.titlebar_button_minimize
theme.titlebar_minimize_button_focus_hover            = theme.titlebar_button_minimize_hover

theme.titlebar_maximized_button_normal_inactive       = theme.titlebar_button_maximize_inactive
theme.titlebar_maximized_button_normal_inactive_hover = theme.titlebar_button_maximize_inactive_hover
theme.titlebar_maximized_button_normal_active         = theme.titlebar_button_maximize_active
theme.titlebar_maximized_button_normal_active_hover   = theme.titlebar_button_maximize_active_hover
theme.titlebar_maximized_button_focus_inactive        = theme.titlebar_button_maximize_inactive
theme.titlebar_maximized_button_focus_inactive_hover  = theme.titlebar_button_maximize_inactive_hover
theme.titlebar_maximized_button_focus_active          = theme.titlebar_button_maximize_active
theme.titlebar_maximized_button_focus_active_hover    = theme.titlebar_button_maximize_active_hover

theme.titlebar_floating_button_normal_inactive        = theme.titlebar_button_floating_inactive
theme.titlebar_floating_button_normal_inactive_hover  = theme.titlebar_button_floating_inactive_hover
theme.titlebar_floating_button_normal_active          = theme.titlebar_button_floating_active
theme.titlebar_floating_button_normal_active_hover    = theme.titlebar_button_floating_active_hover
theme.titlebar_floating_button_focus_inactive         = theme.titlebar_button_floating_inactive
theme.titlebar_floating_button_focus_inactive_hover   = theme.titlebar_button_floating_inactive_hover
theme.titlebar_floating_button_focus_active           = theme.titlebar_button_floating_active
theme.titlebar_floating_button_focus_active_hover     = theme.titlebar_button_floating_active_hover

theme.titlebar_ontop_button_normal_inactive           = theme.titlebar_button_ontop_inactive
theme.titlebar_ontop_button_normal_inactive_hover     = theme.titlebar_button_ontop_inactive_hover
theme.titlebar_ontop_button_normal_active             = theme.titlebar_button_ontop_active
theme.titlebar_ontop_button_normal_active_hover       = theme.titlebar_button_ontop_active_hover
theme.titlebar_ontop_button_focus_inactive            = theme.titlebar_button_ontop_inactive
theme.titlebar_ontop_button_focus_inactive_hover      = theme.titlebar_button_ontop_inactive_hover
theme.titlebar_ontop_button_focus_active              = theme.titlebar_button_ontop_active
theme.titlebar_ontop_button_focus_active_hover        = theme.titlebar_button_ontop_active_hover
return theme
