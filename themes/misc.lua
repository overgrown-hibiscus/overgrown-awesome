local conf = require('config')
local cols = require('themes.' .. conf.colorscheme)
local dpi  = require('beautiful').xresources.apply_dpi

local _T   = {
    bg_focus                   = cols.lbg,
    bg_urgent                  = cols.alert,
    bg_minimize                = cols.dbg,

    fg_normal                  = cols.fg,
    fg_focus                   = cols.fg,
    fg_urgent                  = cols.fg,
    fg_minimize                = cols.fg,

    taglist_bg_empty           = cols.lbg,
    taglist_bg_occupied        = cols.dfg,
    taglist_bg_focus           = cols.taglist,

    taglist_fg_empty           = cols.dfg,
    taglist_fg_occupied        = cols.fg,
    taglist_fg_focus           = cols.bg,

    tasklist_bg_normal         = '#00000000',
    tasklist_bg_focus          = '#00000000',
    tasklist_bg_urgent         = '#00000000',
    tasklist_bg_minimize       = '#00000000',

    titlebar_bg                = '#00000000',
    titlebar_bg_normal         = '#00000000',
    titlebar_bg_focus          = '#00000000',
    titlebar_bg_urgent         = '#00000000',

    tasklist_disable_task_name = true,
    tasklist_plain_task_name   = true,

    bg_systray                 = cols.dbg,

    tabbar_disable             = true,
    mstab_bar_padding          = dpi(conf.gaps),
    mstab_border_radius        = dpi(conf.corner_radius),
    mstab_tabbar_style         = "boxes",

    border_width               = 0,
    menu_height                = dpi(20),
    menu_width                 = dpi(150),
    icon_theme                 = "Papirus",
}

return _T
