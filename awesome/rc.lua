local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

beautiful.init("/usr/share/awesome/themes/default/theme.lua")
modkey = "Mod4"

terminal = "konsole"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

local layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}

-- {{{ tags
tags = {
	names = { "term", "www", "chat", "mail", "work", "media", "other" },
	layout = {
		layouts[1], layouts[10], layouts[1],
		layouts[10], layouts[2], layouts[10], layouts[2]
	}
}
for s = 1, screen.count() do
	tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ statusbar and widget on it
-- widgets
textclock = awful.widget.textclock({ align = "right" })
systray = widget({ type = "systray" })
taglist = {}
taglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)
tasklist = {}
tasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			if not c:isvisible() then
				awful.tag.viewonly(c:tags()[1])
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width=250 })
		end
	end),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end)
)

statusbar = {}
for s = 1, screen.count() do
	-- create taglist
	taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.bottons)
	-- create tasklist
	tasklist[s] = awful.widget.tasklist(function (c)
		return awful.widget.tasklist.label.currenttags(c, s)
	end, tasklist.buttons)

	statusbar[s] = awful.wibox({ position="top", screen=s })
	statusbar[s].widgets = {
		{
			taglist[s],
			layout = awful.widget.layout.horizontal.leftright
		},
		textclock,
		systray,
		tasklist[s],
		layout = awful.widget.layout.horizontal.rightleft
	}
end
-- }}}

-- {{{ key bindings
root.keys(awful.util.table.join(
 	awful.key({modkey,    }, "h", awful.tag.viewprev),
 	awful.key({modkey,    }, "l", awful.tag.viewnext),
	awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
 	awful.key({modkey,    }, "Tab", function ()
 		awful.client.focus.history.previous()
 		if client.focus then
 			client.focus:raise()
 		end
 	end),

 	-- program
 	awful.key({modkey,    }, "Return", function () awful.util.spawn(terminal) end)
))
-- }}}

-- {{{ mouse bindings
root.buttons(awful.util.table.join(
	awful.button({}, 3, function () mainmenu:toggle() end)
))
-- }}}

-- {{{ menu
awesomemenu = {
	{ "restart", awesome.restart },
	{ "quit", awesome.quit}
}
mainmenu = awful.menu({ items = {
	{"awesome", awesomemenu, beautiful.awesome_icon},
	{"open terminal", terminal}
}})
-- }}}
