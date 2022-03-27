# womic-linux
Bash script for running WO Mic on Linux

## Purpose
The purpose of this script is to be able to connect to a locally started WO Mic server in the background and exit the terminal freely, without having to remember the PID, when you want to disconnect.

## Notes
The WO Mic Appimage binary has to be downloaded in order for the script to work. That can be done either automatically or manually. If you prefer to download it yourself, you can do so according to the instructions from the [official site](https://wolicheng.com/womic/wo_mic_linux.html) and then you will need to move the AppImage file to the same directory as the script.

## Usage
Place the script in the same folder as the extracted AppImage binary and run it like so:
```
$ ./womic.sh [OPTION]
```
OPTIONS:

`-b` - to connect via Bluetooth\
`-w` - to connect via WiFi\
`-k` - to disconnect\
`-h` - to show this help message
