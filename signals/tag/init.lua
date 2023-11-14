local awful = require('awful')
local conf = require('config')

tag.connect_signal('request::default_layouts', function()
   awful.layout.append_default_layouts(conf.layouts)
end)
