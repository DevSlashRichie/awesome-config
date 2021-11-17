local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local helpers = require("helpers")

-- Note: This theme does not show image notification icons

-- For antialiasing
-- The real background color is set in the widget_template
beautiful.notification_bg = x.color0

local default_icon = ""

-- Custom text icons according to the notification's app_name
-- plus whether the title should be visible or not
-- (This will be removed when notification rules are released)
-- Using icomoon font
local app_config = {
    ['battery'] = { icon = "", title = false },
    ['charger'] = { icon = "", title = false },
    ['volume'] = { icon = "", title = false },
    ['brightness'] = { icon = "", title = false },
    ['screenshot'] = { icon = "", title = false },
    ['Telegram Desktop'] = { icon = "", title = true },
    ['night_mode'] = { icon = "", title = false },
    ['NetworkManager'] = { icon = "", title = true },
    ['youtube'] = { icon = "", title = true },
    ['mpd'] = { icon = "", title = true },
    ['mpv'] = { icon = "", title = true },
    ['keyboard'] = { icon = "", title = false },
    ['email'] = { icon = "", title = true },
}

local urgency_color = {
    ['low'] = x.color2,
    ['normal'] = x.color4,
    ['critical'] = x.color11,
}
