#!/bin/sh
intern=eDP1
extern=HDMI2

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --primary --auto --output "$extern" --above "$intern" --auto
    feh --bg-center $HOME/Downloads/flowers.png $HOME/Downloads/flowers.png
fi
