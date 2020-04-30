# womic-linux
Bash script for running WO Mic on Linux

## Purpose
The purpose of this script is to be able to connect to a locally started WO Mic server in the background and exit the terminal freely, without having to remember the PID, when you want to disconnect.

## Prerequisites
To use this script you must first have downloaded the WO Mic [AppImage](https://appimage.org/) binary from the [official site](https://wolicheng.com/womic/softwares/micclient-x86_64.AppImage) and extracted it somewhere according to the [official instructions](https://wolicheng.com/womic/wo_mic_linux.html) from step 1.

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
