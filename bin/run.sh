#!/bin/sh
export DISPLAY=:0
Xvfb :0 2> /dev/null &
wine lib/Speak.exe "$1"
