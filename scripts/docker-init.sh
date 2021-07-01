#!/bin/bash

Xvfb :99 -screen 0 640x480x24 -nolisten tcp +extension GLX +render & 
export DISPLAY=:99

/bin/bash

