#FIXME: check for better way
setxkbmap -layout "us,ua,ru" -option "grp:alt_shift_toggle"
#TODO: test if it's needed
#xrdb -merge ~/.Xresources
exec i3
