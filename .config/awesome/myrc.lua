-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")
-- Theme handling library
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                    title  = "Oops, there were errors during startup!",
					text   = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title  = "Oops, an error happened!",
                         text   = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_name = "xresources"
beautiful.init("/home/yoavm448/.config/awesome/themes/Guardieye/theme.lua")
--beautiful.init("/usr/share/awesome/themes/xresources/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal   = os.getenv("TERMINAL") or "st"
editor     = os.getenv("EDITOR") or "nano"
editor_cmd = terminal.." -e "..editor


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts   = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal.." -e man awesome" },
    { "edit config", editor_cmd.." "..awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                              { "open terminal", terminal }}})


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.show_categories = false
-- }}}

-- {{{ Key bindings
local keys = require("keys")
local bar = require("bar")

bar.launcher.menu = mymainmenu

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", },
              s, awful.layout.layouts[1])
    bar.new(s)
end)

keys.callbacks.runpromptbox = function() awful.screen.focused().bar.promptbox:run() end
keys.callbacks.change_keyboard_layout = bar.keyboardlayout.next_layout
keys.callbacks.show_menu = function() mymainmenu:show() end
keys.callbacks.inc_arcchart = function() 
    bar.progressbar.widget:set_value(bar.progressbar.widget.value + 0.1)
end


local sound_module = {}
sound_module.value = 50

function sound_module.apply()
    --naughty.notify({title = sound_module.value})
    awful.spawn('pa-simplified set-vol '..tostring(sound_module.value)..'%')
    bar.sound_bar.widget:set_value(sound_module.value/100)
end

function sound_module.change(val)
    sound_module.value = sound_module.value + val
    sound_module.apply()
end

keys.callbacks.sound_decrease = function() sound_module.change(-4) end
keys.callbacks.sound_increase = function() sound_module.change(4) end


local brightness_module = {}
brightness_module.value = 50

function brightness_module.apply()
    --naughty.notify({title = brightness_module.value})
    awful.spawn('xbacklight -set '..tostring(brightness_module.value))
    bar.brightness_bar.widget:set_value(brightness_module.value/100)
end
brightness_module.apply()

function brightness_module.change(val)
    brightness_module.value = brightness_module.value + val
    brightness_module.apply()
end

keys.callbacks.brightness_decrease = function() brightness_module.change(-4) end
keys.callbacks.brightness_increase = function() brightness_module.change(4) end
-- Set keys
root.keys(keys.globals)
-- }}}

-- Create a wibox for each screen and add it

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)



-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
        awful.button({ }, 3, function()
            mymainmenu:toggle()
        end)--,
        --awful.button({ }, 5, awful.tag.viewnext),
        --awful.button({ }, 4, awful.tag.viewprev)
))
-- }}}


clientbuttons = gears.table.join(
        awful.button({ }, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),
        awful.button({ keys.mod }, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({ keys.mod }, 3, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end)
)

client.connect_signal("manage", function(c, startup)
    -- Enable round corners with the shape api
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 8)
    end
end)


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keys.clients,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
            --"DTA",  -- Firefox addon DownThemAll.
            "copyq", -- Includes session name in class.
            "pinentry",
        },
        class = {
            "Arandr",
            "Blueman-manager",
            "Gpick",
            "Kruler",
            "MessageWin", -- kalarm.
            "Sxiv",
            "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            "Wpa_gui",
            "veromix",
            "xtightvncviewer" },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "Event Tester", -- xev.
        },
        role = {
            "AlarmWindow", -- Thunderbird's calendar.
            "ConfigManager", -- Thunderbird's about:config.
            "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true } },

    -- Add titlebars to normal clients and dialogs
    { rule_any = { type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
                awful.button({ }, 1,
                             function()
                                 c:emit_signal("request::activate", "titlebar", { raise = true })
                                 awful.mouse.client.move(c)
                             end),
                awful.button({ }, 2,
                             function()
                                 --c:emit_signal("request::activate", "titlebar", { raise = true })
                                 --awful.mouse.client.resize(c)
                                 c:kill()
                             end),
                awful.button({ }, 3,
                             function()
                                 c:emit_signal("request::activate", "titlebar", { raise = true })
                                 awful.mouse.client.resize(c)
                             end)
        )

        awful.titlebar(c):setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            { -- Right
                -- awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                -- awful.titlebar.widget.stickybutton   (c),
                -- awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
-- c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

if beautiful.border_width ~= 0 and beautiful.border_normal ~= beautiful.border_focused then
    client.connect_signal("focus",
                          function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus",
                          function(c) c.border_color = beautiful.border_normal end)
end
-- }}}
