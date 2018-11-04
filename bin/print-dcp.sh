#!/bin/bash
#
# PrintDCP v1.42
#
# GNU GPLv3
# (c)2018 Jeff Billings

help () {
  echo "printDCP - automates the process of creating DCP drives"
  echo " "
  echo "Usage:   printDCP [source folder path] [drive device path]"
  echo " "
  echo "  -g --gui   Graphical Interface"
  echo "  -h --help  Operating Instructions"
}
error () {
  echo "(Error) "$1
  exit 1
}
root () {
  if [ $UID -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
  fi
}
check () {
  if [[ $? -eq 1 ]]; then
    echo "(Cancelled by user)"
    exit 1
  fi
}
finish () {
  echo "(Finished)"
  exit 0
}
init () {
  drive=$1
  volume="${drive}1"
  echo "Unmounting disk..."
    umount $drive*
  echo "Creating partition..."
    parted -s $drive mklabel msdos
    parted -s $drive mkpart primary 0% 100%
  echo "Waiting for partition..."
    while [ ! -e $volume ]; do continue; done
  echo "Creating filesystem..."
    until format=$(mkfs -t ext3 -I 128 -m 0 -F $volume); do continue; done 2>/dev/null
    echo "$format"
  echo "Mounting volume..."
    until mount=$(su -c "gio mount -d ${volume}" $SUDO_USER); do continue; done 2>/dev/null
    echo "$mount"
}
copy () {
  drive=$1
  source=$2
  volume="${drive}1"
  mount=$(lsblk $volume -o MOUNTPOINT -n)
  echo "Copying DCP, performing checksum, setting permissions..."
    sudo -S rsync -a --progress --checksum --chmod 755 $source $mount
}
gui () {
  IFS=$'\n'
  os=$(lsblk -n -p --output PKNAME $(findmnt / -o SOURCE -n) )
  drive=$(lsblk -I 8 -d -n -p -P --output NAME,MODEL,SIZE |
    awk -v os="$os" -F '"' '{ if ($2 != os) print $2"\n"$4"\n"$6 }' |
    zenity --list \
    --title="PrintDCP" \
    --width=400 --height=300 \
    --text="Select a drive to <b>erase</b> and prepare:" \
    --column="Device" --column="Model" --column="Size" \
    2>/dev/null )
  check
  source=$(zenity --file-selection --directory \
    --title="Choose source DCP folder ..." \
    --filename=$HOME/Desktop/ \
    2>/dev/null
  )
  check
  init $drive & PIPED_PID=$!
  tail -f /dev/null --pid $PIPED_PID | (
    zenity --progress --pulsate --auto-close \
    --width=300 --height=150 \
    --title="PrintDCP" \
    --text="Initializing drive..." \
    2>/dev/null || kill $PIPED_PID );
  check
  copy $drive $source & PIPED_PID=$!
  tail -f /dev/null --pid $PIPED_PID | (
    zenity --progress --pulsate --auto-close \
    --width=300 --height=150 \
    --title="PrintDCP" \
    --text="Copying DCP..." \
    2>/dev/null || kill $PIPED_PID );
  check
  zenity --info \
    --width=300 --height=150 \
    --title="PrintDCP" \
    --text="Drive preparation finished." \
    2>/dev/null
}
if [ "$#" -eq 0 ]; then
  help
fi
while [ "$#" -gt 0 ]; do case $1 in
  -h|--help)
    help
    shift;;
  -g|--gui)
    root
    gui
    finish
    shift;;
  *)
    if [ $# -ne 2 ]; then
      error "Invalid arguments"
    else
      source=$1
      drive=$2
      root
      init $drive
      copy $drive $source
      finish
    fi
esac; shift; done
