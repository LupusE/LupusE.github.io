---
status: published
published: true
title: 'quick-and-dirty Alsa: [n] Sndkarten, bei n>=2'
author: Benjamin Moeller
date: 2007-02-13 21:03:50 UTC
categories: [howto]
tags: [linux, qnd, howto]
comments: []
---

Grade bei einem Kaffee im Cup'n'Chino (Kiel) war mal wieder das leidige Thema 'Alsa wuerfelt mit meinen Karten' aktuell, daher hier mein Ansatz.  

### Situation

Debian 'SID'  
alsa-base 1.0.13-3, alsa-oss 1.0.12-1, alsa-tools 1.0.13-1, alsa-utils 1.0.13-2  
Linux zoe 2.6.19 #1 PREEMPT Tue Dec 5 22:28:20 CET 2006 i686 GNU/Linux

### Ziel

Die Karten nach dem Reboot immer in der gleichen Reihenfolge laden

### Problem

Bis vor kurzem reichte es die Module in der gewuenschten Reihenfolge in die `/etc/modules` einzutragen, doch hier spielt libdiscover nicht mehr mit.

### Loesungsansatz1

Laut den alsa-Webseiten soll man in der `/etc/modutils/alsa-base` die gewuenschte Reihenfolge unten anfuegen mit

> options snd-cmipci snd_index=0 #C-Media Electronics Inc CM8738 (rev 10)
> options snd-emu10k1 snd_index=1 #Creative Labs SB Audigy (rev 03)
> options snd-usb-audio snd_index=2 #Logitech Messanger Webcam

#### Quellen

http://alsa.opensrc.org/MultipleCards#How_to_choose_a_particular_order_for_multiple_installed_cards  
http://alsa.opensrc.org/MultipleCards#Multiple_Sound_Cards_--_Example_on_Debian_GNU.2FLinux

#### Loesungsansatz2
Das alsa ueber udev auf die Devicefile binden. Das halte ich fuer unmoeglich, aber sicher ein Versuch wert.
