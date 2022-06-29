---
status: published
published: true
title: Infrastruktur - WireGuard
author: Benjamin Moeller
date: 2022-06-12 21:14:03 UTC
categories: [infrastruktur]
tags: [wireguard]
comments: []
---

# Motivation

Für mein Wohnmobilprojekt habe ich mir einne GL.iNet Beryl Reiserouter gekauft. Dise kleinen Dinger aus Hong Kong basieren auf OpenWRT und bieten für schmales Geld (35-80 Euro) eine gute Basis um unterwegs mehrere Geräte mit geringem Aufwand zu betreiben.  
Die Grundidee ist, dass ich nicht jede smeiner Geräte im (Hotel)WLAN anmeldne muss, sondenr den Router vorschalte un ddieser einen sicherne Zugang für alle meine Geräte stellt. Sicher, weil die kleinen Router standardmäßig eine Unterstützung für gängige Protokolle, wie OpenVPN und WireGuard mitbringen. Wer keine Möglickeit hat einen Endpunkt zu mieten oder selbst aufzubauen, dem steht immernoch per Klick das TOR Netzwerk offen.  
Mit OpenVPN bin ich nie warm geworden, daher versuche ich mich am aktuelleren WireGuard.  

## WireGuard Skript - Erste Schritte

Wireguard bietet für Linux ein 'All in One' Skript an. Dieses ist genauso gruselig, wie es klingt. Es wird aus dem internet heruntergeladen und ausgeführt ...  

> wget https://git.io/wireguard -O wireguard-install.sh && sudo bash  
> wireguard-install.sh

Als erste Testumgebung habe ich damit angefangen, und es funktioniert.  

Dann wollte ich den Service auf meine Umgebung anpassen. Also Konfiguration unter `/etc/wireguard/` anpassen und den Dienst neu starten ... den Dienst ... den Dienst ... Wo ist der denn? ... Server durchstarten geht auch.  
Schon vorher wollte ich dringend das Skript gegen eine saubere Installation ersetzen. Spätestens an dem Punkt war mir die Dringlichkeit bewusst.  

# Wireguard aufsetzen

Im Proxmox schnell einen Container erstellt. Debian 11.0.3 Image, 12GB Festplatte auf der lokalen SSD, 1Core, 512MB RAM und im Netzwerk 'vmbr1 - Green'. Container starten.  

Ab Debian 11 ist das paket [wireguard](https://packages.debian.org/bullseye/wireguard) mitgeliefert, davor benötigt es [Backports](https://packages.debian.org/buster-backports/wireguard).

```
root@walter01:~# apt update && apt full-upgrade
[.. update magie ..]
root@walter01:~# apt install wireguard wireguard-tools linux-headers-amd64
[.. install magie ..]
root@walter01:~# wg genkey | sudo tee /etc/wireguard/server_private.key | wg pubkey | sudo tee /etc/wireguard/server_public.key
[.. key generation magie ..]
cF+ZkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxXiEc=
```

## WireGuard auf dem Server

Die Konfigurationsdatei erstellen:
```
root@walter01:~# vim /etc/wireguard/wg0.conf
```

> [Interface]
> Address = 10.10.10.1/24
> ListenPort = 51820
> PrivateKey = cF+ZkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxXiEc=

Darunter kommt noch ein wenig mit [Peers], sobald man einen client hat.

Und die Dateien für den Zugriff durch Unbefugte auf dem System sichern:
```
sudo chmod 600 /etc/wireguard/ -R
```

## Vom schlichten Server zum funktionalen Router

Jetzt kann der Server zwar erreicht werden, aber er ist noch kein Router.  

### Routing aktivieren

Um das zu ändern geben wir folgendes ein (Zeile 27 zur Erstellung diesen Artikels):  
`root@walter01:~# vim /etc/sysctl.conf`  

> [...]
> # Uncomment the next line to enable packet forwarding for IPv4
> net.ipv4.ip_forward = 1
> [...]

Dienst neu starten:  
`sudo sysctl -p`  

### Masquerading aktivieren

Ich nutze hier `ufw`, welches ein Frontend für die `iptables` ist. Es gibt verschiedene Wege an das Ziel zu kommen, das hier ist nur ein Vorschlag.  

```
root@walter01:~# apt install ufw
root@walter01:~# ufw allow 22/tcp
```

Mit `ip addr` ist zu sehen auf welchem Interface die IP gebunden ist. Auf dieser erlauben wir nun das NAT.

`vim /etc/ufw/before.rules`

Vor dem COMMIT wird das Masquerading aktiviert. das Interface (-o) mit dem Interface aus `ip addr` ersetzen!

> [...]
> # allow MULTICAST UPnP for service discovery (be sure the MULTICAST line above
> # is uncommented)
> -A ufw-before-input -p udp -d 239.255.255.250 --dport 1900 -j ACCEPT
> 
> # NAT rules
> *nat
> :POSTROUTING ACCEPPT [0:0]
> -A POSTROUTING -o eth0@if110 -j MASQUERADE
> 
> # don't delete the 'COMMIT' line or these rules won't be processed
> COMMIT

Und um im VPN die Kommunikation zwiwchen den Hosts zu erkauben, folgenden Block (unten) ergänzen:

> # ok icmp code for FORWARD
> -A ufw-before-forward -p icmp --icmp-type destination-unreachable -j ACCEPT
> -A ufw-before-forward -p icmp --icmp-type time-exceeded -j ACCEPT
> -A ufw-before-forward -p icmp --icmp-type parameter-problem -j ACCEPT
> -A ufw-before-forward -p icmp --icmp-type echo-request -j ACCEPT
> 
> # allow forwarding trusted network
> -A ufw-before-forward -s 10.10.10.0/24 -j ACCEPT
> -A ufw-before-forward -d 10.10.10.0/24 -j ACCEPT


### Aktivieren der Regeln

Und jetzt hoffen, dass man sich nicht aussperrt:  
`ufw enable`

Beim ersten Ausführen gab es einen Fehler mit dem Eintrag `*nat`. Beim zweiten Ausführen wurden die Regeln übernommen.  

Eine letzte Prüfung:  
`root@walter01:~# iptables -t nat -L POSTROUTING`


# Aktivieren von WireGuard auf dme Server

Als erstes geben wir den WireGuard (Standard-)Port frei:  
`ufw allow 51820/udp`

Zum Testen reicht es aus temporär den Dienst zu starten:
`wg-quick up /etc/wireguard/wg0.conf`

Wollen wir den Dienst bei jedem Systemstart aktivieren, geben wir ein:  
`sudo systemctl enable wg-quick@wg0.service`

Zum Kontrollieren ob alles läuft geben wir ein:  
`systemctl status wg-quick@wg0.service`
