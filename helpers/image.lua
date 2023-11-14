local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")
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

return _M
