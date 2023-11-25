local confdir = require('gears.filesystem').get_configuration_dir()
local assets  = confdir .. "themes/assets/"
local cmb = require('helpers.image').combine
local cols = {}

	cols.black      = "#262626"
	cols.red        = "#ac8a8c"
	cols.green      = "#8aac8b"
	cols.yellow     = "#aca98a"
	cols.blue       = "#8aabac"
	cols.magenta    = "#ac8aac"
	cols.cyan       = "#8aabac"
	cols.white      = "#e7e7e8"
								
	cols.bg         = "#0f0f0f"
	cols.fg         = "#f0f0f0"
	cols.dbg        = "#191919"
	cols.lbg        = "#4c4c4c"
	cols.dfg        = "#767676"
	
	cols.alert      = cols.red
	
	cols.taglist    = cols.red
	cols.barbtns    = cols.red
	cols.clock      = cols.red
	cols.notifs     = cols.red
	
	cols.border_normal = cols.lbg
	cols.border_focus  = cols.white
	
	cols.bar_icon   =  cmb(confdir .. 'themes/mountain/bar.svg',  '#393939',
	                       confdir .. 'themes/mountain/bar2.svg', cols.white)
	cols.pfpbg      = cols.dbg

return cols
