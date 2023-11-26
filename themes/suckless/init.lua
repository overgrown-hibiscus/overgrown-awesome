local assets  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/"
local theme_assets = require("beautiful.theme_assets")
local cols = {}

cols.black      = "#000000"
cols.red        = "#cd0000"
cols.green      = "#00cd00"
cols.yellow     = "#cdcd00"
cols.blue       = "#0000ee"
cols.magenta    = "#cd00cd"
cols.cyan       = "#00cdcd"
cols.white      = "#eeeeee"
							
cols.bg         = "#222222"
cols.fg         = "#bbbbbb"
cols.dbg        = "#005577"
cols.lbg        = "#444444"
cols.dfg        = "#227799"

cols.alert      = "#ff0000"

cols.taglist_bg_empty = cols.bg
cols.taglist_fg_empty = cols.fg
cols.taglist_bg_focus = cols.dbg
cols.taglist_fg_focus = cols.white

cols.bg_systray = cols.bg

cols.tasklist_disable_icon = true
cols.tasklist_plain_task_name = true,
cols.tasklist_disable_task_name = false,

cols.tasklist_bg_normal = cols.bg
cols.tasklist_fg_normal = cols.fg
cols.tasklist_bg_focus  = cols.dbg
cols.tasklist_fg_focus  = cols.white

local taglist_square_size = 4
cols.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, cols.tasklist_fg_normal
)
cols.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, cols.tasklist_fg_normal
)

cols.barbtns    = cols.white
cols.clock      = cols.red
cols.notifs     = cols.blue

cols.border_normal = cols.lbg
cols.border_focus  = cols.dbg

cols.launcher   = nil
cols.pfpbg      = cols.dbg

return cols
