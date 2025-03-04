local awful = require('awful')
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')
local menubar = require('menubar')

local conf = require('config')
local mod = require('bindings.mod')
local widgets = require('widgets')

menubar.utils.terminal = conf.apps.terminal

-- general awesome keys
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      key         = '#61',
      description = 'show help',
      group       = 'awesome',
      on_press    = hotkeys_popup.show_help,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'r',
      description = 'reload awesome',
      group       = 'awesome',
      on_press    = awesome.restart,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'Backspace',
      description = 'quit awesome',
      group       = 'awesome',
      on_press    = awesome.quit,
   },
   awful.key{
	modifiers	= {mod.super},
	key			= "b",
	description	= "toggle the bar",
	group		= "awesome",
	on_press	= function()
		local s = awful.screen.focused()
		s.widgets.wibar.visible = not s.widgets.wibar.visible
	end
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'Return',
      description = 'open a terminal',
      group       = 'launcher',
      on_press    = function() awful.spawn(conf.apps.terminal) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'r',
      description = 'show launcher',
      group       = 'launcher',
      on_press    = function() awful.spawn('rofi -show drun') end,
   },
}

-- focus related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      key         = 'j',
      description = 'focus next by index',
      group       = 'client',
      on_press    = function() awful.client.focus.byidx(1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'k',
      description = 'focus previous by index',
      group       = 'client',
      on_press    = function() awful.client.focus.byidx(-1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'period',
      description = 'focus the next screen',
      group       = 'screen',
      on_press    = function() awful.screen.focus_relative(1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'comma',
      description = 'focus the previous screen',
      group       = 'screen',
      on_press    = function() awful.screen.focus_relative(-1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'c',
      description = 'restore minimized',
      group       = 'client',
      on_press    = function()
         local c = awful.client.restore()
         if c then
            c:active{raise = true, context = 'key.unminimize'}
         end
      end,
   },
}

-- layout related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'j',
      description = 'swap with next client by index',
      group       = 'client',
      on_press    = function() awful.client.swap.byidx(1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'k',
      description = 'swap with previous client by index',
      group       = 'client',
      on_press    = function() awful.client.swap.byidx(-1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'u',
      description = 'jump to urgent client',
      group       = 'client',
      on_press    = awful.client.urgent.jumpto,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'l',
      description = 'increase master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(0.05) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'h',
      description = 'decrease master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(-0.05) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'h',
      description = 'increase the number of master clients',
      group       = 'layout',
      on_press    = function() awful.tag.incnmaster(1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'l',
      description = 'decrease the number of master clients',
      group       = 'layout',
      on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'h',
      description = 'increase the number of columns',
      group       = 'layout',
      on_press    = function() awful.tag.incncol(1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'l',
      description = 'decrease the number of columns',
      group       = 'layout',
      on_press    = function() awful.tag.incncol(-1, nil, true) end,
   },
}

awful.keyboard.append_global_keybindings{
	awful.key{
		modifiers	= {mod.super},
		keygroup	= "numrow",
		description = 'only view tag',
		group		= 'tag',
		on_press	= function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end
	},
	awful.key{
		modifiers	= {mod.super, mod.ctrl},
		keygroup	= "numrow",
		description	= 'toggle tag',
		group		= 'tag',
		on_press	= function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end
	},
	awful.key{
		modifiers	= {mod.super, mod.shift},
		keygroup	= "numrow",
		description = 'move focused client to tag',
		group		= 'tag',
		on_press	= function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end
	},
	awful.key {
		modifiers	= {mod.super, mod.ctrl, mod.shift},
		keygroup	= "numrow",
		description	= 'toggle focused client on tag',
		group		= 'tag',
		on_press	= function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	},
}

awful.keyboard.append_global_keybindings{
	awful.key{
		modifiers	= {mod.super, mod.shift},
		key = 's',
		description = 'take a screenshot of an area',
		group = 'screenshot',
		on_press = function()
			local tmp = '/tmp/ss-' .. os.date('%Y%m%d-%H%M%S') .. '.png'
			awful.spawn.easy_async('scrot -s ' .. tmp, function()
				awful.spawn('xclip -selection clipboard -t image/png -i ' .. tmp)
			end)
		end
	}
}
