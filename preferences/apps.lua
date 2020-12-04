local awful = require("awful")

local apps = {}

apps.default = {
   terminal = "alacritty",
   lock = "i3lock",
   screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
   filebrowser = "nautilus"
}

local run_on_start_up = {
    "picom",
    "redshift",
    "unclutter"
 }

 function apps.autostart()
    for _, app in ipairs(run_on_start_up) do
       local findme = app
       local firstspace = app:find(" ")
       if firstspace then
          findme = app:sub(0, firstspace - 1)
       end
          awful.spawn.with_shell(string.format("bash -c 'pgrep -u $USER -x %s > /dev/null || (%s)'", findme, app), false)
    end
 end

 apps.autostart()

 
