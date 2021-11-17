---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local theme_name = "crn"
local gfs = require("gears.filesystem")
local themes_path = config_dir .. "themes/" .. theme_name
local theme = {}

theme.font          = "monospace 11"
theme.wibar_font    = "sans 16"

theme.wallpaper     = themes_path .. "/wall.png"

-- Set some colors that are used frequently as local variables
local accent_color = x.color14
local focused_color = x.color14
local unfocused_color = x.color7
local urgent_color = x.color9

theme.bg_dark       = x.background
theme.bg_normal     = x.background
theme.bg_focus      = x.background
theme.bg_urgent     = x.background
theme.bg_minimize   = x.color8
theme.bg_systray    = x.background

theme.background    = "#000000" .. "66"

theme.fg_normal     = x.color7
theme.fg_focus      = focused_color
theme.fg_urgent     = urgent_color
theme.fg_minimize   = x.color8



theme.useless_gap         = dpi(6)
theme.border_width        = dpi(0)
theme.border_color_normal = x.color0
theme.border_color_active = x.color0
theme.border_color_marked = x.color0

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:

theme.tag_colors_focused = {x.color9,x.color9,x.color9,x.color9,x.color9,x.color10,x.color10,x.color10,x.color10}
theme.tag_colors_urgent = {x.color9,x.color9,x.color9,x.color9,x.color9,x.color10,x.color10,x.color10,x.color10}
theme.tag_colors_occupied = {x.color3,x.color3,x.color3,x.color3,x.color3,x.color13,x.color13,x.color13,x.color13}
theme.tag_colors_empty = {x.color3,x.color3,x.color3,x.color3,x.color3,x.color5,x.color5,x.color5,x.color5}
theme.taglist_font = "monospace 16"
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
--  theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"


-- You can use your own layout icons like this:
--  theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
--  theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
--  theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
--  theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
--  theme.layout_max = themes_path.."default/layouts/maxw.png"
--  theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
--  theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
--  theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
--  theme.layout_tile = themes_path.."default/layouts/tilew.png"
--  theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
--  theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
--  theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
--  theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
--  theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
--  theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
--  theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

theme.layout_color = { centered = x.color10, tile = x.color2, floating = x.color3, tileleft= x.color4, tilebottom = x.color5, tiletop = x.color6}

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)
theme.titlebar_font = "sans 16"
theme.titlebar_title_enabled = true
theme.titlebar_title_align = "left"
theme.titlebar_fg_focus = x.color7

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
