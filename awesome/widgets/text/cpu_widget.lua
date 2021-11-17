local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local helpers = require("helpers")

local cpu_widget = wibox.widget.textbox()

-- Yazı ayarları
cpu_widget.font = beautiful.wibar_font or "sans 13"
-- desktop_control.forced_width = dpi(100)
cpu_widget.markup = helpers.colorize_text("󰝞 N/A",x.color2)
-- Tuşlar


-- Signals
awesome.connect_signal("evil::cpu", function(percent)
    cpu_widget.markup = helpers.colorize_text("󰍛 "..percent.."%",x.color1)
end)

return cpu_widget
