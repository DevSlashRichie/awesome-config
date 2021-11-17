local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
local apps = require("apps")
local decoration = require("ui.decoration")

local keys = {}

-- Mod keys
superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Ctrl"
shiftkey = "Shift"

-- {{{ Mouse bindings on desktop
keys.desktopbuttons = {
	awful.button ({ }, 1, function ()
        -- Single tap
        naughty.destroy_all_notifications()
        -- Double tap
        local function double_tap()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end
        helpers.single_double_tap(function() end, double_tap)
    end),
 
    -- Right click - Show app drawer
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 3, function ()
    end),
 
    -- Middle button - Toggle dashboard
    awful.button({ }, 2, function ()
    end),
 
    -- Scrolling - Switch tags
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
 
    -- Side buttons - ctrlkey volume
    awful.button({ }, 9, function () helpers.volume_control(5) end),
    awful.button({ }, 8, function () helpers.volume_control(-5) end)
 
    -- Side buttons - Minimize and restore minimized client
    -- awful.button({ }, 8, function()
    --     if client.focus ~= nil then
    --         client.focus.minimized = true
    --     end
    -- end),
    -- awful.button({ }, 9, function()
    --       local c = awful.client.restore()
    --       -- Focus restored client
    --       if c then
    --           client.focus = c
    --       end
    -- end)
}
-- }}}

