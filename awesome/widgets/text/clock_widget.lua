local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")
local mytextclock = wibox.widget({
format = helpers.colorize_text("󰃮 %e %b %H:%M",x.color12),
refresh = 60,
font = beautiful.wibar_font or "sans 13",
widget = wibox.widget.textclock
    }
)
return mytextclock
