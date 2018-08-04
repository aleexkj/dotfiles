xrdb -merge .Xresources
unclutter -idle 1 &
setterm -blank 0
xset s off
xmodmap ~/.xmodmap
xset -r 135 
sh bin/touchpad.sh
setxkbmap latam
exec xmonad
