local wibox   = require('wibox')
local vicious = require('../vicious')
require("../modules.widget")

textbox = wibox.widget.textbox()

date = pill(textbox, "#2D2D2D")

vicious.register(textbox, vicious.widgets.date, "%b %d, %R")

return date