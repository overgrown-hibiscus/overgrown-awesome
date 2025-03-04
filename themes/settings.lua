local dpi = require('beautiful').xresources.apply_dpi
local gcr = require('gears.color').recolor_image
local conf = require('config')
local cols = require('themes.' .. conf.colorscheme)

local assets_path = 'themes.assets.'

local _T = {
	playerctl_player = { "mpd", "spotify", "%any" },
	playerctl_ignore = { "firefox" },
}

local icons = {}

icons.theme = cols.bar_icon
icons.distro = require(assets_path .. 'distros/' .. io.popen("sh -c 'source /etc/os-release; echo $ID'"):read("*l"))
icons.awesome = require(assets_path .. 'awesome')

for _, v in pairs(conf.bar.icon_pref) do
	if type(icons[v]) ~= 'nil' then
		_T.bar_icon = icons[v]
		break
	end
end

return _T
