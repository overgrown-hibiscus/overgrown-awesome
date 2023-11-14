local awful = require('awful')
local wibox = require('wibox')
local buttons = require('bindings.widgets.tasklist').buttons

return function(s, dir)
   return awful.widget.tasklist{
      screen = s,
      base_layout = wibox.layout.fixed[dir],
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = buttons
   }
end
