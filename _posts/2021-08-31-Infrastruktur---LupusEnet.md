---
status: published
published: true
title: Infrastruktur - LupusEnet
author: Benjamin Moeller
date: 2021-08-31 20:07:13 UTC
categories: [infrastruktur]
tags: [infrastruktur]
comments: []
---

# Was ist LupusEnet?
Wie ich zuvor schrieb, nenne ich mich LupusE im internet. Dabei gehören mir die Domains LupusE.de .net .com und .org  
Die Domain LupusE.de wurde irgendwie die Hauptdomain für Kommunikation  
Die Domain LupusE.org war shcon immer eine Spielwiese  
**Die Domain LupusE.net ist mein Heimnetz**  
Die Domain LupusE.com ist irgendwie ueberflüssig  

## Server
Als Server kommt bei mir ein Proxmox Host zum Einsatz. 
Ich hatte zuvor einen Aufbau mit VMWare, aber die Netzwerkkarten wurden nicht nativ unterstützt, daher war es mir zu viel gefrickel, spätestens im Falle eines Upgrades. Auch hatte ich kurzzeitig Kubernetes über Ubuntu Snaps im Einsatz, aber hier reichten die 12GB RAM nicht aus um sinnvoll Guests laufen zu lassen.  
Proxmox bietet in der Community Version alles was man für ein paar Guests benötigt. Basierend auf Debian Linux läuft es zuverlässig. Und von einer einfachen Plattform bis zur HA Lösung ist alles möglich.

## Router
Lange Zeit hat mich sehr genervt, dass die Fritz!Box als Domain nur fritz.box verteilt, ich habe keine Möglichkeit eine eigenen interne Domain zu vergeben. Also habe ich mit verschiedenen Lösungen gespielt, zuletzt OPNsense.  
OPNsense ist eine auf einem hardened OpenBSD basierende Firewall Appliance, wleche von Projekten wie 'MusterLinux' genutzt wird. Wie jeder Plasterouter bietet es DHCP, Filter, Logs, DNS ... Funktioniert, braucht sehr viel Gedult und einiges an Netzwerkwissen.  

# Umbruch - back to the (Fritz!)Box
Die Komplexität tat meinem Netzwerk nicht gut. So schön es auch war mit den Komponenten zu spielen, aber ich habe es nie in den eGriff bekommen, dass das ganze Netzwerk stillsteht, beim Kopieren größerer Dateien von meinem Desktop auf das NAS.

## Aktuell
Eine Fritz!Box 7590 werkelt nun als zentrale Anlaufstelle für das Internet und Telefonie. Per DLAN (PowerLine) ist ein im ersten Stock eine Fritz!Box 7490 angeschlossen, die beiden sprechen im Mesh miteinander.  
Der HP Desktop-Server hat sich die meiste Zeit gelangweilt. Dafür war der Stromverbrauch zu hoch. Als neuer Proxmox Host kommt ein Rechner im passiv gekülten Industriegeäuse zum Einsatz. Es war einfach die SSD aus dem Server auszubauen und in die Box einzusetzen. Als Speicher stehen im eigenen Gehäuse 8TB im QNAP NAS bereit.  
