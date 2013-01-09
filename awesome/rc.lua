local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init("/usr/share/awesome/themes/default/theme.lua")
modkey = "Mod4"

terminal = "konsol"
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
		layouts[10], layouts[10], layouts[1],
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

statusbar = {}
for s = 1, screen.count() do
	-- create taglist
	taglist[s] = awful.widget.taglist(s, awful.widget.taglist.lable.all, taglist.bottons)

	statusbar[s] = awful.wibox({ position="bottom", screen=s })
	statusbar[s].widgets = {
		{
			taglist,
			layout = awful.widget.layout.horizontal.leftright
		},
		textclock,
		systray,
		layout = awful.widget.layout.horizontal.rightleft
	}
end
-- }}}

-- {{{ key bindings
globalkeys = awful.util.table.join(
	awful.key({modkey,    }, "h", awful.tag.viewprev),
	awful.key({modkey,    }, "l", awful.tag.viewnext),

	-- program
	awful.key({modkey,    }, "return", function ()
		awful.util.spawn(terminal) end)
)
root.keys(globalkeys)
-- }}}}

