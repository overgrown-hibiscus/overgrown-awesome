local conf           = require('config')
local color          = require('modules.color')
local cols           = require('themes.' .. conf.colorscheme)

local gcr            = require('gears.color').recolor_image
local cmb            = require('helpers.image').combine
local startswith     = require('helpers.string').startswith
local layout         = require('gears.filesystem').get_configuration_dir() .. 'themes/assets/layouts/'
local button         = require('gears.filesystem').get_configuration_dir() ..
    'themes/assets/buttons/' .. conf.titlebar.button.shape .. '.svg'

local clsbtn         = require('gears.filesystem').get_configuration_dir() .. 'themes/assets/buttons/icons/close.svg'
local maxbtn         = require('gears.filesystem').get_configuration_dir() ..
    'themes/assets/buttons/icons/maximize.svg'
local minbtn         = require('gears.filesystem').get_configuration_dir() ..
    'themes/assets/buttons/icons/minimize.svg'

local darken         = function(col) return (color.color { hex = col } - "0.2l").hex end

local _T             = {}

_T.layout_tile       = gcr(layout .. "tile.png", cols.barbtns)
_T.layout_tilebottom = gcr(layout .. "tilebottom.png", cols.barbtns)
_T.layout_centered   = gcr(layout .. "centered.png", cols.barbtns)
_T.layout_mstab      = gcr(layout .. "mstab.png", cols.barbtns)
_T.layout_fairv      = gcr(layout .. "fairv.png", cols.barbtns)
_T.layout_fairh      = gcr(layout .. "fairh.png", cols.barbtns)
_T.layout_floating   = gcr(layout .. "floating.png", cols.barbtns)
_T.layout_max        = cmb(layout .. "max1.png", cols.barbtns,
    layout .. "max2.png", cols.green)

if conf.titlebar.button.shape ~= 'windows' then
    _T.titlebar_close_button_normal              = gcr(button, cols.dfg)
    _T.titlebar_minimize_button_normal           = gcr(button, cols.dfg)
    _T.titlebar_maximized_button_normal_inactive = gcr(button, cols.dfg)

    _T.titlebar_close_button_focus               = gcr(button, cols.red)
    _T.titlebar_minimize_button_focus            = gcr(button, cols.yellow)
    _T.titlebar_maximized_button_focus_inactive  = gcr(button, cols.green)

    if not startswith(conf.titlebar.button.shape, "arrow") then
        _T.titlebar_close_button_normal_hover              = cmb(button, cols.red, clsbtn, cols.bg)
        _T.titlebar_minimize_button_normal_hover           = cmb(button, cols.yellow, minbtn, cols.bg)
        _T.titlebar_maximized_button_normal_inactive_hover = cmb(button, cols.green, maxbtn, cols.bg)
        _T.titlebar_close_button_focus_hover               = cmb(button, darken(cols.red), clsbtn, cols.bg)
        _T.titlebar_minimize_button_focus_hover            = cmb(button, darken(cols.yellow), minbtn, cols.bg)
        _T.titlebar_maximized_button_focus_inactive_hover  = cmb(button, darken(cols.green), maxbtn, cols.bg)
    else
        _T.titlebar_close_button_normal_hover              = gcr(button, cols.red)
        _T.titlebar_minimize_button_normal_hover           = gcr(button, cols.yellow)
        _T.titlebar_maximized_button_normal_inactive_hover = gcr(button, cols.green)
        _T.titlebar_close_button_focus_hover               = gcr(button, darken(cols.red))
        _T.titlebar_minimize_button_focus_hover            = gcr(button, darken(cols.yellow))
        _T.titlebar_maximized_button_focus_inactive_hover  = gcr(button, darken(cols.green))
    end
else
    clsbtn                                       = require('gears.filesystem').get_configuration_dir() ..
        'themes/assets/buttons/windows/close.svg'
    maxbtn                                       = require('gears.filesystem').get_configuration_dir() ..
        'themes/assets/buttons/windows/maximize.svg'
    minbtn                                       = require('gears.filesystem').get_configuration_dir() ..
        'themes/assets/buttons/windows/minimize.svg'

    _T.titlebar_close_button_normal              = gcr(clsbtn, cols.fg)
    _T.titlebar_maximized_button_normal_inactive = gcr(maxbtn, cols.fg)
    _T.titlebar_minimize_button_normal           = gcr(minbtn, cols.fg)

    _T.titlebar_close_button_focus               = gcr(clsbtn, cols.fg)
    _T.titlebar_maximized_button_focus_inactive  = gcr(maxbtn, cols.fg)
    _T.titlebar_minimize_button_focus            = gcr(minbtn, cols.fg)
end

return _T
