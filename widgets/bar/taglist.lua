local awful = require('awful')
local wibox = require('wibox')
local buttons = require('bindings.widgets.taglist').buttons

return function(s, dir)
   return awful.widget.taglist{
      screen = s,
      base_layout = wibox.layout.fixed[dir],
      filter = awful.widget.taglist.filter.all,
      buttons = buttons
   }
end

