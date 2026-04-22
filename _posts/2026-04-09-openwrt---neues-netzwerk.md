---
status: published
published: true
layout: post
title: OpenWrt - Neues Netzwerk
author: Benjamin Moeller
date: 2026-02-24 22:52:01 UTC
categories: [howto]
tags: [produkte, openwrt, glinet]
comments: []
---

Seit ich denken kann hatte ich AVM Fritz! Geräte als Router für mein Heimnetzwerk benutzt. Zuerst den Fritz!ISDN USB, eine externe ISDN Karte, dann alle möglichen Varianten der Fritz!Box. Ein Gerät was einfach alles macht, von Internetrouting über DECT Basis mit VoIP Telefonie bis hin zum Faxmodem als man kein Gerät mehr zuhause stehen haben wollte. Und das alles mit einer herausragenden Linux Unterstützung in einem einfachen "Mesh".  
Der Marketingbegriff Mesh beinhaltet hier auf der einen Seite, dass man das WLAN am zentralen Punkt einstellt und die Konfiguration an alle verbundenen AP übertragen wird. Auf der anderen Seite bedeutet es, dass ein Endgerät (z.B. Mobiltelefon) ohne Unterbrechung von einem zum anderen AP wechseln kann. Das funktioniert nur unter AVM Geräten.  

