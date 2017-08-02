#!/bin/sh
Xvfb :0 2> /dev/null &
wine lib/Speak.exe "$1"
