-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
require('themes')

-- load key and mouse bindings
require('bindings')

-- load rules
require('rules')

-- load signals
require('signals')
