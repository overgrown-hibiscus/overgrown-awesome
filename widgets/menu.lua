local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup')
local conf = require('config')

local _M = {}

_M.awesomemenu = {
   {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
   {'edit config', conf.apps.editor_cmd .. ' ' .. awesome.conffile},
   {'restart', awesome.restart},
   {'quit', function() awesome.quit() end},
}

_M.mainmenu = awful.menu{
   items = {
      {'awesome', _M.awesomemenu, beautiful.awesome_icon},
      {'open terminal', conf.terminal}
   }
}

_M.launcher = awful.widget.launcher {
   image = beautiful.bar_icon,
   menu = _M.mainmenu,
}

return _M
