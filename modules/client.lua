local gears = require('gears')

-- Create rounded corners for windows
client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,4)
    end
end)