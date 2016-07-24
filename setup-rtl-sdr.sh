#!/bin/bash
sudo apt-get install cmake libusb-1.0-0-dev build-essential
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
sudo cp rtl-sdr.rules /etc/udev/rules.d/
sudo cp nortl.conf /etc/modprobe.d/
DEFAULT="y"
read -e -p "Rebooting the system [Y/n]:" PROCEED
PROCEED="${PROCEED:-${DEFAULT}}"
# change to lower case to simplify following if
PROCEED="${PROCEED,,}"
# condition for specific letter
if [ "${PROCEED}" == "y" ] ; then
  echo "Rebooting"
  sudo reboot
else
  echo "Reboot cancelled"
fi