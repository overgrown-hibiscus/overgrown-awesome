local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
require('awful.autofocus')
local wibox = require('wibox')

local conf = require('config')

local lgi = require('lgi')
local cairo = lgi.cairo

local contains = require('helpers.table').contains
local ui = require('helpers.ui')

local dir = contains({'left', 'right'}, conf.titlebar.position) and 'vertical'
         or contains({'top', 'bottom'}, conf.titlebar.position) and 'horizontal'

client.connect_signal('mouse::enter', function(c)
   c:activate{context = 'mouse_enter', raise = false}
end)

client.connect_signal('request::titlebars', function(c)

  -- gears.timer.delayed_call(round_content, c)

  local buttons = {
    awful.button({ }, 1, function()
      c:activate { context = "titlebar", action = "mouse_move"  }
    end),
    awful.button({ }, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize"}
    end),
  }

  awful.titlebar(c, {
    position = (dir == 'horizontal') and 'left'
            or (dir == 'vertical')   and 'top',
    size = conf.border_size,
    bg_normal = beautiful.border_normal,
    bg_focus = beautiful.border_focus,
    bg_urgent = beautiful.alert,
  })

  awful.titlebar(c, {
    position = (dir == 'horizontal') and 'right'
            or (dir == 'vertical')   and 'bottom',
    size = conf.border_size,
    bg_normal = beautiful.border_normal,
    bg_focus = beautiful.border_focus,
    bg_urgent = beautiful.alert,
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
            layout = wibox.layout.flex[dir],
            awful.titlebar.widget.iconwidget(c),
            nil,
            {
              awful.titlebar.widget.maximizedbutton(c),
              awful.titlebar.widget.minimizebutton(c),
              awful.titlebar.widget.closebutton(c),
              layout = wibox.layout.align[dir]
            },
          },
          widget = wibox.container.background,
          shape = ui.shape.prrect(conf.corner_radius - conf.border_size, {
            tl = contains({'top', 'left'},     conf.titlebar.position),
            tr = contains({'top', 'right'},    conf.titlebar.position),
            br = contains({'bottom', 'right'}, conf.titlebar.position),
            bl = contains({'bottom', 'left'},  conf.titlebar.position),
          }),
          bg = beautiful.bg,
          id = 'inner'
        },
        widget = wibox.container.margin,
        top    = ('top'    ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        left   = ('left'   ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        bottom = ('bottom' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        right  = ('right'  ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        
        id = 'border',
      },
      widget = wibox.container.background,
      shape = ui.shape.prrect(conf.corner_radius, {
        tl = contains({'top', 'left'},     conf.titlebar.position),
        tr = contains({'top', 'right'},    conf.titlebar.position),
        br = contains({'bottom', 'right'}, conf.titlebar.position),
        bl = contains({'bottom', 'left'},  conf.titlebar.position),
      }),
      bg = beautiful.border_normal,
      buttons = buttons,
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
            tl = contains({'top', 'left'},     conf.titlebar.position),
            tr = contains({'top', 'right'},    conf.titlebar.position),
            br = contains({'bottom', 'right'}, conf.titlebar.position),
            bl = contains({'bottom', 'left'},  conf.titlebar.position),
          }),
          bg = beautiful.bg,
          id = 'inner'
        },
        widget = wibox.container.margin,
        top    = ('top'    ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        left   = ('left'   ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        bottom = ('bottom' ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        right  = ('right'  ~= ui.opposite(conf.titlebar.position)) and conf.border_size or 0,
        
        id = 'border',
      },
      widget = wibox.container.background,
      shape = ui.shape.prrect(conf.corner_radius, {
        tl = contains({'top', 'left'},     conf.titlebar.position),
        tr = contains({'top', 'right'},    conf.titlebar.position),
        br = contains({'bottom', 'right'}, conf.titlebar.position),
        bl = contains({'bottom', 'left'},  conf.titlebar.position),
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
          tl = contains({'top', 'left'},     ui.opposite(conf.titlebar.position)),
          tr = contains({'top', 'right'},    ui.opposite(conf.titlebar.position)),
          br = contains({'bottom', 'right'}, ui.opposite(conf.titlebar.position)),
          bl = contains({'bottom', 'left'},  ui.opposite(conf.titlebar.position)),
        }),
        bg = beautiful.bg,
        id = 'inner'
      },
      widget = wibox.container.margin,
      top    = ('top'    ~= conf.titlebar.position) and conf.border_size or 0,
      left   = ('left'   ~= conf.titlebar.position) and conf.border_size or 0,
      bottom = ('bottom' ~= conf.titlebar.position) and conf.border_size or 0,
      right  = ('right'  ~= conf.titlebar.position) and conf.border_size or 0,
      
      id = 'border',
    },
    widget = wibox.container.background,
      shape = ui.shape.prrect(conf.corner_radius, {
      tl = contains({'top', 'left'},     ui.opposite(conf.titlebar.position)),
      tr = contains({'top', 'right'},    ui.opposite(conf.titlebar.position)),
      br = contains({'bottom', 'right'}, ui.opposite(conf.titlebar.position)),
      bl = contains({'bottom', 'left'},  ui.opposite(conf.titlebar.position)),
    }),
    bg = beautiful.border_normal,
    buttons = buttons,
  })
end)

client.connect_signal('focus', function(c)
	awful.titlebar(c, { position = (dir == 'horizontal') and 'left'
                              or (dir == 'vertical')   and 'top',    bg = beautiful.border_focus, size = conf.border_size })
	awful.titlebar(c, { position = (dir == 'horizontal') and 'right'
                              or (dir == 'vertical')   and 'bottom', bg = beautiful.border_focus, size = conf.border_size})
	awful.titlebar(c, { position = conf.titlebar.position, size = (not c.requests_no_titlebar and conf.titlebar.size or conf.corner_radius) + conf.border_size }).widget.bg = beautiful.border_focus
  awful.titlebar(c, { position = ui.opposite(conf.titlebar.position), size = conf.corner_radius + conf.border_size}).widget.bg = beautiful.border_focus
end)

client.connect_signal('unfocus', function(c)
	awful.titlebar(c, { position = (dir == 'horizontal') and 'left'
                              or (dir == 'vertical')   and 'top',    bg = beautiful.border_normal, size = conf.border_size })
	awful.titlebar(c, { position = (dir == 'horizontal') and 'right'
                              or (dir == 'vertical')   and 'bottom', bg = beautiful.border_normal, size = conf.border_size})
	awful.titlebar(c, { position = conf.titlebar.position, size = (not c.requests_no_titlebar and conf.titlebar.size or conf.corner_radius) + conf.border_size }).widget.bg = beautiful.border_normal
  awful.titlebar(c, { position = ui.opposite(conf.titlebar.position), size = conf.corner_radius + conf.border_size}).widget.bg = beautiful.border_normal
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
