local beautiful = require('beautiful')
local conf = require('config')

local _M = {}

local export = function(t)
	for k, v in pairs(t) do
		_M[k] = v
	end
end


export(require('themes.' .. conf.colorscheme .. '.cols'))
export(require('themes.import'))
export(require('themes.misc'))
export(require('themes.recolor'))
export(require('themes.settings'))

beautiful.init(_M)
