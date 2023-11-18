local beautiful = require('beautiful')
local wibox = require('wibox')

local conf = require('config')
local contains = require('helpers.table').contains
local ui = require('helpers.ui')

local dir = contains({'left', 'right'}, conf.bar.position) and 'vertical'
            or contains({'top', 'bottom'}, conf.bar.position) and 'horizontal'

local ret = wibox.widget {
   widget = wibox.widget.textclock,
   halign = 'center',
   valign = 'center',
   format = dir == 'horizontal' and '%I:%M <span foreground=\''..beautiful.clock..'\'>%p</span>'
            or dir == 'vertical' and '%I\n%M\n<span foreground=\''..beautiful.clock..'\'>%p</span>'
}

return ui.embox(ret, {
   -- margins = 1,
   hover = true
})
