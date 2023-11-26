local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")
local cairo     = require('lgi').cairo
local color     = require("modules.color")
local rubato    = require("modules.rubato")

local _M = {
	combine = function(img1,col1,img2,col2,w,h)
	local w = w or 64
	local h = h or 64
	return wibox.widget.draw_to_image_surface (wibox.widget {
		wibox.widget.imagebox(gears.color.recolor_image(img1,col1)),
		wibox.widget.imagebox(gears.color.recolor_image(img2,col2)),
		layout = wibox.layout.stack },
		w,h)
	end
}

-- Blyaticon's image cropping function, uses a cairo surface which it crops to a ratio.
-- https://git.gemia.net/paul.s/homedots/-/blob/main/awesome/helpers.lua#L133
function _M.crop(ratio, surf)
   local old_w, old_h = gears.surface.get_size(surf)
   local old_ratio    = old_w / old_h
   if old_ratio == ratio then return surf end

   local new_w = old_w
   local new_h = old_h
   local offset_w, offset_h = 0, 0
   -- quick mafs
   if (old_ratio < ratio) then
      new_h    = math.ceil(old_w * (1 / ratio))
      offset_h = math.ceil((old_h - new_h) / 2)
   else
      new_w    = math.ceil(old_h * ratio)
      offset_w = math.ceil((old_w - new_w) / 2)
   end

   local out_surf = cairo.ImageSurface(cairo.Format.ARGB32, new_w, new_h)
   local cr       = cairo.Context(out_surf)
   cr:set_source_surface(surf, -offset_w, -offset_h)
   cr.operator    = cairo.Operator.SOURCE
   cr:paint()

   return out_surf
end

return _M
