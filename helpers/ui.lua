local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')

local color = require('modules.color')
local rubato = require('modules.rubato')

local _M = {}

_M.opposite = function(place)
  return (place == "top")    and "bottom"
      or (place == "bottom") and "top"
      or (place == "right")  and "left"
      or (place == "left")   and "right"
      or (place == "up")     and "down"
      or (place == "down")   and "up"
      or nil
end
_M.shape = {}
_M.shape.rect = function()
	return function(cr, w, h)
		gears.shape.rectangle(cr, w, h)
	end
end

_M.shape.rrect = function(rad)
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, rad)
	end
end

_M.shape.prrect = function(rad, t)
	local ct = {
		tl = t.tl or false,
		tr = t.tr or false,
		br = t.br or false,
		bl = t.bl or false,
	}
	return function(cr, w, h)
		gears.shape.partially_rounded_rect(cr, w, h, ct.tl, ct.tr, ct.br, ct.bl, rad)
	end
end

_M.embox = function(w, set)
	local w = w
	if require('config').colorscheme == 'suckless' then return w end

	if type(set) == 'nil' then set = {} end

	local s = {
		padding = set.padding or 2,
		margin = set.margin or set.margins or 4,
		shape = set.shape or _M.shape.rrect(beautiful.corner_radius),
		dbg = color.color { hex = set.dbg or beautiful.dbg },
		lbg = color.color { hex = set.lbg or beautiful.lbg },
		tbg = color.color { hex = set.tbg or beautiful.tbg },
		fg  = color.color { hex = set.fg  or beautiful.fg  },
		tfg = color.color { hex = set.tfg or beautiful.tfg },
		hover = set.hover or false,
		on_click = set.on_click or nil,
	}

	if set.place_fix then
		w = {
			w,
			widget = wibox.container.place,
			halign = "center",
			valign = "center",
		}
	end

	local ret = wibox.widget {
		{
			{
				w,
				widget = wibox.container.margin,
				margins = s.padding,
			},
			widget = wibox.container.background,
			bg = s.dbg.hex,
			shape = s.shape,
			id = "inside",
		},
		widget = wibox.container.margin,
		margins = s.margin,
	}

	if s.hover then
		local hovcol = color.transition(s.dbg, s.lbg)
		local hoveranim = rubato.timed {
			duration = 0.2,
			intro = 0.1,
			subscribed = function(pos)
				ret.inside.bg = hovcol(pos).hex
			end
		}

		local old_cursor, old_wibox

		ret.inside:connect_signal('mouse::enter', function()
			hoveranim.target = 1
			w = mouse.current_wibox
			if w then
				old_cursor, old_wibox = w.cursor, w
				w.cursor = 'hand1'
			end
		end)

		ret.inside:connect_signal('mouse::leave', function()
			hoveranim.target = 0
			if old_wibox then
				old_wibox.cursor = old_cursor
			end
		end)
	end

	if type(s.on_click) == 'function' then
		local toggled
		local butbg = color.transition(s.lbg, s.tbg)
		local butfg = color.transition(s.fg, s.tfg)
		local toganim = rubato.timed {
			duration = 0.2,
			intro = 0.1,
			subscribed = function(pos)
				ret.inside.bg = butbg(pos).hex
				ret.inside.fg = butfg(pos).hex
			end
		}

		ret.inside:connect_signal('button::press', function()
			if not toggled then
				toganim.target = 1
			else
				toganim.target = 0
			end
			toggled = not toggled
			s.on_click(toggled)
		end)
	end

	return ret
end

return _M
