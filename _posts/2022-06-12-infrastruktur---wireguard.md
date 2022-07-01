---
status: published
published: true
layout: post
title: Infrastruktur - WireGuard
author: Benjamin Moeller
date: 2022-06-12 21:14:03 UTC
categories: [infrastruktur]
tags: [wireguard]
comments: []
---

# Motivation

Für mein Wohnmobilprojekt habe ich mir einen GL.iNet Beryl Reiserouter gekauft. Diese kleinen Dinger aus Hong Kong basieren auf OpenWRT und bieten für schmales Geld (35-80 Euro) eine gute Basis um unterwegs mehrere Geräte mit geringem Aufwand zu betreiben.  
Die Grundidee ist, dass ich nicht jedes meiner Geräte im (Hotel)WLAN anmeldne muss, sondern den Router vorschalte und dieser einen sicherne Zugang für alle meine Geräte stellt. Sicher, weil die kleinen Router standardmäßig eine Unterstützung für gängige Protokolle, wie OpenVPN und WireGuard mitbringen. Wer keine Möglickeit hat einen Endpunkt zu mieten oder selbst aufzubauen, dem steht immernoch per Klick das TOR Netzwerk offen.  
Mit OpenVPN bin ich nie warm geworden, daher versuche ich mich am aktuelleren WireGuard.  

# WireGuard Skript - Erste Schritte

Wireguard bietet für Linux ein 'All in One' Skript an. Dieses ist genauso gruselig, wie es klingt. Es wird aus dem internet heruntergeladen und ausgeführt ...  

> wget https://git.io/wireguard -O wireguard-install.sh && sudo bash wireguard-install.sh

Als erste Testumgebung habe ich damit angefangen. Und es funktioniert.  

Dann wollte ich den Service auf meine Umgebung anpassen. Also Konfiguration unter `/etc/wireguard/` anpassen und den Dienst neu starten ... den Dienst ... den Dienst ... Wo ist der denn? ... Server durchstarten geht auch.  
Schon vorher wollte ich dringend das Skript gegen eine saubere Installation ersetzen. Spätestens an dem Punkt war mir die Dringlichkeit bewusst.  

## Wireguard aufsetzen

Im Proxmox schnell einen Container erstellt. Debian 11.0.3 Image, 12GB Festplatte auf der lokalen SSD, 1Core, 512MB RAM und im Netzwerk 'vmbr1 - Green'. Container starten.  

