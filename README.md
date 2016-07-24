ADS-B Base Station for OpenSky Network
======================================

Cheap and simple ADS-B base station for the [OpenSky Network](https://opensky-network.org/)

# Prerequisites

* PC with microSD or SD card reader
* Monitor with HDMI connection
* USB Keyboard/Mouse

# Shopping list

* Raspberri Pi set
  * Raspberri Pi 2 Model B [amazon.de](https://www.amazon.de/dp/B01CPGZY3O)
  * Memory Card 32GB MicroSDHC Class 10, SD adapter [amazon.de](https://www.amazon.de/dp/B01CPGZY3O)
  * WLAN Adapter [amazon.de](https://www.amazon.de/gp/product/B00416Q5KI)
  * USB extension cable [amazon.de](https://www.amazon.de/dp/B000NWS55M)
  * Power supply, heatsinks, case [amazon.de](https://www.amazon.de/gp/product/B00UCSO9G6)
* Receiver
  * ADS-B Antenna with N Female Connector 
  * Cable * N Male - SMA Male*  [amazon.de](https://www.amazon.de/gp/product/B0152WWEUO)
  * (Optional) Band-pass Filter *SMA Female - SMA Male* [amazon.de](https://www.amazon.de/gp/product/B010GBQXK8)
  * (Optional) Cable *SMA Female - MCX Male* [amazon.de](https://www.amazon.de/gp/product/B00V4PS1L0)
  * USB RTL-SDR Receiver [amazon.de](https://www.amazon.de/gp/product/B00VZ1AWQA)
[ebay.de](http://www.ebay.de/itm/Antenna-ads-b-collinear-great-gain-for-usb-dongle-flightbox-/291800588117)
  
# Notes on the shopping list

* Make sure memory card package includes the SD adapter so that you could use this card in a normal PC (which usually has a SD card reader but not the microSD.
* MicroSDHC Class 10 (high speed class) is highly recommended.
* If you connect the receiver to one of the USB port on Raspberri Pi directly, it will cover other ports. You can avoid this using the USB extension cable.
* You'll need a coaxial cable to connect your antenna to your USB RTL-SDR receiver. The shopping list above assumes an antenna with the N Female connector. The recommended [NooElec NESDR Mini 2+](https://www.amazon.de/gp/product/B00VZ1AWQA) receiver has an MCX Female socket, so you basically need to connect MCX Female to N Female. Such cables (*MCX Male - N Male*) are quite rare, a much better option is a *N Male - SMA Male* plus *SMA Female - MCX Male* combination.
* The *N Male - SMA Male* plus *SMA Female - MCX Male* combination also using the [FlightAware band-pass filter](https://www.amazon.de/gp/product/B010GBQXK8) which reduces the noise and increases the number of the processed ADS-B messages. This filter has the *SMA Female* input and *SMA Male* output so it can be inserted between to cables (from antenna and to to receiver). If you want to spare the filter, just connect two cables directly.
* The [band-pass filter](https://www.amazon.de/gp/product/B010GBQXK8) is optional, but it is highly recommended. It drastically increases the number of messages.
* The [NooElec NESDR Mini 2+](https://www.amazon.de/gp/product/B00VZ1AWQA) includes a small *SMA Female - MCX Male* adapter, so you don't necessarily need the *SMA Female - MCX Male* cable. However, if you use the [FlightAware band-pass filter](https://www.amazon.de/gp/product/B010GBQXK8), it is highly recommended to get *SMA Female - MCX Male* cable as well to add flexible connection between the filter and the receiver. Otherwise the filter is connected rigidly into the small MCX socket and as a potential to break it.

# Assemble the Raspberri Pi

* Attach heatsinks to chips
* Fix the Raspberri Pi to the case using screws, close the case

# Set up the Raspberri Pi

## Prepare the SD card with Raspbian operating system for Raspberri Pi

* Follow the [NOOBS Setup](https://www.raspberrypi.org/help/videos/) instructions. In short:
 * [Download](https://www.sdcard.org/downloads/formatter_4/index.html) and install the SDFormatter (a software to format your microSDHC card)
  * Insert your microSDHC memory card into your PC (using the SD adapter)
  * Format the microSDHC card using SDFormatter. Make sure you've selected the correct drive letter. Use the options `FORMAT TYPE` `FULL (Erase)` and `FORMAT SIZE ADJUSTMENT` `OFF`.
  * [Download](https://www.raspberrypi.org/downloads/noobs/) and unzip NOOBS ("New Out Of the Box Software", an easy operating system installer for Raspberri Pi)
  * Copy the uzipped NOOBS files to the freshly formatted microSDHC card
  * Safely eject the memory card

## Install Raspbian

* Insert the card into Raspberri Pi
* Connect monitor, keyboard, mouse and, finally, power
* Perform the Raspbian installation
* Configure the system after installation (you'd typically want to set region and locale and change the default password (`raspberri`/`pi`).
* Insert the WLAN adapter and set up the WLAN/internet connection
* Update and upgrade the system. Run:  
```
sudo apt-get update
sudo apt-get upgrade
```
* Install `git-core` and `git`
```
sudo apt-get install git-core git
```

* You will need a couple of packages later or:
```
sudo apt-get install git-core git cmake libusb-1.0-0-dev build-essential pkg-config
```

# Setup `dump1090` on RaspBerri PI

Instructions below are taken from the [	
ADS-B using dump1090 for the Raspberry Pi](http://www.satsignal.eu/raspberry-pi/dump1090.html) guide and slighly adapter.

## Build and install  `rtl-sdr` drivers

```
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
```

Connect antenna via cables to the RTL-SDR receiver, connect the receiver to the Raspberri Pi. Do not use the band-pass filter yet, connect cables directly.

```
cd ~
sudo cp ./rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/
sudo printf 'blacklist dvb_usb_rtl28xxu\nblacklist rtl2832\nblacklist rtl2830' > /etc/modprobe.d/nortl.conf
sudo reboot
```

Check the connection by running:
```
rtl_test
```

You should be seeing something like:

```
Found 1 device(s):
  0:  Realtek, RTL2838UHIDIR, SN: 00000001

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
Supported gain values (29): 0.0 0.9 1.4 2.7 3.7 7.7 8.7 12.5 14.4 15.7 16.6 19.7 20.7 22.9 25.4 28.0 29.7 32.8 33.8 36.4 37.2 38.6 40.2 42.1 43.4 43.9 44.5 48.0 49.6 
[R82XX] PLL not locked!
Sampling at 2048000 S/s.

Info: This tool will continuously read from the device, and report if
samples get lost. If you observe no further output, everything is fine.

Reading samples in async mode...
```

This means RTL-SDR drivers were compiled and installed successfully.

# (Optionally) calibrate your receiver

This step is optional, from my experience, NooElec receivers don't need calibration. 

Calibration stepsinstructions below are taken from the [following guide](http://www.satsignal.eu/raspberry-pi/acars-decoder.html#kalibrate).

```
mkdir ~/kal
cd ~/kal
sudo apt-get install libtool autoconf automake libfftw3-dev
git clone https://github.com/asdil12/kalibrate-rtl.git
cd kalibrate-rtl
git checkout arm_memory
./bootstrap
./configure
make
sudo make install
```

Make sure your antenna is connected to the RTL-SDR receiver and the receiver is connected to the Raspberri Pi. You should not use the band-pass filter yet.

To calibrate, run:

```
kal -s GSM900 -d 0 -g 40
```

You'll see something like:

```
Found 1 device(s):
  0:  Generic RTL2832U OEM

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
Exact sample rate is: 270833.002142 Hz
[R82XX] PLL not locked!
Setting gain: 40.0 dB
kal: Scanning for GSM-900 base stations.
GSM-900:
	chan: 16 (938.2MHz - 303Hz)	power: 764382.95
	chan: 29 (940.8MHz - 107Hz)	power: 3099720.22
	chan: 37 (942.4MHz + 351Hz)	power: 814043.05
	chan: 56 (946.2MHz - 106Hz)	power: 255238.03
	chan: 65 (948.0MHz - 115Hz)	power: 645372.85
	chan: 69 (948.8MHz + 115Hz)	power: 4609305.74
	chan: 73 (949.6MHz + 239Hz)	power: 642985.06
	chan: 102 (955.4MHz - 512Hz)	power: 694681.27
```

Use the most powerful channel (69 in the example above) for calibration

kal -c <channel> -d 0 -g 40

You'll get something like:

```
Found 1 device(s):
  0:  Generic RTL2832U OEM

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
Exact sample rate is: 270833.002142 Hz
[R82XX] PLL not locked!
Setting gain: 40.0 dB
kal: Calculating clock frequency offset.
Using GSM-900 channel 69 (948.8MHz)
average		[min, max]	(range, stddev)
+  64Hz		[39, 87]	(49, 13.600428)
overruns: 0
not found: 0
average absolute error: -0.067 ppm
```

Note the "average absolute error" number. If you have it around 0, everything's fine.
If not, you may need to change the frequency when you start `dump1090`.

# Build and install dump1090

```
cd ~
git clone git://github.com/MalcolmRobb/dump1090.git
cd dump1090
make
```

Now connect your cables via the band-pass filter.

Start `dump1090` in the interactive mode. The `--net` switch starts network services (including HTTP server).

```
./dump1090 --interactive --net
```

You should be getting output like:

```
Hex     Mode  Sqwk  Flight   Alt    Spd  Hdg    Lat      Long   Sig  Msgs   Ti|
-------------------------------------------------------------------------------
3C4B4C  S                    34000  470  344                      5    39    1
44D076  S                    25000                                4     5    1
3C66B3  S     2037  DLH8YA   19475  339  121   48.916   11.190    4    27    5
040032  S     2540  ETH707    5875  273  119   49.905    8.698    8   113    0
3C6DCD  S     7610           31000  465  108                      4    12    1
44A8A2  S     1000  JAF83X   34625  454  292                      5   130    2
710105  S     2702  SVA116   33000  510  125   49.382    7.167    4   156    1
4243D0  S                     9725  295  007                      6    38    7
3C6671  S     0137  DLH4LC    2525  207  070   50.057    8.638   10   205    1
495296  S     2326           14000  345  359                      4    36    3
3C5CB5  S                    34600  409  066                      5    42    1
3C6655  S     7662  DLH1304  16600  402  095   50.021    9.583    6   131    0
06A1BD  S                    34975                                5     2    8
3C706E  S     2557  GEC8296  11250  339  119   49.804    8.976    5   203    0
45AC32  S     4057  SAS2588  36025  464  023   49.144    9.098    5   174    0
478371  S     0732  SAS4823  41000  456  172   49.701    8.036   10   374    0
3C6488  S     7621  DLH1308   2550  182  139   49.963    8.537    8    91    0
3C666A  S     0612  DLH584   12300  386  135   49.696    9.132    6   274    0
406A93  S     2735           38025  449  312   48.890    8.772    4   160    1
400868  S     3221  TCX7867  34000  435  304   49.723    7.388    4   229    0
896197  S     7661  UAE48     7125  278  023   50.185    8.787   69   475    0
896405  S     2232  ETD69K   39000  493  098   50.222    8.175   12   407    0
3C1FBD  S                                                        15    84    0
3C5EE8  S     0262           26825  439  337   49.301    9.089    5   185    0
3C486C  S     1000  BER359J  13075  313  358   49.726    8.663    9   333    0
```

You can also access the HTTP server of `dump1090` under the address `http://127.0.0.1:8080`.

TODO picture

# Making `dump1090` reboot-resistant

Now that `dump1090` runs, you should configure it to start automatically when the system starts.

* Edit `/etc/init.d/dump1090.sh`:
```
sudo nano /etc/init.d/dump1090.sh
```
* Paste the following script:
```
#!/bin/bash
### BEGIN INIT INFO
#
# Provides:		dump1090
# Required-Start:	$remote_fs
# Required-Stop:	$remote_fs
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	dump1090 initscript

#
### END INIT INFO
## Fill in name of program here.
PROG="dump1090"
PROG_PATH="/home/pi/dump1090"
PROG_ARGS="--quiet --gain -10 --net --net-beast"
PIDFILE="/var/run/dump1090.pid"

start() {
      if [ -e $PIDFILE ]; then
          ## Program is running, exit with error.
          echo "Error! $PROG is currently running!" 1>&2
          exit 1
      else
          ## Change from /dev/null to something like /var/log/$PROG if you want to save output.
          cd $PROG_PATH
          ./$PROG $PROG_ARGS 2>&1 >/dev/null &
          echo "$PROG started"
          touch $PIDFILE
      fi
}

stop() {
      if [ -e $PIDFILE ]; then
          ## Program is running, so stop it
         echo "$PROG is running"
         killall $PROG
         rm -f $PIDFILE
         echo "$PROG stopped"
      else
          ## Program is not running, exit with error.
          echo "Error! $PROG not started!" 1>&2
          exit 1
      fi
}

## Check to see if we are running as root first.
## Found at http://www.cyberciti.biz/tips/shell-root-user-check-script.html
if [ "$(id -u)" != "0" ]; then
      echo "This script must be run as root" 1>&2
      exit 1
fi

case "$1" in
      start)
          start
          exit 0
      ;;
      stop)
          stop
          exit 0
      ;;
      reload|restart|force-reload)
          stop
          start
          exit 0
      ;;
      **)
          echo "Usage: $0 {start|stop|reload}" 1>&2
          exit 1
      ;;
esac
exit 0
```

Register
```
sudo chmod +x /etc/init.d/dump1090.sh
sudo update-rc.d dump1090.sh defaults`
```

You can immediately start `dump1090`:#
```
sudo /etc/init.d/dump1090.sh start
```

# Network configuration

* Assumed router (Example Fritz.Box)
* Give Raspberri Pi a name
* Always use the same IP address 
* Now you should be able to reach the `dump1090` instance running on the Raspberri Pi via `http://argon:8080`
* You should also be able to connect to the port `30005` and see some binary data coming from the Raspberri Pi




# Make your Raspberri Pi available from the Internet

So that OpenSky Network can access it.
* Configure the port forwarding on your router: `30005` -> `argon:3005`
* You'll need dynamic DNS
* Create a no-ip.com account
* Configure Dynamic DNS with your router
* Now you should be able to connect to your Raspberri Pi `mydomain.no-ip.org:30005`


# OpenSky Network configuration

* Create an OpenSky Network account
* Add a new Sensor:
* `My OpenSky` > `My Sensors` > `Add Sensor`
* Receiver Type: dump1090
* Hostname: mydomain.no-ip.org
* Port: `30005`
* Enter or pick your location
* Submnit

* You should see your sensor on the map. If everything's fine, the sensor should go online in a couple of minutes.
