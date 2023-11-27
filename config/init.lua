local json = require('modules.json')
local awful = require('awful')
local gfs = require('gears.filesystem')
local string = require('helpers.string')

local home = os.getenv("HOME")
local data_home = os.getenv("XDG_DATA_HOME")
local config_path =  (data_home or home .. "/.local/share") .. "/overgrown/"
local config_file = config_path .. "users.json"

local users = {}

local users_file = io.open(config_file, 'r')
if users_file then
	users = json.decode(assert(users_file):read('*all'))
	users_file:close()
else
	users = {
		{
			name = "Emily",
			avatar = "~/.face",
			wallpaper = nil,
			screenshot_dir = "~/Pictures/Screenshots",

			apps = {
				terminal = os.getenv('TERMINAL') or "wezterm",
				editor = os.getenv('EDITOR') or "nvim",
				browser = "firefox",
				fm = "pcmanfm"
			},

			colorscheme = "everblush",
			mono_font = "Iosevka Nerd Font Mono 11",
			sans_font = "Roboto Condensed, 13",
			gaps = 8,
			border_size = 2,
			border_radius = 0,

			bar = {
				icon_pref = {
					"theme",
					"distro",
					"awesome",
				},
				position = "left",
				floating = true,
				outline = true,
				size = 36
			},

			autostart = {
				desktop = {
					on_start = {},
					on_reload = {},
					with_shell = {},
				},
				laptop = {
					on_start = {"nm-applet", "libinput-gestures"},
					on_reload = {},
					with_shell = {},
				},

				generic = {
					on_start = {"picom -b"},
					on_reload = {},
					with_shell = {},
				}
			},

			layouts = {
				"tile",
				"tile.bottom",
				"centered",
				"mstab",
				"spiral",
				"spiral.dwindle",
				"max",
				"floating"
			},
			tags = { "1", "2", "3", "4", "5", "6" }
		}
	}

	os.execute('mkdir ' .. config_path)
	local config = assert(io.open(config_file, 'w'))
	config:write(json.encode(users))
end

for _, u in pairs(users) do
	u.apps.editor_cmd = u.apps.terminal .. ' -e ' .. u.apps.editor

	for i, v in pairs(u.layouts) do
		for _, s in pairs(string.split(v, '.')) do
		 u.layouts[i] = u.layouts[i][s]
		 	or require('awful').layout.suit[s]
		 	or require('modules.bling').layout[s]
	 	end
	end
end

local user
if #users == 1 then
	user = users[1]
end

local function autostart(t)
	for k, v in pairs(t.on_start) do
		awful.spawn.once(v)
	end
	for k, v in pairs(t.on_reload) do
		awful.spawn(v)
	end
	for k, v in pairs(t.with_shell) do
		awful.spawn.with_shell(v)
	end
end


if gfs.dir_readable("/sys/class/power_supply/BAT0") then
	autostart(user.autostart.laptop)
else
	autostart(user.autostart.desktop) 
end
autostart(user.autostart.generic)

return user
