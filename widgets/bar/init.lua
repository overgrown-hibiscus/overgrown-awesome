local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local conf = require('config')

local menu = require('widgets.menu')
local taglist = require('widgets.bar.taglist')
local tasklist = require('widgets.bar.tasklist')
local tagsklist = require('widgets.bar.tagsklist')
local layoutbox = require('widgets.bar.layoutbox')

local contains = require('helpers.table').contains
local ui = require('helpers.ui')

local dir = contains({'left', 'right'}, conf.bar.position) and 'vertical'
				or contains({'top', 'bottom'}, conf.bar.position) and 'horizontal'

return function(s)
	s.widgets = {
		layoutbox		= layoutbox(s),
		taglist			= taglist(s, dir),
		tasklist		= tasklist(s, dir),
		tagsklist   = tagsklist(s, dir),
		systray			= wibox.widget{widget = wibox.widget.systray, horizontal = (dir == 'horizontal')},
		textclock		= require('widgets.bar.clock'),
	}

	local w = {
		-- left widgets
		{
			layout = wibox.layout.fixed[dir],
			{
				menu.launcher,
				widget = wibox.container.margin,
				margins = 4
			},
			wibox.container.margin(s.widgets.tagsklist, 4, 4, 4, 4),
		},
		-- middle widgets
		nil,
		-- right widgets
		{
			layout = wibox.layout.fixed[dir],
			ui.embox({
				layout = wibox.layout.fixed[dir],
				spacing = 4,
				s.widgets.systray,
				s.widgets.layoutbox,
			}),
			s.widgets.textclock,
		},
		layout = wibox.layout.align[dir],
	}

	if conf.bar.floating then
		w = {
			w,
			widget = wibox.container.background,
			shape = ui.shape.rrect(conf.border_radius),
			bg = beautiful.bg,
		}
	end

	if conf.bar.outline then
		w = {
			{
				w,
				widget = wibox.container.margin,
				margins = conf.border_size,
			},
			widget = wibox.container.background,
			shape = conf.bar.floating and ui.shape.rrect(conf.border_radius + conf.border_size) or ui.shape.rect(),
			bg = beautiful.lbg,
		}
	end

	s.widgets.wibar = awful.wibar{
		screen = s,
		position = conf.bar.position,
		margins = { [conf.bar.position] = conf.bar.floating and conf.gaps * 2 or 0},
		width =  dir == 'vertical'   and conf.bar.size
						or conf.bar.floating and s.geometry.width  - conf.gaps * 4
						or s.geometry.width,
		height = dir == 'horizontal' and conf.bar.size
						or conf.bar.floating and s.geometry.height - conf.gaps * 4
						or s.geometry.height,
		stretch = false,
		bg = conf.bar.floating and '#00000000' or beautiful.bg,
		fg = beautiful.fg,
	}
	
	s.widgets.wibar:setup(w)
end
