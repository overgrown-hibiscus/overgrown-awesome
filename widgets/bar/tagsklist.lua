local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local ui = require('helpers.ui')

local tagbuttons = require('bindings.widgets.taglist').buttons
local taskbuttons = require('bindings.widgets.tasklist').buttons

local function gen_filter(t)
   return function (c, s)
      local ct = c:tags()
      for _, v in ipairs(ct) do
         if v == t then
            return true
         end
      end
      return false
   end
end

return function(s, dir)
   return awful.widget.taglist {
      screen = s,
      layout = {
         spacing = 4,
         layout = wibox.layout.fixed[dir],
      },
      filter = awful.widget.taglist.filter.all,
      buttons = tagbuttons,
      widget_template = {
         {
            {
               {
                  {
                     id = "text_role",
                     widget = wibox.widget.textbox,
                     valign = "center",
                     halign = "center",
                  },
                  {
                     widget = wibox.widget.textbox,
                     forced_width = 2,
                     forced_height = 2,
                  },
                  {
                     widget = wibox.widget.textbox,
                     forced_width = 2,
                     forced_height = 2,
                  },
                  id = "taginfo_role",
                  layout = wibox.layout.fixed[dir],
               },
               widget = wibox.container.margin,
               margins = {
                  left   = dir == 'horizontal' and 4 or 2,
                  top    = dir == 'vertical'   and 4 or 2,
                  right  = dir == 'vertical'   and 2,
                  bottom = dir == 'horizontal' and 2,
               },
            },
            id = "background_role",
            widget = wibox.container.background,
         },
         widget = wibox.container.background,
         shape = ui.shape.rrect(beautiful.border_radius),
         
         create_callback = function(self, t, i, _)
            self:get_children_by_id("taginfo_role")[1]:insert(3, 
               awful.widget.tasklist {
                  screen = s,
                  filter = gen_filter(t),
                  buttons = taskbuttons,
                  base_layout = wibox.layout.fixed[dir],
                  id = "tasklist_role",
               }
            )
         end,
      },
   }
end
