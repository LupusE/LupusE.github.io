---
status: published
published: true
title: OpenStack - erstes Hinfallen
author: Benjamin Moeller
date: 2019-03-12 22:02:08 UTC
categories: [QuickAndDirty]
tags: [qnd]
comments: []
---

# Erste Schritte und harte Landungen
Es ist keine gute Idee zwei unbekannte Techniken auf einmal zu verwenden, bei drei Techniken kann an davon ausgehen, dass die Zeit bis zum ersten Erfolg länger dauern kann, als das Installieren einer Technik allein. Neue Themen:
1. Ubuntu Server und Snap
2. LVM
3. Linux container (lxd)
4. (conjure-up)

## Hallo Lucy
Der (für mich) neue ncurses Dialog ist etwas gewöhnungsbedürftig, aber angenehm zu lesen und Schritt-für-Schritt sinnvoll aufgebaut.

Der Ubuntu Server lässt sich recht schnell und sehr bequem installieren. Als Default wurde 'Gesamte Festplatte verwenden' vorgeschlagen. Das reicht mir nicht, ich wollte 'Gesamte Festplatte verwenden und LVM einrichten'. LVM kenne ich noch aus alten Zeiten, und so konnten wir bequem virtuelle Festplatten von 100G bis 6T verteilen, ohne dass ein Neustart der Umgebung oder VM notwendig war. Das klingt verlockend für mein Projekt.

Netzwerk konfigurieren, ersten Benutzer eingeben ... das Übliche halt.  
Aber was war an dem alten eth0 falsch? Okay, anstelle einer halb zufälligen Bezeichnung haben wir nun eine Bezeichnung nach Steckplatz im System. Da es auch kein `ifconfig` mehr gibt, sondern `ip a`, ist die Umgewöhnung vermutlich einfacher als ich gerade denke. Wer soll sich nur `ip a show dev enp5s0` merken? 

Das mit LVM eingerichtete Ubuntu denkt 4GB sind genug für / (root). Damit bricht jeder conjure spell ab. Lösung:
Die Fehlermeldung selbst war nicht sehr aufschlussreich:
> exception=BootstrapError('Unable to bootstrap (cloud type: localhost)',)>

Lösung:
```bash
$ sudo lvextend -L+50G /dev/mapper/ubuntu--vg-ubuntu--lv
$ sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
```
Hiermit wird das 'Linux Volume' für / um 50GB vergrößert und ist dann 54GB groß. Der Zweite Befehl passt das Dateisystem (ext2|3|4) darauf an.
Mit `df -h` lässt sich testen ob das Vorhaben geklappt hat.


## Veraltetes 'linux container' gegen aktuelles 'Linux container' tauschen
Wir rufen uns in das Gedächtnis was eine Distribution ist: Eine Sammlung von Paketen um einen Kernel (Betriebssystem), welche über einen Paketmanager einfach zu bedienen ist.  
Ubuntu Server hat [Linux containers (LXD)](https://linuxcontainers.org/) vorinstalliert. Was in diversen Situationen sicher hilfreich ist, kann uns hier zum Verhängnis werden. Lösung:
```bash
$ sudo apt purge lxd lxd-client
```

Wir starten mit dem Einrichten von lxd. Wir bedienen uns der snap Version.
```bash
sudo snap install lxd
```

Zur Sicherheit kontrollieren wir, ob die richtige Version aktiv ist:
```bash
$ which lxc
/snap/bin/lxc
```
Falsch an dieser Stelle wäre /usr/bin/lxc.

Der erste Benutzer sollte in der Gruppe lxd sein, aber hier noch einmal das Vorgehen:
```bash
$ sudo usermod -a -G lxd $USER
$ newgrp lxd
```
Nach dem nächsten anmelden kann mit dem Befehl `id` kontrolliert werden, ob man in der Gruppe ist.


Die Umgebung erstellen wir mit `lxc init`. Hier gibt es zwei wichtige Unterschiede zum Default:
1. OpenStack kann nur mit dem Dateisystem 'dir' um. Die Voreinstellung 'btrfs' führt zu Fehlern.
2. OpenStack kann kein IPv6, hier muss 'none' eingegeben werden.

## Zusammenfassung
```bash
$ sudo apt purge lxd lxd-client; sudo snap install lxd; lxd init
```
> Das Deinstallieren der veralteten Version der 'Linux container' aus apt, und installieren der neueren Version aus snap. Im Anschluss die Umgebung einrichten
> An dieser Stelle auf keinen Fall vergessen *dir* als Dateisystem und *none* bei IPv6.

```bash
$ sudo lvextend -L+50G /dev/mapper/ubuntu--vg-ubuntu--lv; sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
```
> Je nachdem wie viel Speicher zur Verfügung steht können die 50G angepasst werden. Sehr viel weniger sollt es nicht sein.

# Lasst die Spiele beginnen!
Die Magie macht für uns conjure-up.
```bash
$ conjure-up
```

Ab hier gibt es genug Anleitungen über Google. Die ersten Fallstricke müsst ihr mir nicht nachmachen.  
je nach Ausstattung werden hier mehrere Stunden benötigt. Der Vorteil: Das System macht alles alleine. Fehler werden meist recht früh sichtbar.

Die traurige Realität: das ist erst die Infrastruktur. Es existiert noch kein einziger Service für die Welt.

# Edit
Ein i3 (2 Cores) mit 8GB Ram und 150GB drehender HDD ist vielleicht super Stromsparend, aber nicht genug Blech fuer OpenStack.  
Beim installieren schwankte die Load zwischen 600 und 1200. Die Install ist abgebrochen mit einem Timeout zwischen dne Services und nach einem Neustart pendelt die Load zwischen 25 und 162 ...

Minimum Requirements sind aktuell  Cores, 16 GB RAM, 32GB SWAP (SSD recommended) und 100GB Platz. Offensichtlich nicht ohne Grund.  
Ich weis nicht, wie andere Testumgebungen auf dne Laptops installieren. Scheinbar gibt es noch einen anderne Trick... 

*Mic drop Geräusch*