Ab Debian 11 ist das Paket [wireguard](https://packages.debian.org/bullseye/wireguard) mitgeliefert, davor benötigt es [Backports](https://packages.debian.org/buster-backports/wireguard).

---

# Abbruch  

## A long story short
Auf dem Proxmox (oder anderen virtuellen Umgebungen) hat man keinen direkten Zugriff auf /dev/tun. Das lässt sich mit ein paar Hebeln gerade biegen und der Helper Boringtun von Cloudflare unterstützt das ganze...  
Aber da ich so viel parallel lernen musste, bleibe ich zunächst bei dem oben genannten Script.  

---

# Wireguard Server (Skript)

## /etc/wireguard/wg0.conf

Die zentrale Konfigurationsdatei für dne ersten Tunnel (wg0) wird angelegt.  
In dieser Datei befindne sich folgende Zeilen:  

```
[Interface]
Address = 10.7.0.1/24, fddd:2c4:2c4:2c4::1/64
PrivateKey = UGxxxxxxxxxxxxxxxWw=
ListenPort = 51820
```

Unter [Interface] wird definiert, wie wg0 antworten soll.
* **Address** gibt an welche IP wg0 bekommt und in wlechem Netz es existiert
* **PrivateKey** sollte nie an die Öffentlichkeit gelangen, dieses ist das Geheimnis, welches Euer VPN schützt. Der Name lässt shcon vermuten: Diese Information ist privat.
* **ListenPort** ist der Port, an den die Firewall weiterleiten muss (Portforwarding) und/oder der in der Firewall geöffnet werden muss. Zum Glück nur für UTP.

```
# BEGIN_PEER amy
[Peer]
PublicKey = hI8xxxxxxxxxxxxxxxxxxe3M=
PresharedKey = Ew7xxxxxxxxxxxxxxxxxxsg=
AllowedIPs = 10.7.0.2/32, fddd:2c4:2c4:2c4::2/128
# END_PEER amy
```

Die Kommentare am Anfang und am Ende sind für Wireguard unwichtig, werden aber vom Script gelesen um Peers (Teilnehmer) in der Konfigurationsdatei zu erkennen, bearbeiten und bei Bedarf zu löschen.
* **PublicKey** ist der öffentliche Schlüssel. Dieser ist nicht allzu wichtig, wenn der verloren geht. Im Verlustfall reicht es aus den Peer zu entfernen und, wenn gewünscht, neu anzulegen.
* **Presharedkey** Dieser ist zu sehen wie WLAN Key. Der sollte geheim bleiben.
* **AllowedIPs** definiert die IP des Endpunkts und das Netz.


## Routing

Das Routing wird nicht von Wireuard übernommen! Wireguard stellt das Netzwerkgerät wg0 und ein anderes Programm sorgt für das routing. Klassisch wurden bisher unter Linux bisher die iptables dafür eingesetzt, diese werden nun durch die nftables ersetzt.

Das Programm `iptables-save` sagt:

> *filter
> :INPUT ACCEPT [0:0]
> :FORWARD ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> -A INPUT -p udp -m udp --dport 51820 -j ACCEPT
> -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
> -A FORWARD -s 10.7.0.0/24 -j ACCEPT
> COMMIT
> *nat
> :PREROUTING ACCEPT [0:0]
> :INPUT ACCEPT [0:0]
> :OUTPUT ACCEPT [0:0]
> :POSTROUTING ACCEPT [0:0]
> -A POSTROUTING -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to-source 192.168.21.51
> COMMIT

Interessant ist die vorletzte Zeile: Alles was 10.7.0.0/24 (der Tunnel) ist und nicht an 10.7.0.0/24 geht, wird an 192.168.21.51 weitergeleitet.  
Aber was macht 192.168.21.51 damit?

```
root@walter01:~# ip r
default via 192.168.21.1 dev eth0 onlink 
10.7.0.0/24 dev wg0 proto kernel scope link src 10.7.0.1 
192.168.21.0/24 dev eth0 proto kernel scope link src 192.168.21.51
```

Es hat keine spezielle Route, aso wird es an die Defaultroute übergeben und an 192.168.21.1 gegeben ... welches zufällig mein Router in das Internet ist.

### Zusammenfassung

Wireguard erstellt einen Tunnel mit dem Subnet 10.7.0.0/24. Alle Geräte im Tunnel (Peers) bekommen eine feste IP.
Die iptables nehmen auf dem Wireguard Server den Netzwerkverkehr und geben diesen an das Netzwerkgerät im LAN.
Durch das NAT weiss der Router ins Internet nicht, dass der Verkehr aus dme Tunnel kommt. Für das LAN sieht es aus als würdne alle Anfragen vom Wireguard Server lokal kommen.

## Wireguard Client Config

Die Client config wird per dem oben genanntne Script einfach erstellt. Es wird eine Datei mit dem namen und der Endung .conf erstellt.  
### amy.conf

```
[Interface]
Address = 10.7.0.2/24, fddd:2c4:2c4:2c4::2/64
DNS = 192.168.21.53
PrivateKey = 4P8xxxxxxxxxxxxxxx1I=

[Peer]
PublicKey = UlExxxxxxxxxxxxxxx3o=
PresharedKey = Ew7xxxxxxxxxxxxxxxsg=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = vpn.domain.org:51820
PersistentKeepalive = 25
```

Hier sehen wir die folgenden Einstellungen:

Abschnitt [Interfaces]
* **address** Die Client Adresse im VPN. Es funktioniert hier kein DHCP!
* **DNS** Der DNS Server muss entweder im LAN stehen und erreichbar sein, ode rman nimmt einen externen. Ein Externer DNS Server ist auch ein Sicherheitsrisiko, da dieser jede Hostnamenauflösung mitschneidet.
* **PrivateKey** Wieder besonders schützenswert. Wer diesen Key hat, kann sich mit geringem Aufwand als der Client ausgeben.

Abschnitt [Peer]
* **PublicKey** Dieser darf wieder bekannt werden. Dieser dient 'nur' zur cryptografischen Austhentifizierung.
* **PresharedKey** Ist der Schlüssel, den alle Clients und der Server kennen muss. Aber wie beim WLAN Key (PSK) sollte es keiner kennen, der nicht in das VPN soll.
* **AllowedIPs** Hier wird es interessant. Diese Option definiert welcher Verkehr über den Tunnel gehen soll.
* **Endpoint** Hier wird dem Client gesagt, über wleche Adresse der Server erreicht wird. Soll der Tunnel über Internet aufgebaut werden, muss der VPN Server auch über diesen Hostnamen und dem Port aus dme Internet erreichbar sein.
* **PersistentKeepalive** Wenn diese Uption nicht gesetzt ist, kann es sein dass die Verbindung bei nicht-Nutzen getrennt wird. Also wird alle 25 Sekunden ein Signal über die Leitung geschickt. 

## Allowed IPs

> AllowedIPs = 0.0.0.0/0, ::/0

Wenn der VPN tunnel aufgebaut wird und 0.0.0.0/0 'Allowed' ist, dann wird der gesamte Netzwerkverkehr über dne Tunnel gesendet.

In Unternehmen soll oft nur der Netzwerkverkehr der Firma über dne Tunnel gesendet werden. Dann wird einfach das entsprechende Subnetz eingetragen, zum Beispiel: 192.168.21.0/24. Der Wireguard Server muss das Subnetz natürlich kennen und bedienen können.
Es gibt auch die Wariante mit 0.0.0.0/1. Damit wird die Default-Route im System nicht überschireben und im Falle eines Ausfal im/des VPN kann der Client weiterhin im Internet agieren.

