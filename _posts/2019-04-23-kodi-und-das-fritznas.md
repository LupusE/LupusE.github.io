---
status: published
published: true
layout: post
title: Kodi und das Fritz!NAS
author: Benjamin Moeller
date: 2019-04-20 07:16:21 UTC
categories: [howto]
tags: [kodi, nas, server]
comments: []
---

# Fritz!NAS - Für das kleine Portemonaie
Hier in Deutschland besitzt wohl ein grossteil der Internetbenutzer eine Fritz!Box. Diese plastik Router besitzen zwar keine enterprise Funktionen, aber sind für den Heimgebrauch einfach ausreichend.  
Zusätzlich zum Routing per LAN und WLAN bieten die Boxen einen oder zwei USB Ports um einen externen Datenträger anzubinden. In der letzten Labor Firmware hat AVM sogar mit SMBv3 experiemntiert, aber ist dann in der finalien Version (7.10) doch wieder auf v1 geblieben. Schade.  
Das nennt AVM Fritz!NAS, hat aber durch die Protokollauswahl (FTP, HTTP, SMB) relativ wenig mit einer ernstzunehmendne Alternative gemein. Selbst Windows 10 muss man erst dazu überreden das veraltete und unsichere SMBv1 zu sprechen, um per 'Dateifreigabe' auf sen Fritz!NAS zu kommen.

## Fritz!Box Benutzer einrichten


# Kodi - Multimediacenter
[Kodi](https://www.kvibes.de/mediaelch/) läuft bei mir mit einem [LibreELEC](https://libreelec.tv) auf einem Raspberry Pi. LibreELEC ist eine 'Just enough OS for Kodi' Distribution, welche die Leistung des Systems für die eigentliche Anwendung (Kodi) bereit hält. Kodi habe ich schon genutzt als der Name noch XBMC (XBox Media Center) war.  
Kodi spricht fast alles was es an Schnittstellen gibt um auf Dateien zuzugreifen. SMB, NFS, FTP, DNLA, ... Das kleinste gemeinsame Vielfache ist hier SMB.

## MediaElch - Kodi Datenbank pflegen
Kodi bringt Scrapper mit, kleine Dienste, welche einen Titel nehmen, einen passenden Datensatz innerhalb einer Onlinebibliothek, zum Beispiel IMDB, suchen und die Metadaten ziehen. Die Daten werden in den Filmordner als .nfo ud Bilddateien gespeichert. Als Standard nutzt Kodi eine SQLite Datenbank, es besteht aber id eMöglichkeit mehrere Kodi Installation per MySQL (MariaDB/Postgress) Datenbank zentral zu verwalten.  
Der Scrapper funktionierte anfangs sehr gut, bei einer größeren Sammlung und serien gab es baer immer wieder schwierigkeiten, so dass ich das Pflegen der Metadaten heute bequemer manuell am PC mache. Dazu hilft mir MediaElch.  
Das Programm gibt es als Ubuntu reposetory, was nicht wirklich aktiv gepflegt wird, aber auf allen getesteten Ubuntu Versionen funktioniert. Mittlerweile nutze ich Debian und daher kompiliere ich es selbst.  

```bash
$ sudo apt install build-essential git libmediainfo-dev libcurl4-openssl-dev
$ sudo apt install qt5-default qtmultimedia5-dev qtscript5-dev qtdeclarative5-dev qtdeclarative5-controls-plugin qtdeclarative5-models-plugin
```
Quelle: https://www.kodinerds.net/index.php/Thread/49966-MediaElch-Kompilieren/

```bash
$ mkdir -p ~/git; cd ~/git
$ git clone https://github.com/Komet/MediaElch.git && cd MediaElch
$ mkdir build && cd $_
$ qmake ..
$ make -j4
```
... Abwarten.
```bash
$ ./MediaElch
```

## Arbeitsweise
Im MediaElch werden die Verzeichnisse konfiguriert, in denen die Medien liegen. Mit 'Aktualisieren' aus dme Menü oben werden die Verzeichnisse neu eingelesen und in der Liste links stehen ganz oben die Filme, welche noch keine Metadaten haben. Mit einem rechtsklick auf diesen Namen und aus dem Kontextmenü 'Informationen holen', wird ein dialog angezeigt, in dme Vorschläge gemacht werden. Der Film sollte daher im Verzeichnisnamen 'Titel__Erscheinungsjahr' gespeichert sein. Damit erhalte ich bisher das beste Ergebnis.  
Nach einem Doppelklick auf den richtigen Eintrag werden Metadaten und Bilder heruntergeladen. Im anshcluss wird oben im Menü auf 'Speichern' geklickt und die Daten werden in das Filmverzeichnis geschrieben.  


# curlftpfs
Obwohl ich FTP soweit es geht meide, finde ich SMB unter Linux noch doofer und nutze das Paket `curlftpfs` um das Fritz!NAS Verzeichnis lokal verfügbar zu machen.

```bash
$ sudo mkdir /mnt/kodi
$ sudo chown user:user /mnt/kodi
$ sudo vim /etc/fstab
[...]
curlftpfs#ftp://fritz.nas /mnt/kodi fuse noauto,allow_other,codepage=latin1,iocharset=utf8,umask=0022,user=user:password 0 0
```

* noauto - Nicht beim Booten laden
* allow_other - Andere Benutzer erlauben
* codepage=**latin1** - Damit das Fritz!NAS auch umlaute speichert
* iocharset=**utf8** - Lokal sollte man nichts anderes mehr nutzen
* umask=**0022** - Standardberechtigung für angelegte Dateien
* user=**user:password** - user und password natürlich anpassen

Manchmal funktioniert durch das Routing der Hostname nicht, dann hilft es fritz.box als Hostnamen oder die IP anzugeben.

