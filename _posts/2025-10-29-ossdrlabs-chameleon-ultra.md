---
status: published
published: true
layout: post
title: OSSDRLabs - Chameleon Ultra
author: Benjamin Moeller
date: 2025-10-29 19:03:22 UTC
categories: [experimente]
tags: [produkte, chameleon ultra, ossdrlabs]
comments: []
---


# A brief history

RRG is well known for their Proxmark3 as RFID multitool. In mid of 2023 they are releasing a new RFID tool, the Chameleon Ultra.  

At first the project looks very promissing. A functional firmware for a few core features and a technical whitepaper, which shows the potential. After a few firmware upgrades the project went quiet for almost 2 years.  

The Chameleon Ultra got its popularity because of the modern USB-C interface and Bluetooth connection and all in a very small form factor.  
On the other hand, a young developer, known as GameTech_Live who is not related to RRG, provided a GUI across all major platforms, right from the beginning. The User was able to read, dump and load cards into slots. No complicated CLI commands or compilation processes.  

## What the Chameleon Ultra isn't
Often the Chameleon Ultra was misunderstood as new Proxmark3. But the used nRF52840 chip is not able to sniff. The Antenna is not (easily) replaceable.  
There are some basic attacks, based on known weakness of the LF RFID or HF NFC, implemented by the community. But it is still a basic field tool to emulate cards. It is not a tool for analysis or cracking.  

## Why to buy a Chameleon Ultra?
Some readers are more time sensitive. You can dump a card with a Proxmark3 or Flipper Zero, but the emulation won't work. In the past the workaround was to write the dump to a T5577 card and read this one to get access.  
And here the Chameleon Ultra shines. The Emulation is faster than any other known RFID tool, nearly as fast as a mobile phone NFC emulation. You can store up to 8 LF and 8 HF Cards (16 in total) to one Chameleon Ultra. So you don't need a bunch of T5577 cards in the field, anymore. To be fair, only if the card is already implemented in the CU firmware.  

# Getting started
If you bought a Chameleon Ultra and want to start, the first place to go is the technical Whitepaper at https://github.com/RfidResearchGroup/ChameleonUltra/wiki/technical_whitepaper  
Here you can see all supported cards and a few which are not supported by the hardware.  

Either you start to load the GU GUI from https://github.com/GameTec-live/ChameleonUltraGUI and click a bit around, or you start manually:  

1. Clone from Github `git clone https://github.com/RfidResearchGroup/ChameleonUltra`  
2. Change to the path `cd ChameleonUltra/software/src; mkdir out; cd out`  
3. Compile the CLI `cmake .. && cmake --build . --config Release`

Now you can open the CLI with:

1. Change to the path `cd ../script`
2. Start the CLI `./chameleon_cli_main.py`

In the program you are starting offline. Change it with the  command `hw connect`. In general the CU is autodetected, but you can chose the port manually with `-p`, like:

```
[Offline] chameleon --> <b>hw connect -p /dev/ttyACM0</b>
 { Chameleon Ultra connected: v2.1 }
[USB] chameleon --> 
```

The CLI has a lot of popups/tooltips. The RFID low frequency commands starting with `lf`. The NFC commands are starting with `hf`. Everything Chameleon Ultra hardware related is in `hw`.  
Most commands are with tab completion, it bocomes tricky with arguments and parameters.

## CLI commands

### Read ISO14443-a card
```
[USB] chameleon --> hf 14a scan
- UID  : B60A0DDA
- ATQA : 0400 (0x0004)
- SAK  : 08

[USB] chameleon --> hf 14a info
- UID  : B60A0DDA
- ATQA : 0400 (0x0004)
- SAK  : 08
- Guessed type(s) from SAK: MIFARE Classic 1K | Plus SE 1K | Plug S 2K | Plus X 2K
- Mifare Classic technology
  # Prng: Weak
```

### Change LED from christmas tree to casual</h2>
`hw settings animation -m MINIMAL`
For even more stealth mode there is:
`hw settings animation -m NONE`

### Change BLE Pairing key
The default BLE Key is 12345. The CU is waiting for a connection as soon as it wakes up. It is highly recommended to change this key!  
`hw settings blekey -k 250891` (Birthday of Linux)

### Emulate a entry card
1. Activate slot `hw slot change -s 4`
2. Enable the LF slot `hw slot enable --lf`
3. Enable `lf hid prox econfig --slot 4 --format H10301 --cn 123 --fc 210`
