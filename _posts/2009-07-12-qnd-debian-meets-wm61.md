---
status: published
published: true
layout: post
title: quick-and-dirty - Debian meets WM61
author: Benjamin Moeller
date: 2009-07-12 00:34:58 UTC
categories: [howto]
tags: [config, linux, handy]
comments: []
---

Lange ist es her, da habe ich einmal versuche mein Adressbuch des Handys mit dem des Linux zu verheiraten. Ich habe es aufgegeben. Das einfachste war SyncML über Bluetooth auf eGroupWare (XML-RPC) und LDAP als Server. Das ist nicht verhaeltnismässig, fuer z.B. einen Laptop.  
Vor wenigen Tagen dann kam ein neuer Hoffnungsträger, der Source zu [usb-rndis](http://downloads.sourceforge.net/synce/usb-rndis-lite-0.11.tar.gz) von [synce.org](http://www.synce.org).  

```
$ wget http://downloads.sourceforge.net/synce/usb-rndis-lite-0.11.tar.gz  
$ cd usb-rndis-lite-0.11/  
$ make  
$ su  
# ./clean.sh  
# make install  
```

Damit kann Linux nun WMisch sprechen (ganz schlimmer Dialekt ähnliche dem Walischen).  
`aptitude install opensync-plugin-synce synce-kde multisync-tools`

Und man bekommt auch die notwendigen Tools. Nun an die Einrichtung  
```
$ synce-sync-engine &
$ synce-create-partnership "eniezoe" "Contacts,Calendar,Tasks"
```

```
$ msynctool --listplugins  
$ msynctool --addgroup enie  
$ msynctool --addmember enie synce-opensync-plugin  
$ msynctool --addmember enie kdepim-sync
$ msynctool --sync enie  
```

**Enie** ist der Name meines Telefons, **Zoe** der meines Rechners, beide sind frei wählbar.  
Die Optionen beim Partnership sind: **Contacts,Calendar,Tasks,Files**  
Als letztes noch Kontakt öffnen und das Ergebnis bestaunen.  

Ich hoffe in diesem QuickAndDirty nichts essentielles ausgelassen zu haben, ich habe die Schritte nicht by-doing dokumentiert.  
Und, ehm, Patrick, ich schulde Dir ne Flasche Vodka :)  

## [Edit] Mein System:
* Debian GNU/Linux SID "Unstable"  
* XDA Orbit II "M-Amine 2.0 FINAL ROM"  

