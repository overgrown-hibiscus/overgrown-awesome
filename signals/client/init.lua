local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
require('awful.autofocus')
local wibox        = require('wibox')

local conf         = require('config')

local lgi          = require('lgi')
local Gio          = lgi.Gio
local cairo        = lgi.cairo

local contains     = require('helpers.table').contains
local startswith   = require('helpers.string').startswith
local ui           = require('helpers.ui')

local icon_helpers = require('modules.bling.helpers.icon_theme')
local icon_theme   = icon_helpers(beautiful.icons)

local dir          = contains({ 'left', 'right' }, conf.titlebar.position) and 'vertical'
    or contains({ 'top', 'bottom' }, conf.titlebar.position) and 'horizontal'

local apps         = Gio.AppInfo.get_all()

client.connect_signal('manage', function(c)
    if c.x == 0 and c.y == 0 then
        awful.placement.centered(c)
    end


    if c and c.valid then
        local icon = icon_theme:get_icon_path(c.instance)

        if not icon or icon == "" then
            icon = icon_theme:get_icon_path(c.class)
        end
        if not icon or icon == "" then
            icon = icon_theme:get_client_icon_path(c)
        end
        if not icon or icon == "" then
            icon = "/usr/share/icons/" .. beautiful.icons .. "/apps/scalable/application-default-icon.svg"
        end

        local s = gears.surface(icon)
        local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
        local cr = cairo.Context(img)
        cr:set_source_surface(s, 0, 0)
        cr:paint()
        c.icon = img._native
    end
end)

client.connect_signal('mouse::enter', function(c)
    c:activate { context = 'mouse_enter', raise = false }
end)

