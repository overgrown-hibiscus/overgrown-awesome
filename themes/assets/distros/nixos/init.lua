local gfs  = require("gears.filesystem")
local dir  = gfs.get_configuration_dir() .. "themes/assets/distros/"
local gcr  = require("gears.color").recolor_image
local cmb  = require("helpers.image").combine
local conf = require('config')
local cols = require('themes.' .. conf.colorscheme)

return cmb(dir .. "nixos/nixos1.svg", cols.blue,
					 dir .. "nixos/nixos2.svg", cols.cyan)
