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
* Insert the WLAN adapter set up the WLAN/internet connection
