local conf = require('config')
local color = require('modules.color')
local cols = require('themes.' .. conf.colorscheme .. '.cols')

local gcr = require('gears.color').recolor_image
local cmb = require('helpers.image').combine
local pth = require('gears.filesystem').get_configuration_dir() .. 'themes/assets/layouts/'

local _T = {
	layout_tile       = gcr(pth .. "tile.png",       cols.barbtns),
	layout_tilebottom = gcr(pth .. "tilebottom.png", cols.barbtns),
	layout_centered   = gcr(pth .. "centered.png",   cols.barbtns),
	layout_mstab      = gcr(pth .. "mstab.png",      cols.barbtns),
	layout_fairv      = gcr(pth .. "fairv.png",      cols.barbtns),
	layout_fairh      = gcr(pth .. "fairh.png",      cols.barbtns),
	layout_floating   = gcr(pth .. "floating.png",   cols.barbtns),
	layout_max        = cmb(pth .. "max1.png",       cols.barbtns,
							pth .. "max2.png",       cols.green),
}

return _T