Wenn wir das technisch angehen, spielen hier verschiedene Techniken eine Rolle:  
Das "Wireless Mesh Network (WMN)" ist im Standard [IEEE 802.11s](https://de.wikipedia.org/wiki/IEEE_802.11s) beschrieben. Dieser Standard ermöglicht den Aufbau eines Wireless Mesh Nezwerks mit möglichst geringer Konfiguration an den Endpunten. Benötige ich Das? Damit befasst Sich OpenWRT unter [are_you_sure_you_want_a_mesh](https://openwrt.org/docs/guide-user/network/wifi/mesh/802-11s#are_you_sure_you_want_a_mesh) ... meistens reicht: 
Das "Fast Basic Service Set (BSS) Transition" aus dem Standard [IEEE 802.11r](https://de.wikipedia.org/wiki/IEEE_802.11r).  

Standards, die in diesem Zusammenhang erwähnt werden, sind:  
Oft findet sich noch das Roaming als Begriff, welches der Standard [IEEE 802.11f](https://de.wikipedia.org/wiki/IEEE_802.11f) ist und dafür sorgt, dass es zu keinen Verbindungsabbrüchen kommt. Das ist seit 2006 in den Standard IEEE 802.11r übernommen worden. Daher gehe ich darauf nicht weiter ein.  
Zur Optimierung eines Mesh unterstützt OpenWrt noch die Standards [IEEE 802.11k](https://de.wikipedia.org/wiki/IEEE_802.11k) (Neighbor Reports) und [IEEE 802.11v](https://de.wikipedia.org/wiki/IEEE_802.11v) (Network assisted roaming), siehe: https://openwrt.org/docs/guide-user/network/wifi/roaming ... Beide sind mittlerweile Bestandteil des generellen Standards ab 802.11-2024.  

# Wenn es das fertig gibt, warum selbst bauen?
AVM funktionierte seit mehr als 25 Jahren perfekt für mich. Letztes Jahr wurde der Familienbetrieb von einem Großkonzern gekauft. Bereits zuvor wurde sichtbar, dass die QA nichtmehr Lückenlos funktioniert. Es gibt weiterhin im Verglech zu anderen "big playern" sehr wenig Meldungen zur Sicherheit, aber die Firmware wird mit immer mehr Features versehen, die Fehler häufen sich.  

Die oben genannten Standards haben das Ziel 'Herstellerunabhängig' zu sein. Heute baue ich mein Netzwerk komplett mit GL.iNet Geäten auf, weil diese am besten zu meiner Infrastruktur passen. Morgen vielleicht ein anderes Unternehmen.  

# Setup des ISP Routers
In Deutschland wurde lange diskutiert, aber ab August 2016 der [Routerzwang](https://de.wikipedia.org/wiki/Routerzwang) abgeschafft. Das bedeutet ich darf an meinem Endpunkt jeden Router einsetzen, den ich will, ich muss nicht zwingend ein Gerät vom ISP (Internet Service Provider) nutzen.  
Das klingt auf dem Papier sehr positiv, aber in der Praxiszeigt sich, dass dadruch oft im Supportfall der Endkunde verantwortlich gemacht wird, weil man nicht auf den Router für eine Analyse kann. Möchte ich als Endkunde, dass der Provider auf meien Router, und somit in mein Netzwerk kommt? Eigentlich nicht. Der Routerwechsel setzt aber ein technisches Grundverständnis voraus, so dass man vor einem 1st Level Support Mitarbeiter argumentieren kann, dass ein Diesntneustart genügt und kein 'Stromlos machen' notwendig ist ... am Ende zieht man doch kurz den Stecker um endlich eine Problemlösung zu bekommen.  

Während viele Provider irgendwelche Speedport oder Zyxel Router angeboten haben, war die AVM Fritz!Box meistens als Alternative gegen Aufpreis verfügbar. Wer eine fritz!Box von einem der großen Anbieter bekommen hat hatte manchmal das Glück, dass die Standard Firmware drüber lief, manchmal benötigte es mehr Aufwand, wie das anpassen der Seriennummer im [mdt](https://openwrt.org/docs/techref/flash.layout#mtd_memory_technology_device_and_mtdsplit) oder ähnliches.  

Aus dem Grunde habe ich mich dazu entschlossen auf GL.iNet zu setzen.  
GL.iNet setzt auf OpenWrt auf, und bietet viele Funktionen in ihrer eigenen Oberfläche, welche das Bedienen deutlich einfacher macht. Für den normalen Heimgebrauch vollkommen ausreichend und die Travel Router sind unterwegs gold.  
Leider baut GL.iNet in einige Router Hadrware mit Closd Source SDK, so dass ein Upgrade oder Switch zu nativem OpenWrt nicht so einfach möglich ist. Daher habe ich mich für den Flint2 als Basis entschieden und die Beryl Serie als Sateliten, welche 100% OpenWrt unterstützt sind.  

## GL.iNet Flint2 (GL-MT6000)
Der [Flint2 (GL-MT6000)](https://www.gl-inet.com/products/gl-mt6000/) ist etwas in die Jahre gekommen, aber mit 2x 2,5 Gbit RJ45 (plus 4x 1 GBit) und WiFi6 noch nicht zu alt. Verglichen zu meiner neusten Fritz!Box 7590 ist die Ausstattung sogar aktueller.  

### OpenWrt herunterladen
Für OpenWrt gibt es den Firmware Selector unter [https://firmware-selector.openwrt.org/](https://firmware-selector.openwrt.org/). Mit dem Suchbegriff `MT6000` wird das Ergebnis `GL.iNet GL-MT6000` vorgeschlagen, welchen wir auswählen.  
Oben rechts, hinter dem Suchenfeld, kann der Version ausgewählt werden. Ich erstelle diese Anleitung mit `25.12.2`. Solange wir einen funktionierendne Flint2 haben wählen wir darunter den Button `SYSUPGRADE`.  
Für jeden erdenklichen Status von 'Router funktioniert' und vor 'Router brennt' gibt es unterschiedliche Optionen der Firmware. Die alle zu erklären wäre ein eigener Beitrag.  

### OpenWrt installieren
Wird der Flint2 frisch gestartet, ist die GL.iNet Adminoberfläche unter [http://192.168.8.1/](http://192.168.8.1/) zu erreichen. Der Client an einem der LAN Ports erhält automatisch eine IP aus dem 192.168.8.0/24 Netz. Diese kann auf Wunsch manuell gesetzt werden.  

Links im Menu unter 'System - Upgrade' kommt man zum internen Firmware upgrade. Im neuen Fenster unter dem Reiter 'Firmware Local Upgrade' kann eine beliebige kompatible Firmwaredatei hochgeladen werden. Hier laden wir die gerade heruntergeladene Datei, z.B. `openwrt-25.12.2-mediatek-filogic-glinet_gl-mt6000-squashfs-sysupgrade.bin`, hoch.  
Ganz wichtig: Wir wollen auf keinen Fall die Einstellungen übernehmen! Das klingt zwar verlockend, aber die Einstellungen der GL.iNet Firmware und von OpenWrt sind inkompatibel.  

Nach der erfolgreichen Installation ist OpenWrt unter [http://192.168.1.1/](http://192.168.1.1/) zu erreichen. Als Benutzer wird `root` eingetragen, das Passwort bleibt leer.  

## OpenWrt Basiskonfiguration
Im generellen ist OpenWrt im Auslieferungszustand sicher, da keine unnötigen Dienste installiert oder gestartet sind. Dennoch gibt es ein paar Einstellungen, welche man zum Start setzen sollte.  

Im Menü oben: System - Administration

- Reiter: Router Passwort -> Passwort für root setzen  
  In der Standardusführung ist kein Standardpasswort gesetzt, dadurch kann man dieses auch nicht vergessen zu ändern.
- Reiter: SSH Access -> Interface: lan  
  Damit ist die remote SecureShell (SSH) nur über das LAN Interface erreichbar und nicht aus dem WAN oder einem später eingerichteten VLAN.
- Reiter: HTTP(S) Access -> Redirect to HTTPS  
  OpenWrt funktioniert maximal kompatibel über http. Mit dieser Option wird es auf https gestellt, damit z.B. Passworte nicht mehr in Klartext im Netzwerk übertragen werden.  

Ein paar Einstellugngen am System helfen das System in der Infrastruktur zu integrieren.  

Im Menü oben: System - System

- Reiter: General Settings -> 
  - Timezone: 'Europe/Berlin', Button: Sync with Browser (oder NTP-Server).
  - Hostname: Für Mesh anpassen
- Reiter: Timesynchronisation -> belassen oder andere Source

### OpenWrt aktualisieren

Ein Router ist ein Embbeded Device mit einer sehr speziellen Aufgabe. Dieses System ist anders zu behandeln als ein PC oder eine Spielekonsole. Das blinde Updaten aller Pakete (`apk upgrade`) ist bei der Erstinstallation sinnvoll, aber wenn die Services konfiguriert sind, kann dieses Vorgehen wichtige Konfigurationen oder individuelle Anpassungen überschreiben und somit das Netzwerk brechen.  
Im besten Fall bekommt man sofort mit das eine oder mehrere Funktionen nicht mehr erreichbar sind, im schlimmsten Fall entsteht eine nicht entdeckte Sicherheitslücke. Wenn es keinen dringenden Grund (Bugfix, Sicherheitslücke, ...) gibt, sollte man sich überlegen ob ein Upgrade von Paketen zwischen den Major Releases druchgeführt werden muss.  
Ihr glaubt mir nicht? OpenWrt behauptet das auch: https://openwrt.org/docs/guide-user/additional-software/apk#updating_packages

Im Menü oben: System - Software

Actions: Button: 'Update Lists ...' -> Warten und Dismiss  
Reiter: Updates -> Jedes Paket mit dem Button 'Upgrade...' auswählen.  
Bei der Option 'Allow overwriting conflicting package files' aufpassen, da lokale Konfigurationen überschrieben werden können. Auch Zertifikats Schlüssel und VPN Konfigurationen. Siehe oben.  

Im Terminal:  
Per SSH mit dem OpenWrt verbinden, z.B. `ssh root@192.168.1.1`
 `opkg update opkg list-upgradable | cut -f 1 -d ' ' | xargs -r opkg upgrade`  

Ab OpenWrt 25.12 wird der Paketmanager von **opkg** zu **apk**. Damit wird auch die cut/xargs Magie überflüssig:
`apk update && apk upgrade`  

Hilfe zum Wechsel auf apk: https://openwrt.org/docs/guide-user/additional-software/opkg-to-apk-cheatsheet

### DHCP konfigurieren

Om OpenWrt gibt es eine Einstellung für DHCP, diese ist für den Dienst an sich. Viel interessanter für die Einrichtung am Router ist die Einstellung unter 'Network - Interfaces' und dem entsprechenden Netzwerkadapter. Für jeden Netzwerkadapter wird der DHCP Service indivuduell konfiguriert.  

Im Menü oben: Network - Interfaces

Adapter: LAN - Button: Edit
- Tab 'General Settings' -> 
  - IPv4 address: 192.168.1.1 (Die Interface Adresse bestimmt die ersten Oktett der vergebenen DHCP Adressen)
  - IPv4 netmask: 255.255.255.0 (Bestimmt die Größe des Netzwerks, hier 192.168.1.0/24)
- Tab: 'Advanced Settings' -> Einstellungen für den DHCP server, nicht für die Clients
- Tab: 'DHCP server' -> Einstellungen für den DHCP Server
  - Tab: 'General Settings' -> DHCP Options für z.B. individuelle DNS Server per DHCP (mit + 'speichern')
  
In der Praxis hat es sich bewährt für die erstem Tage die Leasetime auf 2h zu setzen, um fehlkonfigurationen zeitnah verschwinden zu lassen. In der Praxis können diese deutlich länger gestellt werden.  
  
### DNS (Domain Name Service)

Das DNS besteht aus 2 Teilen. Zum einen werden die Namen intern vom eigenen DNS aufgelöst, dieses kann auch die DHCP Clients beinhalten. Zum Anderen gibt es einen Upstream DNS Server, an den alle Anfragen geleitet werden, welche nicht intern beantwortet werden können.  

Im Menü oben: Network - Interfaces

#### Internal
Als Standard bekommen die Clients den eigenen DNS Server (IP des Routers) per DHCP mitgeteilt. Wenn dieses nicht gewünscht ist, kann der oder die DNS Server mit der DHCP Option 6 konfiguriert werden:  

Adapter: LAN - Button: Edit

- Tab: 'DHCP server' -> Einstellungen für den DHCP Server
  - Tab: 'General Settings' -> `6,192.168.1.53,8.8.8.8` (mit + 'speichern')

#### Upstream
Adapter: WAN - Button: Edit

- Tab: 'Advanced Settings' -> Uncheck 'Use DNS servers advertised by peer'


### NTP (Zeitserver)
Diverse Protokolle im Netzwerk und Internet sind stark Zeitabhängig. Zum Beispiel Kerberos für die Windows Authenifikation per Active Directory, aber auch OTP Dienste oder einige Verschlüsselungen. Eine falsche lokale Systemzeit sorgt für eine Abweichung und somit zu einem nicht funktionierenden System.  

Oben im Menü: System - System

- Tab: Time Synchronisation -> Check 'Provide NTP Server'  
  Damit wird im OpenWrt die Funktion des Zeitserver für die Clients aktiviert.
  - 'Bind NTP server': LAN 
  
(Todo: DHCP NTP server)

## Netzwerke erstellen mit VLAN
Die Netzwerke benötigen ein wenig mehr Planung. An dieser Stelle gerne eine kurze Pause einlegen, tief durchatmen und ein Getränk zubereiten.  

OpenWrt hat ein Sicherheitsmechanismus, der eine Konfigurationsänderung speichert und aktiviert, wenn innerhalb von 90 Secunden keine neue Anmeldung an der Weboberfläche druchgeführt wurde, wird die Konfiguration wieder zurückgerollt.  
Das ist gerade am Anfang sehr angenehm um etwas zu testen, allerdings habe ich es auch geschafft dass ich mich trotz Rollback ausgesperrt habe. Also lieber kleinere Schritte zwischendruch Speichern/Bestätigen, als einen großen Schwung.  

Ich kann ganz einfach pro geplantem Netzwerksegment eine Bridge erstellen und dort die entsprechenden physikalischen Ports hinzufügen. Über 'Interfaces' vergebe ich der Bridge die notwendigen Konfigurationen für DHCP und anderes.  
Funktioniert. Wird nur kompliziert den Überblick der VLAN Konfigurationen zu behalten.  
Ich habe ein Device erstellt 'vSwitch' und dem alle LAN Ports (außer WAN) zugewiesen. Das vereinfacht das zentrale Management.  

Für das VLAN gibt es zwei Arten von Ports.
1. Untagged, das bedeutet alles was dort rein kommt ist ein normales Netzwerkgerät, ohne IEEE 802.1v Standard.
2. Tagget, das bedeutet die Entgeräte verstehen VLAN nach IEEE 802.1v und geben an zu welcher VLAN ID sie gehören.

Eine Besonderheit von OpenWrt ist, dass der Port ein einziges Untagged VLAN und mehrere Tagged versteht. Alles was an dem Port ohne VLAN Konfiguration angeschlossen wird, wird in ein 'default VLAN' gerouted. Das funktioniert nicht bei allen VLAN Geräten, die meisten die ich kenne können auf einem Port nur eine Untagged ID oder beliebig viele Tagged ID verwalten.  

Im Menü oben: Network - Interfaces

- Reiter: 'Devices'
  - Button 'Add device configuration ...'
    - Device Type: 'Bridge device'
    - Device Name: 'vSwitch', ...
    - Ports: Wähle Ports, die nicht woanders gebunden sind
    - Reiter: 'VLAN'  
 
| VLAN ID | LAN1  | LAN2  | LAN3  | LAN4  | LAN5  |
| :---    | :---: | :---: | :---: | :---: | :---: | 
| 1       | U     | U     | U     | U     | U     |
| 10      | T     | T     | T     | T     | T     |
| 20      | T     | T     | T     | T     | T     |

- Reiter: 'Interfaces'
  - Device 'LAN' -> Button 'Edit'
    - Device: Von 'br-lan' auf 'vSwitch.1' (.1 ist die ID Eures VLAN)
    
Das Device 'br-lan' kann entfernt werden nachdem der Zugriff getestet wude und weiterhin funktioniert.

Jetzt werden die anderen VLAN angelegt:  

- Reiter: 'Interfaces'
  - Button 'Add new interface ...'
    - Name: 'guest' ('iot', 'dmz', ...)
    - Protocol: 'Static address'
    - Device: 'Bridge:  "vSwitch.10"' ("vSwitch.20", "vSwitch.nn", ...)
    - Button 'Create Interface'
      - IPv4 Address: 192.168.n.1, Netmask: 255.255.255.0  
        Es hat sich bewährt bei /24 Netzen das 3. Oktett (n) gleich der VLAN ID zu setzen.
    - Reiter: DHCP
      - Enable DHCP
    
Button 'Save and Apply'
 
## Firewall
Die Firewall wird im Allgemeinen als Blocker für böses aus dem Internet verstanden. Dabei kann eine Linux Firewall noch viel mehr. Mittels Firewall (bis OpwnWrt 21.02 `iptables`, ab OpenWrt 22.03 `nftables`) kann der Netzwerkverkehr nicht nur gesperrt, sondern auch definiert umgeleitet werden.  
Zuerst werden wir die Firewall im generellen für den Gebrauch im Heimnetzwerk optimieren.  

Oben im Menü: Network - Firewall

- Reiter: 'General Settings'
  - Check 'Drop invalid packages'
  - Forward: 'Drop'  
    Die Voreinstellung 'Reject' ist zwar sicher, benötigt aber mehr CPU, da eine negative Antwort auf Anfragen generiert wird. Bei Drop wird das Paket einfach verworfen.  
  - Zones:
    - Lan -> wan: IPv4 Masquerading if main router
    - wan -> reject: Input drop, Intra zone forward: drop, Masquerading: uncheck
  - Button: Add
    - Guest -> reject: Input drop, Output accept, Intra zone forward: accept, Masquerading: check
  - Button: Add
    - IoT -> reject: Input drop, Output accept, Intra zone forward: accept, Masquerading: check
    
Unter 'Allow forward to destination zone' wird definiert wohin das Netz senden darf. Hier wird in der Regel 'WAN' angegeben, um Zugriff zum Internet zu erlauben.  
Unter 'Allowed forward from source zone' wird definiert aus welchem Netzwerk in dieses Netzwerk kommuniziert werden darf. In der Übersicht steht dieser Eintrag dann umgekehrt in der 'Source zone' als 'destination'.  


Damit das neue Netz ein Router erreicht, werden individuelle Regeln angelegt. Je nach Geschmack können mehrere Protokolle in einen Eintrag zusammengefasst werden, aber gerade für Basisdienste würde ich die Einträge trennen. Vielleicht will ich später den DNS Server auslagern, aber der DHCP Server bleibt der Router selbst.  

- Tab: 'Traffic Rules'
  - Button: 'Add'
    - Name: 'guest-dhcp'
    - Protocol: UDP für DHCP
    - Source zone: guest
    - Destination zone: Device (input)
    - Destination port: 67 68
  - Button: 'Add'
    - Name: 'guest-dns'
    - Protocol: UDP, TCP
    - Source zone: guest
    - Destination zone: Device (input)
    - Destination port: 53

Das für alle VLAN mit entsprechenden Namen wiederholen.  

### NAT
Die IPv4 Adressen sind begrenzt, das bedeutet man bekommt in der Regel vom Internet Service Provider nur eine IP Adresse zugewiesen. Das NAT (Network Adress Translation) sorgt bei IPv4 dafür, dass von einem beliebigen Gerät aus dem LAN eine Anfrage an das WAN gesendet werden kann, und die Antwort an das Anfragende Gerät zurück gesendet wird. Für das internet sehen mehrere Anfragen aus verschiedener Geräte so aus, als würden sie alle vom Router selbst kommen.  

Über die Checkbox hinter jeder Regel oder deaktivieren. Über den Tab 'NAT rules' funktioniett das differenzierter.  


Bisher haben wir das Netzwerk verkabelt erstellen. Das funktioniert mit jedem OpenWrt Gerät. Wenn das Gerät mindestens 2 RJ45 Ports besitzt (1x WAN, 1x LAN), sollte die oben genannte Konfiguration keine Probleme machen. Alle Endgeräte sollten in dem Fall VLAN fähig sein, wenn wir keine LAN Ports für ein Extra VLAN untagged konfigurieren können.  

## WLAN
Der Flint2 besitzt, wie viele Router, die WLAN Funktion. Dieser Router hat 2 Radio Devices, einen für das 2,4 GHz Band und einen für 5 GHz. Die sind in der Standardkonfiguration von OpenWrt nicht aktiv, obwohl ein Standardprofil mit der SSID 'OpenWrt' hinterlegt ist.  

Im Menü oben: Network - Wireless  
Tipp: Wenn der Reiter nicht existiert, muss ein Treiber für die WLAN Karte nachinstalliert werden. Eine Übersicht der unterstützten Treiber gibt es unter https://openwrt.org/docs/techref/driver.wlan/start  

### 2,4 GHz HauptWLAN
Unter 'Radio 0' auf die Vorlage mit 'SSID: OpenWrt' den Button 'Edit' klicken oder über 'Add' eine Neue erstellen.
- Reiter: 'General Setup'
  - Operating Frequency: AX, Channel 1, 6 or 11, Width: 20 MHz
  - Unterreiter: 'General Settings'
    - ESSID: Der Name des WLAN
    - Network: eines der unter 'Network - Interfaces' erstellte Interface.
  - Unterreiter: 'WLAN Encryption'
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
  - Untereiter: 'WLAN Roaming'
    - 802.11r -> Checkbox aktivieren
    - NAS ID: 0001 für den HauptAP, alle weiteren AP mit fortlaufender Nummerierung.
    - Mobility Domain: 4 Byte Hex Wert. Diese muss auf allen AP im Mesh gleich sein. Standard auf neueren OpenWrt: Die ersten 4 Byte der SSID MD5sum.

WLAN Verschlüsselungen im Überblick:  
- Offen - Nein.
- WEP/WPA - Zu alt, das wollen wir nicht in unserem Netzwerk haben, da kann man auch Offen wählen, das verrät zumindest kein Kennwort.  
- WPA2 - bietet maximale Kompatiblität, gerade für ältere Geräte oder IoT sollte man das weiterhin unterstützen.  
- WPA3 - Das ist der heutige Standard, der ist nicht nur im Ansatz sicherer, sondenr verhindert auch das Remote Deauth druch unbefugte.
  
Tipp: Generell steht es einem frei jeden Kanal zu nutzen. Empfohlen wird allerdings bei 1, 6 oder 11 zu bleiben, da bei diesen Frequenzen die geringseten Überlappungen existieren. Das WLAN kann Intefferenzen durch konkurierende WLAN zwar in Grenzen kompensieren, das funktioniert aber besser mit WLAN im identischen Frequenzspektrum, als mit WLAN mit überlapungen.  
1. Einen Frequenzscan druchführen und schauen wo am wenigsten los ist.
2. Nach Möglichkeit einen ungenutzten Bereich wählen
3. Wenn kein Bereich frei ist, den mit der geringsten Auslastung (und Überlappung) auf den Kanälen 1, 6 oder 11 nutzen.

### 5 GHz HauptWLAN
Unter 'Radio 1' auf die Vorlage mit 'SSID: OpenWrt' den Button 'Edit' klicken oder über 'Add' eine Neue erstellen.
- Reiter: 'General Setup'
  - Operating Frequency: AC, Channel 134 (dreistellig darf mehr Watt senden), Width: 40 MHz
  - Untereiter: 'WLAN Roaming'
    - 802.11r -> Checkbox aktivieren
    - NAS ID: 0001 für den HauptAP, alle weiteren AP mit fortlaufender Nummerierung.
    - Mobility Domain: 4 Byte Hex Wert. Diese muss auf allen AP im Mesh gleich sein. Standard auf neueren OpenWrt: Die ersten 4 Byte der SSID MD5sum.

### Gäste/IOT WLAN
Unter 'Radio 0' (2.4 GHz) über 'Add' eine neue Vorlage erstellen.
- Reiter: 'General Setup'
  - Operating Frequency: AX, Channel 1, 6 or 11, Width: 20 MHz
- Reiter: 'Advanced settings': Isolate clients

Unter 'Radio 1' (5 GHz) über 'Add' eine neue Vorlage erstellen.
- Reiter: 'General Setup'
  - Operating Frequency: AC, Channel 161 (dreistellig darf mehr Watt senden), Width: 40 MHz


# Setup MeshAP
OpenWrt nennt die 'Satelliten' im Mesh "Dumb AP". Dieses sind im Kern meist router, aber es werden sämtliche Routingfunktionen und Services (DHCP, DNS, ...) entfernt.  

## Beryl AX (Gl.iNet MT-3000)
Der [Beryl AX (GL-MT3000)](https://www.gl-inet.com/products/gl-mt3000/) ist ein deutlich kleineres Gerät als der Flint2, er bietet nur 2 LAN Ports, darunter 1x 2,5 GHz für WAN und 1 GBit für LAN. Da er nur als AP funktionieren soll reicht uns sein WiFi6 vollkommen aus. Der Upling zum Flint2 wird über dne WAN Port umgesetzt.  
Es ist empfehlenswert für die Ersteinrichtung nur einen PC oder einen Laptop per Kabel an den Beryl AX LAN Port anzuschliessen. Über den WAN Port kann er in das vorhandene LAN gebracht werden, z.B. um das OpenWRT Image herunterzuladen.

### OpenWrt herunterladen
Für OpenWrt gibt es den Firmware Selector unter [https://firmware-selector.openwrt.org/](https://firmware-selector.openwrt.org/). Mit dem Suchbegriff `MT3000` wird das Ergebnis `GL.iNet GL-MT3000` vorgeschlagen, welchen wir auswählen.  
Oben rechts, hinter dem Suchenfeld, kann der Version ausgewählt werden. Ich erstelle diese Anleitung mit `25.12.2`. Solange wir einen funktionierenden Beryl AX haben wählen wir darunter den Button `SYSUPGRADE`.  

### OpenWrt installieren
Wird der Beryl AX frisch gestartet, ist die Oberfläche unter [http://192.168.8.1/](http://192.168.8.1/) zu erreichen. Der Client an einem der LAN Ports erhält automatisch eine IP aus dem 192.168.8.0/24 Netz. Diese kann auf Wunsch manuell gesetzt werden.  

Links im Menu unter 'System - Upgrade' kommt man zum internen Firmware upgrade. Im neuen Fenster unter dem Reiter 'Firmware Local Upgrade' kann eine beliebige kompatible Firmwaredatei hochgeladen werden. Hier laden wir die gerade heruntergeladene Datei, z.B. `openwrt-25.12.2-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin` hoch.  
Ganz wichtig: wir wollen auf keinen Fall die Einstellungen übernehmen! Das klingt zwar verlockend, aber die Einstellungen der GL.iNet Firmware und von OpenWrt sind inkompatibel.  

Nach der erfolgreichen Installation ist OpenWrt unter [http://192.168.1.1/](http://192.168.1.1/) zu erreichen. Als Benutzer wird `root` eingetragen, das Passwort bleibt leer.  

## DumbAP Basiskonfiguration
Das OpenWrt ist in der Basisinstallation ein vollwertiger Router. Zwei Router können wir im Netzwerk nicht gebrauchen, diese würden sich dann um DHCP Zuweisung und ähnliches streiten. Daher stellen wir zuerst einige Dienste ab.

### OpenWrt Router zu Dumb AP
Oben im Menu: 

