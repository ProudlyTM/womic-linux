#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: womic [OPTIONS]"
    echo "Options:"
    echo "   -b   - to connect via Bluetooth"
    echo "   -w   - to connect via WiFi"
    echo "   -k   - to disconnect" 
    echo "   -h   - help (this message)"
    exit 1
fi

if [ `ls | grep ^micclient-x86_64_.*$` ]; then
    MICCLIENT=$(ls | grep ^micclient-x86_64_.*$)
else
    echo "WO Mic Appimage binary not found! Make sure you have this script in the same directory as the binary"
    exit 1
fi

function executable_check() {
    if ! [ -x $MICCLIENT ]; then
        chmod +x $MICCLIENT
    fi
}

function module_check() {
    if ! [ `lsmod | grep -o ^snd_aloop` ]; then
        sudo modprobe snd-aloop
    fi
}

while getopts "hbwk" OPTION; do
    case $OPTION in
        h)
            echo "Usage: womic [OPTIONS]"
            echo "Options:"
            echo "   -b   - to connect via Bluetooth"
            echo "   -w   - to connect via WiFi"
            echo "   -k   - to disconnect" 
            echo "   -h   - help (this message)"
            exit 0
            ;;
        b)
            executable_check
            module_check
            printf "(Format: xx:xx:xx:xx:xx:xx)\n"
            printf "Enter device address: "
            read ADDRESS
            echo ""
            printf "Run 'womic -k' to disconnect\n\n"
            ./$MICCLIENT -t Bluetooth $ADDRESS &
            sleep 1
            echo $! > /tmp/womic.pid
            sleep 3
            ;;
        w)
            executable_check
            module_check
            printf "(Example: 192.168.0.100)\n"
            printf "Enter device IP: "
            read IP
            echo ""
            printf "Run 'womic -k' to disconnect\n\n"
            ./$MICCLIENT -t Wifi $IP &
            sleep 1
            echo $! > /tmp/womic.pid
            sleep 3
            ;;
        k)
            if ! ps -p $(cat /tmp/womic.pid) > /dev/null 2>&1; then
                printf "WO Mic is not running!\n"
                exit 1
            else
                kill -2 $(cat /tmp/womic.pid)
                sleep 1
                exit 0
            fi
            ;;
        *)
            echo ""
            echo "Run 'womic -h' for help"
            exit 0
            ;;
    esac
done
