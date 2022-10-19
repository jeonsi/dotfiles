#!/bin/sh
#
# ██╗  ██╗██╗███╗   ██╗██╗████████╗██████╗  ██████╗
# ╚██╗██╔╝██║████╗  ██║██║╚══██╔══╝██╔══██╗██╔════╝
#  ╚███╔╝ ██║██╔██╗ ██║██║   ██║   ██████╔╝██║
#  ██╔██╗ ██║██║╚██╗██║██║   ██║   ██╔══██╗██║
# ██╔╝ ██╗██║██║ ╚████║██║   ██║   ██║  ██║╚██████╗
# ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝
#
# Xinit Config File by Arfan Zubi


userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in Defaults and Keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Start some nice Programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Start i3 Window Manager when starting X Server
exec i3
