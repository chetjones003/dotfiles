-- http://projects.haskell.org/xmobar/
-- I use Font Awesome 5 fonts in this config for unicode "icons".  On Arch Linux,
-- install this package from the AUR to get these fonts: otf-font-awesome-5-free

Config { font    = "xft:Ubuntu:weight=bold:pixelsize=10:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki Nerd Font:pixelsize=10:antialias=true:hinting=true"
                           , "xft:Font Awesome 5 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 5 Brands:pixelsize=12"
                           ]
       , bgColor = "#282a36"
       , fgColor = "#ff6c6b"
       , position = Static { xpos = 0 , ypos = 0, width = 1280, height = 25 }
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , iconRoot = "/home/chetj/.xmonad/xpm/"  -- default: "."
       , commands = [
                      -- Time and date
                      Run Date "<fn=2>\xf017</fn>  %b %d %Y - (%I:%M%P) " "date" 50
                      -- Cpu usage in percent
                    , Run Cpu ["-t", "<fn=2>\xf108</fn> (<total>%)","-H","50","--high","red"] 20
                      -- Battery
                    , Run Com "/bin/bash" ["-c", "~/.config/xmobar/batt.sh"] "battery" 20
                      -- Volume
                    , Run Com "/bin/bash" ["-c", "~/.config/xmobar/getMasterVolume.sh"] "vol" 5
                      -- Brightness
                    , Run Com "/bin/bash" ["-c", "xbacklight -get | grep -oE '^.[0-9]{0,3}'"] "bright" 5
                      -- Wifi
                    , Run Com "/bin/bash" ["-c", "~/.config/xmobar/wifi.sh"] "network" 20
                      -- Memory
                    , Run Memory ["-t", "<fn=2>\xf233</fn> <used>M (<usedratio>%)"] 20
                      -- Runs custom script to check for pacman updates.
                    , Run Com "/home/chetj/.local/bin/pacupdate" [] "pacupdate" 36000
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell_20.xpm/> <fc=#666666>|</fc> %UnsafeStdinReader% }{  <fc=#666666>|</fc> <fn=2></fn> %network% <fc=#666666>|</fc> <fc=#ecbe7b> <action=`alacritty -e htop`>%cpu%</action> </fc> <fc=#666666>|</fc>  <fc=#1af78e> <action=`alacritty -e htop`>%memory%</action> </fc> <fc=#666666>|</fc> <fc=#c678dd><fn=2></fn>  <action=`alacritty -e sudo pacman -Syu`>%pacupdate%</action> </fc> <fc=#666666>|</fc>  <fc=#57c7ff>%date%</fc> <fc=#666666>|</fc>  <fc=#9aedfe><fn=2></fn> %vol%</fc> <fc=#666666>|</fc> <fc=#eff0eb><fn=2></fn> %bright%</fc> <fc=#666666>|</fc> <fc=#ecbe7b><fn=2></fn> %battery%</fc>"
       }
