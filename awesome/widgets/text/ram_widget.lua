local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local helpers = require("helpers")

local ram_widget = wibox.widget.textbox()

-- Yazı ayarları
ram_widget.font = beautiful.wibar_font or "sans 13"
-- desktop_control.forced_width = dpi(100)
ram_widget.markup = helpers.colorize_text("󰝞 N/A",x.color2)
-- Tuşlar

-- Signals
awesome.connect_signal("evil::ram", function(used)
    ram_widget.markup = helpers.colorize_text("󰄫 "..used.."MB",x.color2)
end)

return ram_widget
