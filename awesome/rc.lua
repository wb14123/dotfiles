local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init("/usr/share/awesome/themes/default/theme.lua")

terminal = "konsol"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

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

-- {{{ Setting tags
tags = {
	names = {"term", "www", "chat", "mail", "work", "media", "other"},
	layout = {
		layouts[10], layouts[10], layouts[1],
		layouts[10], layouts[2], layouts[10], layouts[2]
	}
}
for s = 1, screen.count() do
	tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({modkey,    }, "h", awful.tag.viewprev),
	awful.key({modkey,    }, "l", awful.tag.viewnext),

	-- program
	awful.key({modkey,    }, "return", function ()
		awful.util.spawn(terminal) end)
)
root.keys(globalkeys)
-- }}}}