-- {{{ Key bindings
keys.globalkeys = {
    awful.key({ superkey,           }, "s",      hotkeys_popup.show_help,
          {description="show help", group="awesome"}),
	awful.key {
        modifiers   = { superkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { superkey, ctrlkey },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { superkey , shiftkey },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { superkey, ctrlkey, shiftkey },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { superkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    },
    -- Window switching
    awful.key({ superkey }, "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next client", group = "client"}),
    awful.key({ superkey, shiftkey }, "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous client", group = "client"}),
    -- Focus client by direction (arrow keys)
    awful.key({ superkey }, "Down",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
    awful.key({ superkey }, "Up",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
    awful.key({ superkey }, "Left",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
    awful.key({ superkey }, "Right",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),

    -- Gaps
    awful.key({ superkey, shiftkey }, "minus",
        function ()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({ superkey }, "minus",
        function ()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
	),

    -- Spawn terminal
    awful.key({ superkey }, "Return", function () awful.spawn(user.terminal) end,
        {description = "open a terminal", group = "launcher"}),
    -- Spawn floating terminal
    awful.key({ superkey, shiftkey }, "Return", function()
        awful.spawn(user.terminal, {floating = true})
                                                end,
        {description = "spawn floating terminal", group = "launcher"}),

    -- Reload Awesome
    awful.key({ superkey, shiftkey }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),

    -- Quit Awesome
    -- Logout, Shutdown, Restart, Suspend, Lock
    awful.key({ superkey, shiftkey }, "x",
        function ()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ superkey }, "Escape",
        function ()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ }, "XF86PowerOff",
        function ()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),

    -- Number of master clients
    awful.key({ superkey, altkey }, "Left",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, altkey }, "Right",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    -- Run program (d for dmenu ;)
    awful.key({ superkey }, "d",
        function()
            awful.spawn.with_shell("rofi -matching fuzzy -show combi")
        end,
        {description = "rofi launcher", group = "launcher"}),
    -- Brightness
    awful.key( { }, "XF86MonBrightnessDown",
        function()
            awful.spawn.with_shell("light -U 10")
        end,
        {description = "decrease brightness", group = "brightness"}),
    awful.key( { }, "XF86MonBrightnessUp",
        function()
            awful.spawn.with_shell("light -A 10")
        end,
        {description = "increase brightness", group = "brightness"}),

    -- Volume ctrlkey with volume keys
    awful.key( { }, "XF86AudioMute",
        function()
            helpers.volume_control(0)
        end,
        {description = "(un)mute volume", group = "volume"}),
    awful.key( { }, "XF86AudioLowerVolume",
        function()
            helpers.volume_control(-5)
        end,
        {description = "lower volume", group = "volume"}),
    awful.key( { }, "XF86AudioRaiseVolume",
        function()
            helpers.volume_control(5)
        end,
        {description = "raise volume", group = "volume"}),
    

    --       DÜZELTMEM LAZIM
--    -- Screenkey toggle
--    awful.key( { superkey }, "F12", apps.screenkey,
--        {description = "raise volume", group = "volume"}),
--
    -- Microphone (V for voice)
    awful.key( { superkey }, "v",
        function()
            awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
        end,
        {description = "(un)mute microphone", group = "volume"}),
    -- Microphone overlay
    awful.key( { superkey, shiftkey }, "v",
        function()
            microphone_overlay_toggle()
        end,
        {description = "toggle microphone overlay", group = "volume"}),

    -- Screenshots
    awful.key( { }, "Print", function() apps.screenshot("full") end,
        {description = "take full screenshot", group = "screenshots"}),
    awful.key( { superkey, shiftkey }, "c", function() apps.screenshot("selection") end,
        {description = "select area to capture", group = "screenshots"}),
    awful.key( { superkey, ctrlkey }, "c", function() apps.screenshot("clipboard") end,
        {description = "select area to copy to clipboard", group = "screenshots"}),
    awful.key( { superkey }, "Print", function() apps.screenshot("browse") end,
        {description = "browse screenshots", group = "screenshots"}),
    awful.key( { superkey, shiftkey }, "Print", function() apps.screenshot("gimp") end,
        {description = "edit most recent screenshot with gimp", group = "screenshots"}),
-- ----------------------------------------------------------------------------------------------------
-- BURDAN SONRASI DİKKATSİZCE GEÇİLDİ
-- ----------------------------------------------------------------------------------------------------
    -- Pomodoro timer
    awful.key({ superkey }, "slash", function()
        awful.spawn.with_shell("pomodoro")
                                     end,
        {description = "pomodoro", group = "launcher"}),
--    -- Spawn file manager
--    awful.key({ superkey }, "F2", apps.file_manager,
--        {description = "file manager", group = "launcher"}),
--    -- Spawn music client
--    awful.key({ superkey }, "F3", apps.music,
--        {description = "music client", group = "launcher"}),
    -- Spawn cava in a terminal
    awful.key({ superkey }, "F4", function() awful.spawn("visualizer") end,
        {description = "cava", group = "launcher"}),
    -- Spawn ncmpcpp in a terminal, with a special visualizer config
    awful.key({ superkey, shiftkey }, "F4", function() awful.spawn(user.terminal .. " -e 'ncmpcpp -c ~/.config/ncmpcpp/config_visualizer -s visualizer'") end,
        {description = "ncmpcpp", group = "launcher"}),
    -- Network dialog: nmapplet rofi frontend
    awful.key({ superkey }, "F11", function() awful.spawn("networks-rofi") end,
        {description = "spawn network dialog", group = "launcher"}),
    -- Toggle sidebar
    awful.key({ superkey }, "grave", function() sidebar_toggle() end,
        {description = "show or hide sidebar", group = "awesome"}),
    -- Toggle wibar(s)
    awful.key({ superkey }, "b", function() wibars_toggle() end,
        {description = "show or hide wibar(s)", group = "awesome"}),
--    -- Emacs (O for org mode)
--    awful.key({ superkey }, "o", apps.org,
--        {description = "emacs", group = "launcher"}),
    -- Markdown input scratchpad (I for input)
    -- For quickly typing markdown comments and pasting them in
    -- the browser
--    awful.key({ superkey }, "i", apps.markdown_input,
--        {description = "markdown scratchpad", group = "launcher"}),
--    -- Editor
--    awful.key({ superkey }, "e", apps.editor,
--        {description = "editor", group = "launcher"}),
    -- Quick edit file
    awful.key({ superkey, shiftkey }, "e",
        function()
            awful.spawn.with_shell("rofi_edit")
        end,
        {description = "quick edit file", group = "launcher"}),
--    -- Rofi youtube search and playlist selector
--    awful.key({ superkey }, "y", apps.youtube,
--        {description = "youtube search and play", group = "launcher"}),
--    -- Spawn file manager
--    awful.key({ superkey, shiftkey }, "f", apps.file_manager,
--        {description = "file manager", group = "launcher"}),
--    -- Process monitor
--    awful.key({ superkey }, "p", apps.process_monitor,
--        {description = "process monitor", group = "launcher"})
-- ----------------------------------------------------------------------------------------------------
}


keys.clientkeys = {

    -- Toggle titlebars (for focused client only)
    awful.key({ superkey,           }, "t",
        function (c)
            decoration.cycle(c)
        end,
        {description = "toggle titlebar", group = "client"}),
    -- Toggle titlebars (for all visible clients in selected tag)
    awful.key({ superkey, shiftkey }, "t",
        function (c)
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                decoration.cycle(c)
            end
        end,
        {description = "toggle titlebar", group = "client"}),
    -- Tam ekran
        awful.key({ superkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ superkey, shiftkey   }, "c",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ superkey, ctrlkey }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ superkey, ctrlkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ superkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ superkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ superkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ superkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ superkey, ctrlkey }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ superkey, shiftkey   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    }


-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = {
    awful.button({ }, 1, function (c) c:activate() end),
    awful.button({ superkey }, 1, awful.mouse.client.move),
    -- awful.button({ superkey }, 2, function (c) c:kill() end),
    awful.button({ superkey }, 3, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end),

    -- Super + scroll = Change client opacity
    awful.button({ superkey }, 4, function(c)
        c.opacity = c.opacity + 0.1
    end),
    awful.button({ superkey }, 5, function(c)
        c.opacity = c.opacity - 0.1
    end)
}

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the superkey is pressed
keys.tasklist_buttons = gears.table.join(
    awful.button({ 'Any' }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
            end
    end),
    -- Middle mouse button closes the window (on release)
    awful.button({ 'Any' }, 2, nil, function (c) c:kill() end),
    awful.button({ 'Any' }, 3, function (c) c.minimized = true end),
    awful.button({ 'Any' }, 4, function ()
        awful.client.focus.byidx(-1)
    end),
    awful.button({ 'Any' }, 5, function ()
        awful.client.focus.byidx(1)
    end),

    -- Side button up - toggle floating
    awful.button({ 'Any' }, 9, function(c)
        c.floating = not c.floating
    end),
    -- Side button down - toggle ontop
    awful.button({ 'Any' }, 8, function(c)
        c.ontop = not c.ontop
    end)
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = 

{
            awful.button({ }, 1, function(t) helpers.tag_back_and_forth(t.index) end ),
            awful.button({ superkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ superkey }, 3, function(t)
                                            if client.focus then   
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }

-- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = function (c) return{
        -- Sol tuş
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        -- Orta tuş
        awful.button({ }, 2, function()
            c:kill()                                                   
        end),
        -- Sağ tuş
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"  }
        end),
        -- Yan yukarı tuş
        awful.button({ }, 9, function()
            c:activate { context = "titlebar"}                           
            c.floating = not c.floating
        end),
        -- Yan aşağı fare tuşu
        awful.button({ }, 8, function()
            c:activate { context = "titlebar"}
            c.ontop= not c.ontop
        end),
    }  end

-- }}}

-- Set root (desktop) keys
awful.keyboard.append_global_keybindings(keys.globalkeys)
awful.mouse.append_global_mousebindings(keys.desktopbuttons)
----root.buttons = nil
----root.keys = nil
return keys
