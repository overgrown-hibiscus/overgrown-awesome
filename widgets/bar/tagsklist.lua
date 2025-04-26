local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local ui = require('helpers.ui')

local tagbuttons = require('bindings.widgets.taglist').buttons
local taskbuttons = require('bindings.widgets.tasklist').buttons

local function gen_filter(t)
    return function(c, s)
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
                            {
                                {
                                    id = "text_role",
                                    widget = wibox.widget.textbox,
                                    valign = "center",
                                    halign = "center",
                                },
                                widget = wibox.container.margin,
                                margins = {
                                    top = 4,
                                    bottom = 4,
                                    left = 6,
                                    right = 6,
                                }
                            },
                            id = "background_role",
                            widget = wibox.container.background,
                        },
                        widget = wibox.container.background,
                        shape = ui.shape.rrect(beautiful.corner_radius)
                    },
                    {
                        {
                            id = "taginfo_role",
                            layout = wibox.layout.fixed[dir],
                        },
                        widget = wibox.container.margin,
                        margins = {
                            left = dir == 'horizontal' and 2,
                            top  = dir == 'vertical' and 2,
                        },
                    },
                    layout = wibox.layout.fixed[dir]
                },
                widget = wibox.container.background,
                bg = beautiful.lbg,
                -- bg = "#0000ff"
            },
            widget = wibox.container.background,
            shape = ui.shape.rrect(beautiful.corner_radius),

            create_callback = function(self, t, i, _)
                self:get_children_by_id("taginfo_role")[1]:add(
                    awful.widget.tasklist {
                        screen = s,
                        filter = gen_filter(t),
                        buttons = taskbuttons,
                        -- base_layout = wibox.layout.fixed[dir],
                        id = "tasklist_role",
                        layout = {
                            spacing = 4,
                            layout = wibox.layout.fixed[dir]
                        },
                        widget_template = {
                            awful.widget.clienticon,
                            margins = 2,
                            widget = wibox.container.margin
                        }
                    }
                )
            end,
        },
    }
end