client.connect_signal('request::titlebars', function(c)
    -- gears.timer.delayed_call(round_content, c)

    local buttons = {
        awful.button({}, 1, function()
            c:activate { context = "titlebar", action = "mouse_move" }
        end),
        awful.button({}, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize" }
        end),
    }

    local titlebarbuttons
    if conf.titlebar.button.shape ~= 'windows' then
        titlebarbuttons = wibox.widget {
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed[dir],
            spacing = startswith(conf.titlebar.button.shape, "arrow") and 0
                or (conf.titlebar.size - conf.titlebar.button.size) / 2,
        }
    else
        titlebarbuttons = wibox.widget {
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed[dir],
            spacing = 0,
        }
    end

    awful.titlebar(c, {
        position  = (dir == 'horizontal') and 'left'
            or (dir == 'vertical') and 'top',
        size      = conf.border_size,
        bg_normal = "#00000000",
        bg_focus  = "#00000000",
        bg_urgent = "#00000000",
    }):setup({
        {
            nil,
            layout = wibox.layout.flex[dir],
        },
        widget = wibox.container.background,
        shape  = ui.shape.prrect(conf.corner_radius, {
            tl = (dir == 'vertical'),
            tr = true,
            bl = (dir == 'horizontal'),
            br = false,
        }),
        bg     = beautiful.border_normal
    })

    awful.titlebar(c, {
        position  = (dir == 'horizontal') and 'right'
            or (dir == 'vertical') and 'bottom',
        size      = conf.border_size,
        bg_normal = "#00000000",
        bg_focus  = "#00000000",
        bg_urgent = "#00000000",
    }):setup({
        {
            nil,
            layout = wibox.layout.flex[dir],
        },
        widget = wibox.container.background,
        shape  = ui.shape.prrect(conf.corner_radius, {
            tl = (dir == 'vertical'),
            tr = true,
            bl = (dir == 'horizontal'),
            br = false,
        }),
        bg     = beautiful.border_normal
    })

    if c.requests_no_titlebar ~= true then
        awful.titlebar(c, {
            position = conf.titlebar.position,
            size = conf.titlebar.size + conf.border_size,
            bg_normal = "#00000000",
            bg_focus = "#00000000",
            bg_urgent = "#00000000",
        }):setup({
            {
                {
                    {
                        layout = wibox.layout.align[dir],
                        {
                            {
                                awful.titlebar.widget.iconwidget(c),
                                widget = wibox.container.margin,
                                margins = 2,
                            },
                            {
                                widget = awful.titlebar.widget.titlewidget(c),
                                font = beautiful.sans_font,
                            },
                            layout = wibox.layout.fixed[dir],
                            spacing = 4,
                            buttons = buttons,
                        },
                        {
                            wibox.widget.base.empty_widget(),
                            layout = wibox.layout.flex[dir],
                            buttons = buttons,
                        },
                        {
                            titlebarbuttons,
                            widget = wibox.container.margin,
                            margins = conf.titlebar.button.shape == "windows" and 0
                                or (conf.titlebar.size - conf.titlebar.button.size) / 2,
                        },
                    },
                    widget = wibox.container.background,
                    shape = ui.shape.prrect(conf.corner_radius - conf.border_size, {
                        tl = contains({ 'top', 'left' }, conf.titlebar.position),
                        tr = contains({ 'top', 'right' }, conf.titlebar.position),
                        br = contains({ 'bottom', 'right' }, conf.titlebar.position),
                        bl = contains({ 'bottom', 'left' }, conf.titlebar.position),
                    }),
                    bg = beautiful.bg,
                    id = 'inner'
                },
                widget = wibox.container.margin,
                top    = ('top' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
                left   = ('left' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
                bottom = ('bottom' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
                right  = ('right' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,

                id     = 'border',
            },
            widget = wibox.container.background,
            shape = ui.shape.prrect(conf.corner_radius, {
                tl = contains({ 'top', 'left' }, conf.titlebar.position),
                tr = contains({ 'top', 'right' }, conf.titlebar.position),
                br = contains({ 'bottom', 'right' }, conf.titlebar.position),
                bl = contains({ 'bottom', 'left' }, conf.titlebar.position),
            }),
            bg = beautiful.border_normal,
        })
    else
        awful.titlebar(c, {
            position = conf.titlebar.position,
            size = conf.corner_radius + conf.border_size,
            bg_normal = "#00000000",
            bg_focus = "#00000000",
            bg_urgent = "#00000000",
        }):setup({
            {
                {
                    {
                        nil,
                        layout = wibox.layout.flex[dir],
                    },
                    widget = wibox.container.background,
                    shape = ui.shape.prrect(conf.corner_radius - conf.border_size, {
                        tl = contains({ 'top', 'left' }, conf.titlebar.position),
                        tr = contains({ 'top', 'right' }, conf.titlebar.position),
                        br = contains({ 'bottom', 'right' }, conf.titlebar.position),
                        bl = contains({ 'bottom', 'left' }, conf.titlebar.position),
                    }),
                    bg = beautiful.bg,
                    id = 'inner'
                },
                widget = wibox.container.margin,
                top    = ('top' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
                left   = ('left' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
                bottom = ('bottom' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
                right  = ('right' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,

                id     = 'border',
            },
            widget = wibox.container.background,
            shape = ui.shape.prrect(conf.corner_radius, {
                tl = contains({ 'top', 'left' }, conf.titlebar.position),
                tr = contains({ 'top', 'right' }, conf.titlebar.position),
                br = contains({ 'bottom', 'right' }, conf.titlebar.position),
                bl = contains({ 'bottom', 'left' }, conf.titlebar.position),
            }),
            bg = beautiful.border_normal,
            buttons = buttons,
        })
    end
    awful.titlebar(c, {
        position = ui.opposite(conf.titlebar.position),
        size = conf.corner_radius + conf.border_size,
        bg_normal = "#00000000",
        bg_focus = "#00000000",
        bg_urgent = "#00000000",
    }):setup({
        {
            {
                {
                    nil,
                    layout = wibox.layout.flex[dir],
                },
                widget = wibox.container.background,
                shape = ui.shape.prrect(conf.corner_radius - conf.border_size, {
                    tl = contains({ 'top', 'left' }, ui.opposite(conf.titlebar.position)),
                    tr = contains({ 'top', 'right' }, ui.opposite(conf.titlebar.position)),
                    br = contains({ 'bottom', 'right' }, ui.opposite(conf.titlebar.position)),
                    bl = contains({ 'bottom', 'left' }, ui.opposite(conf.titlebar.position)),
                }),
                bg = beautiful.bg,
                id = 'inner'
            },
            widget = wibox.container.margin,
            top    = ('top' ~= conf.titlebar.position) and conf.border_size or 0,
            left   = ('left' ~= conf.titlebar.position) and conf.border_size or 0,
            bottom = ('bottom' ~= conf.titlebar.position) and conf.border_size or 0,
            right  = ('right' ~= conf.titlebar.position) and conf.border_size or 0,

            id     = 'border',
        },
        widget = wibox.container.background,
        shape = ui.shape.prrect(conf.corner_radius, {
            tl = contains({ 'top', 'left' }, ui.opposite(conf.titlebar.position)),
            tr = contains({ 'top', 'right' }, ui.opposite(conf.titlebar.position)),
            br = contains({ 'bottom', 'right' }, ui.opposite(conf.titlebar.position)),
            bl = contains({ 'bottom', 'left' }, ui.opposite(conf.titlebar.position)),
        }),
        bg = beautiful.border_normal,
        buttons = buttons,
    })
end)

client.connect_signal('focus', function(c)
    awful.titlebar(c, {
        position = (dir == 'horizontal') and 'left'
            or (dir == 'vertical') and 'top',
        size = conf.border_size })
    .widget.bg = beautiful.border_focus

    awful.titlebar(c, {
        position = (dir == 'horizontal') and 'right'
            or (dir == 'vertical') and 'bottom',
        size = conf.border_size })
    .widget.bg = beautiful.border_focus

    awful.titlebar(c, {
        position = conf.titlebar.position,
        size = (not c.requests_no_titlebar and conf.titlebar.size or conf.corner_radius)
            + conf.border_size })
    .widget.bg = beautiful.border_focus

    awful.titlebar(c, {
        position = ui.opposite(conf.titlebar.position),
        size = conf.corner_radius + conf.border_size })
    .widget.bg = beautiful.border_focus
end)

client.connect_signal('unfocus', function(c)
    awful.titlebar(c, {
        position = (dir == 'horizontal') and 'left'
            or (dir == 'vertical') and 'top',
        size = conf.border_size })
    .widget.bg = beautiful.border_normal

    awful.titlebar(c, {
        position = (dir == 'horizontal') and 'right'
            or (dir == 'vertical') and 'bottom',
        size = conf.border_size })
    .widget.bg = beautiful.border_normal

    awful.titlebar(c, {
        position = conf.titlebar.position,
        size = (not c.requests_no_titlebar and conf.titlebar.size or conf.corner_radius)
            + conf.border_size })
    .widget.bg = beautiful.border_normal

    awful.titlebar(c, {
        position = ui.opposite(conf.titlebar.position),
        size = conf.corner_radius + conf.border_size })
    .widget.bg = beautiful.border_normal
end)

-- local function round_content(c)
--   local surface = cairo.ImageSurface.create(cairo.Format.ARGB32, c.width, c.height)
--   local cr = cairo.Context(surface)
--
--   local titlebar_size = 18
--
--   -- cr:set_antialias(cairo.antialias_BEST)
--   -- cr:set_antialias(cairo.antialias.BEST)
--   -- cr:set_antialias(cairo.antialias_SUBPIXEL)
--   -- cr:set_antialias(cairo.antialias.SUBPIXEL)
--   -- cr:set_antialias(cairo.Antialias_BEST)
--   -- cr:set_antialias(cairo.Antialias.BEST)
--   -- cr:set_antialias(cairo.Antialias_SUBPIXEL)
--   -- cr:set_antialias(cairo.Antialias.SUBPIXEL)
--   -- cr:set_antialias(cairo.ANTIALIAS_BEST)
--   -- cr:set_antialias(cairo.ANTIALIAS.BEST)
--   -- cr:set_antialias(cairo.ANTIALIAS_SUBPIXEL)
--   -- cr:set_antialias(cairo.ANTIALIAS.SUBPIXEL)
--
--   -- cr.antialias = cairo.antialias_BEST
--   -- cr.antialias = cairo.antialias.BEST
--   -- cr.antialias = cairo.antialias_SUBPIXEL
--   -- cr.antialias = cairo.antialias.SUBPIXEL
--   -- cr.antialias = cairo.Antialias_BEST
--   -- cr.antialias = cairo.Antialias.BEST
--   -- cr.antialias = cairo.Antialias_SUBPIXEL
--   -- cr.antialias = cairo.Antialias.SUBPIXEL
--   -- cr.antialias = cairo.ANTIALIAS_BEST
--   -- cr.antialias = cairo.ANTIALIAS.BEST
--   -- cr.antialias = cairo.ANTIALIAS_SUBPIXEL
--   -- cr.antialias = cairo.ANTIALIAS.SUBPIXEL
--
--   cr:move_to(beautiful.corner_radius, titlebar_size)
--   cr:line_to(c.width - beautiful.corner_radius, titlebar_size)
--   cr:arc(c.width - beautiful.corner_radius, titlebar_size + beautiful.corner_radius, beautiful.corner_radius, -math.pi / 2, 0)
--   cr:line_to(c.width, c.height - beautiful.corner_radius)
--   cr:arc(c.width - beautiful.corner_radius, c.height - beautiful.corner_radius, beautiful.corner_radius, 0, math.pi / 2)
--   cr:line_to(beautiful.corner_radius, c.height)
--   cr:arc(beautiful.corner_radius, c.height - beautiful.corner_radius, beautiful.corner_radius, math.pi / 2, math.pi)
--   cr:line_to(0, beautiful.corner_radius + titlebar_size)
--   cr:arc(beautiful.corner_radius, titlebar_size + beautiful.corner_radius, beautiful.corner_radius, math.pi, 3 * math.pi / 2)
--   cr:close_path()
--
--   cr:set_source_rgba(0, 0.0, 0.0, 0.5)
--   cr:fill()
--
--   c.shape_clip = surface._native
--
--   surface:finish()
-- end
