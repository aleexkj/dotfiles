xrdb -merge .Xresources
unclutter -idle 1 &
setterm -blank 0
xset s off
xmodmap .xmodmap
xset -r 135 
# xrandr --output HDMI-1 --rotate left --auto --right-of eDP-1 --output eDP-1 --auto
sh touchpad.sh
feh --bg-max --randomize  ~/wg/* &
exec xmonad
