local awful = require('awful')
local beautiful = require('beautiful')
local ruled = require('ruled')

ruled.notification.connect_signal('request::rules', function()
   -- All notifications will match this rule.
   ruled.notification.append_rule {
      rule       = {},
      properties = {
         screen           = awful.screen.preferred,
         implicit_timeout = 5,
      }
   }
end)

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            border_width = beautiful.border_width,
            focus        = awful.client.focus.filter,
            raise        = true,
            screen       = awful.screen.preferred,
            placement    = awful.placement.center+awful.placement.no_offscreen
        }
    }
end)
