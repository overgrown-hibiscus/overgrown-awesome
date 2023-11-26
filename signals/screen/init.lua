local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local wibox = require('wibox')

local ranfile = gfs.get_random_file_from_dir
local confdir = gfs.get_configuration_dir()

local conf = require('config')
local image = require('helpers.image')
local widgets = require('widgets')

screen.connect_signal('request::wallpaper', function(s)
   awful.wallpaper{
      screen = s,
      widget = {
         image     = image.crop(s.geometry.width/s.geometry.height,
                        gears.surface.load_uncached(conf.wallpaper or
                           ranfile(confdir .. 'themes/' .. conf.colorscheme .. '/walls/',
                                   {'png', 'jpg', 'svg'}, true)
                        )
                     ),
         upscale   = true,
         downscale = true,
         widget    = wibox.widget.imagebox,
      }

   }
end)

screen.connect_signal('request::desktop_decoration', function(s)
   awful.tag(conf.tags, s, awful.layout.layouts[1])
   s.wibox     = widgets.bar(s)
end)
