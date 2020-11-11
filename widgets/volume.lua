local wibox = require('wibox')
local vicious = require("../vicious")


vol = wibox.widget.textbox()
local sink = "alsa_output.pci-0000_00_1b.0.analog-stereo"
vicious.register(vol, vicious.widget.volume, " $1%", 2, sink)

return vol