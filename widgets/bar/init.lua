local awful = require('awful')
local wibox = require('wibox')

local conf = require('config')

local menu = require('widgets.menu')
local taglist = require('widgets.bar.taglist')
local tasklist = require('widgets.bar.tasklist')
local layoutbox = require('widgets.bar.layoutbox')

local contains = require('helpers.table').contains

local dir = contains({'left', 'right'}, conf.bar.position) and 'vertical'
            or contains({'top', 'bottom'}, conf.bar.position) and 'horizontal'

return function(s)
   s.widgets = {
      layoutbox      = layoutbox(s),
      taglist        = taglist(s, dir),
      tasklist       = tasklist(s, dir),
      keyboardlayout = awful.widget.keyboardlayout(),
      promptbox      = awful.widget.prompt(),
      systray        = wibox.widget{widget = wibox.widget.systray, horizontal = (dir == 'horizontal')},
      textclock      = wibox.widget.textclock(),
   }

   s.widgets.wibar = awful.wibar{
      screen = s,
      position = conf.bar.position,
      widget = {
         layout = wibox.layout.align[dir],
         -- left widgets
         {
            layout = wibox.layout.fixed[dir],
            menu.launcher,
            s.widgets.taglist,
            s.widgets.promptbox,
         },
         -- middle widgets
         s.widgets.tasklist,
         -- right widgets
         {
            layout = wibox.layout.fixed[dir],
            s.widgets.systray,
            s.widgets.layoutbox,
            s.widgets.textclock,
         }
      }
   }
end
