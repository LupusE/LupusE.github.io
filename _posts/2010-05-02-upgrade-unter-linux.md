---
status: published
published: true
title: Upgrade von Linux
author: Benjamin Moeller
date: 2010-05-02 13:23:13 UTC
categories: [howto]
tags: [linux, partitionieren]
comments: []
---

Alle Jahre wieder kommt ein neues Linux Release und die Versionsjunkies wollen sofort das neuste tollste blingbling Feature haben. Also fragen sie wie man 'am besten updated?'.  
Welches Vorgehen ist am besten? Man will nicht viel Arbeit reinstecken, man will keine Daten verlieren und es soll sein wie vorher, aber besser.  
Mein Tipp: neue Platte kaufen ('jetzt wir in die Hände gespuckt, wir steigern das ...') und das (Partitions)Konzept ueberdenken. Endlich trennen, was nicht zusammen gehört.  

Daten sichern! Immer! Nicht nur zum Upgrade.  

# Partitionierung

```
lupus@zoe:~$ df -h  
Dateisystem            Größe Benut  Verf Ben% Eingehängt auf  
**/dev/sda1              46G  6,4G   39G  15% /**  
udev                  1,6G  524K  1,6G   1% /dev  
none                  1,6G  468K  1,6G   1% /dev/shm  
none                  1,6G  396K  1,6G   1% /var/run  
none                  1,6G  8,0K  1,6G   1% /var/lock  
none                  1,6G     0  1,6G   0% /lib/init/rw  
/dev/md2               92G   74G   14G  85% /media/misc  
/dev/sda6              46G   40G  3,6G  92% /media/music  
/dev/sda7              68G   41G   25G  63% /media/mirror  
/dev/md0               46G   43G  1,1G  98% /home  
**/dev/sde1             932G  462G  471G  50% /media/onetb  
**/dev/sda3              46G  9,4G   35G  22% /media/debian  
lupus@zoe:~$  
```

Da ich ein RAID System betreibe ist /dev/sdb[n] und /dev/sdc[n] zusammengefasst zu /dev/md[n]. Hier liegen /media und /home. Beide sind vom Update nicht betroffen. Sicher ändert das ein oder andere Programm die Einstellungen unter /home/[user]/.[blah], aber das vernachlässige ich hier. Im Notfall werden diese beim Rollback gelöscht und aus dem Backup zurück kopiert.  
Wichtig ist, das /home auf einer eigenen Partition liegt und damit beim Update oder einer neuen Installation neu eingebunden werden muss.  
Von Ubuntu Karmic auf Ubuntu Lucid habe ich mich dazu entschlossen mein kaputtes Debian entgültig zu löschen, das heisst ich installiere ein frisches Ubuntu Lucid direkt auf /dev/sda3, und fasse /dev/sda1 gar nicht an. Damit habe ich 40GB ungenutzten Speicher auf der Platte, aber kann jederzeit zurück. Früher oder später kann ich dann auf /dev/sda1 wieder mit anderen Systemen spielen.  
Um ein neues System schnell lauffähig zu bekommen reicht es mit einem 2. Benutzer oder Livesystem die Dateien von /home auf ein neu eingerichtetes /home2 zu legen. Zum Testen lagere ich es nicht mal aus.  
Bei meinem Aufbau könnte man zusätzlich /boot auf sda legen, im grub Systemunabhängig konfigurieren zu können. Auch die Auslagerung von /var hatte ich mal realisiert. Das macht aber nur für Forensik einen nennenswerten Sinn. Oder wenn das RAID einen Geschwindigkeitsvorteil bringen würde.  
Warum ich /war/www auf /home/wwwuser legen würde erlaeutere ich in einem anderen Artikel.  

# Fazit  

1. Lagert /home aus!  
2. Kauft eine 2. Platte! (Add 04.11.2021: SSD!)  
3. Gut ist, was selbst gut durchdacht ist. Nicht was die Anderen im Internet tun!  

