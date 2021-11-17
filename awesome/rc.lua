local theme = "crn"
local notification_theme = "amarena"
local decoration_theme = "ephemeral"

-- 📖 Libraries
local gears = require("gears")
local gfs = gears.filesystem
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")

local xrdb = beautiful.xresources.get_current_theme()

-- 🌍 Some global variables
-- --------------------------------------------------
config_dir = gfs.get_configuration_dir()
dpi = beautiful.xresources.apply_dpi
-- Import colors from Xresources database
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}
user = {
terminal = "kitty -1",
floating_terminal = "kitty -1",
browser = "firefox",
file_manager = "kitty -1 --class files -e ranger",
editor = "kitty -1 --class editor -e nvim",
email_client = "kitty -1 --class email -e neomutt",
music_client = "kitty -o font_size=12 --class music -e ncmpcpp",



-- >> Battery <<
-- You will receive notifications when your battery reaches these
-- levels.
battery_threshold_low = 20,
battery_threshold_critical = 5,

    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },


}
-- Features
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi

-- 🎨 Theme
beautiful.init(config_dir .. "themes/" .. theme .. "/theme.lua")

-- 🧩 Import modular files
-- Start daemons
require("evil")
-- Initialize icons array and load icon theme
local icons = require("icons") --Requires "Gears"
icons.init("crayon")
-- Load notification daemons and notification theme
local notifications = require("notifications")
notifications.init(notification_theme)
local ui = require("ui")
ui.decoration.init(decoration_theme)
require("rules") -- Requires "ruled", "awful", "keys"
require("awful.autofocus")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- 🚀 Launch script
require("autostart") -- Requires "awful", "gears"

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Hatalar :( : "..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = "/home/cigneve/.config/awesome/themes/crn/wall.png",
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
-- Signals
-- ===================================================================
-- Signal function to execute when a new client appears.
client.connect_signal("request::manage", function (c)
    -- For debugging awful.rules
    -- print('c.class = '..c.class)
    -- print('c.instance = '..c.instance)
    -- print('c.name = '..c.name)

    -- Set every new window as a slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- if awesome.startup
    -- and not c.size_hints.user_position
    -- and not c.size_hints.program_position then
    --     -- Prevent clients from being unreachable after screen count changes.
    --     awful.placement.no_offscreen(c)
    --     awful.placement.no_overlap(c)
    -- end

end)

-- When a client starts up in fullscreen, resize it to cover the fullscreen a short moment later
-- Fixes wrong geometry when titlebars are enabled
client.connect_signal("request::manage", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

if beautiful.border_width > 0 then
    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
-- ==============================================================
tag.connect_signal('property::layout', function(t)
    for k, c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = c.floating_geometry
            if cgeo then
                c:geometry(c.floating_geometry)
            end
        end
    end
end)

client.connect_signal('request::manage', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        c.floating_geometry = c:geometry()
    end
end)

client.connect_signal('property::geometry', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        c.floating_geometry = c:geometry()
    end
end)

-- ==============================================================
-- ==============================================================

-- When switching to a tag with urgent clients, raise them.
-- This fixes the issue (visual mismatch) where after switching to
-- a tag which includes an urgent client, the urgent client is
-- unfocused but still covers all other windows (even the currently
-- focused window).
awful.tag.attached_connect_signal(s, "property::selected", function ()
    local urgent_clients = function (c)
        return awful.rules.match(c, { urgent = true })
    end
    for c in awful.client.iterate(urgent_clients) do
        if c.first_tag == mouse.screen.selected_tag then
            client.focus = c
        end
    end
end)

-- Raise focused clients automatically
client.connect_signal("focus", function(c) c:raise() end)

-- Focus all urgent clients automatically
client.connect_signal("property::urgent", function(c)
    if c.urgent then
        c.minimized = false
        c:jump_to()
    end
end)


naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
