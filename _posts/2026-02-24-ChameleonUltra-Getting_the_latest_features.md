---
status: published
published: true
layout: post
title: ChameleonUltra - Getting the latest features
author: Benjamin Moeller
date: 2026-02-24 22:52:01 UTC
categories: [howto]
tags: [produkte, chameleonultra, rfid]
comments: []
---

# Chameleon Ultra

> The new generation chameleon based on NRF52840 makes the performance of card emulation more stable. And gave the chameleon the ability to read, write, and decrypt cards. 

A good summary, copied from: https://github.com/RfidResearchGroup/ChameleonUltra

The ChameleonUltra had the potential to becom a very capable mobile device for different RFID tasks. It is definetly not a sniffer, so it won't replace the Proxmark3. But it has the hardware to be a great emulator. The RRG people abdoned this project at a early stage.  

As the project is OpenSource, everybody can contribute. After a few draw backs, there is a lot of progress since mid of 2025.  

# How I do my testings?
I am working on Kali Linux. And as I test a lot of PR, I have build a workflow around this, which I want to write down here.  

The very first step is as alwys the lonign of the repository:
```
mkdir ~/git; cd ~/git
git clone https://github.com/RfidResearchGroup/ChameleonUltra
cd ChameleonUltra
```

## Install nrfutil
Download binary from: https://www.nordicsemi.com/Products/Development-tools/nRF-Util/Download#infotabs  
Choose your development platform: `Linux (x64)`  

After download, make executable (`chmod +x`) and install the needed packages.  

```
chmod +x nrfutil
./nrfutil install completion device nrf5sdk-tools trace
```
If needed, yo could copy the binary to a global called place:  
```
cp nrfutil ~/.local/bin
```

## Get the Arm GNU Toolchain
The `gcc-arm-none-eabi` package of most linux distributions is too new. Using this package would result in a bigger firmware file, and won't work. It should be around 10.x.  

### The version from a package manager wont work
Kali Linux says at the moment:  
```
$ apt search gcc-arm-none-eabi
gcc-arm-none-eabi/kali-rolling,now 15:14.2.rel1-1 amd64  [installiert]
  GCC cross compiler for ARM Cortex-R/M processors
```  
Debian got: [https://packages.debian.org/search?keywords=gcc-arm-none-eabi](https://packages.debian.org/search?keywords=gcc-arm-none-eabi)  


### Manual 'installation'
Download from: [https://developer.arm.com/downloads/-/gnu-rm/10-3-2021-10](https://developer.arm.com/downloads/-/gnu-rm/10-3-2021-10)  
See all Packages at [arm-gnu-toolchain-downloads](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)  

Extract it to a folder you know later (693 MB).  


## Compile Helper
I've wrote a little helper to compile either the default repository (ChameleonUltra as default) or a different (with argument).  

```
#!/bin/bash

curpath=$(pwd)

if [ "$#" -eq 0 ]
then 
        echo "Path default"
        srcpath=ChameleonUltra 
else
        echo "Path $1"
        srcpath=$1
fi
workpath=$curpath/$srcpath

if [ -f $workpath/firmware/Makefile.defs ]
then
        echo "Chameleon firmware available"
fi

if [ -f $workpath/software/src/CMakeLists.txt ]
then
        echo "Chameleon CLI available"
fi

export GNU_INSTALL_ROOT=/home/lupus/work/cu/gcc-arm-none-eabi-10.3-2021.10/bin/
export GIT_VERSION=v4.20469-152-ga1e9b47
export APP_FW_SEMVER=v2.0.0
export APP_FW_VER_MAJOR=2
export APP_FW_VER_MINOR=0

echo "Building CU firmware"
cd $workpath/firmware/
./build.sh
cd $curpath

echo "Building CU CLI"
cd $workpath/software/src/
if [ ! -d out ]
then
        mkdir out
fi

cd out
cmake .. && cmake --build . --config Release

cd $curpath

```

Maybe you need adjust the variable `GNU_INSTALL_ROOT` with the path of your **gcc-arm-none-eabi**.
The Github workflow sets some version variables from the branch, which I set static in the script  
- APP_FW_SEMVER=v2.0.0 
- APP_FW_VER_MAJOR=2 
- APP_FW_VER_MINOR=0.

With the script in `~/git` and the CU repo in `~/git/ChameleonUltra`, I can just run:  
`/make_cufw.sh` and it will get compiled.  

## Check out PRs

Create a local branch, named `autopwn` for the PR `364` and switch to the branch:  
```
git fetch origin pull/364/head:autopwn
git checkout autopwn 
```

Back to main:  
```
git checkout main
```

List existing branches:  
```
$ git branch
  autopwn
  led
* main
```

Cleanup test branches:  
```
git branch -D led
git branch -D autopwn
```

## Flash the firmware

If everything went fine, you'll find the firmware in `ChameleonUltra/firmware/objects/`. To flash change to the directory /firmware and execute `./flash-dfu-app.sh`.  
The CU will switch to DFU mode, the two middle LED will start alternating and the firmware will be flashed. After it is done, the CU resets and you'll see the moving animation on all LED.  

Make sure to use the CLI matching the Firmware. Else, depending on the PR, the testing won't give propper results.  
