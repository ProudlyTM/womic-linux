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

if [ `ls | grep ^micclient-x86_64.*$` ]; then
    MICCLIENT=$(ls | grep ^micclient-x86_64.*$)
else
    printf "WO Mic Appimage binary not found! Would you like to download it now? (y/n): "
    read INPUT

    if [ "$INPUT" == "y" ]; then
        printf "\n"
        wget -q --show-progress https://wolicheng.com/womic/softwares/micclient-x86_64.AppImage

        if [ $? -eq 1 ]; then
            curl https://wolicheng.com/womic/softwares/micclient-x86_64.AppImage -o micclient-x86_64.AppImage
        fi

        printf "\n"
    else
        printf "\nThe WO Mic Appimage binary is required in order for the script to function.\n"
        printf "Either re-run the script and choose \"y\" to download the binary automatically or download it manually according to the README file.\n"
        exit 1
    fi
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
            if ! [[ -z $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}') ]]; then
                printf "WO Mic is already running!\n"
                exit 1
            else
                executable_check
                module_check
                printf "(Format: xx:xx:xx:xx:xx:xx)\n"
                printf "Enter device address: "
                read ADDRESS
                echo ""
                printf "Run 'womic -k' to disconnect\n\n"
                ./$MICCLIENT -t Bluetooth $ADDRESS &
                sleep 3
            fi
            ;;
        w)
            if ! [[ -z $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}') ]]; then
                printf "WO Mic is already running!\n"
                exit 1
            else
                executable_check
                module_check
                printf "(Example: 192.168.0.100)\n"
                printf "Enter device IP: "
                read IP
                echo ""
                printf "Run 'womic -k' to disconnect\n\n"
                ./$MICCLIENT -t Wifi $IP &
                sleep 3
            fi
            ;;
        k)
            if ! kill -2 $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}') > /dev/null 2>&1; then
                printf "WO Mic is not running!\n"
                exit 1
            else
                kill -2 $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}')
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
