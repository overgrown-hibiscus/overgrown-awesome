local conf = require('config')
local dpi  = require('beautiful').xresources.apply_dpi

local _T = {
	font	= conf.mono_font,
	mono_font	= conf.mono_font,
	sans_font	= conf.sans_font,

	useless_gap		= dpi(conf.gaps),
	border_size		= dpi(conf.border_size),
	border_radius	= dpi(conf.border_radius),
}

return _T



