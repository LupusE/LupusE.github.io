---
status: published
published: true
layout: post
title: LXC - Erste Fortschritte
author: Benjamin Moeller
date: 2019-03-24 20:02:42 UTC
categories: [howto]
tags: [server, lxd, linux]
comments: []
---

# Warum LXC?
Der meist zitierte Vorteil von LXC ist womöglich, dass es sehr Hardwarenah arbeitet und durch den geringen Overhead (man spricht von gerade mal 7%) eine sehr hohe Dichte mitbringt.  
Das heißt mehr Leistung auf der VM pro Hardware. Die Leistung wird nicht mehr vom Hostmanagement gefressen.

Nachdem ich einige Tests mit conjure gegen die Wand gefahren habe, weis ich nun, dass 8 GB Arbeitsspeicher nicht ausreichend sind. Damit ist conjure auf Eis gelegt.

## Ubuntu Server aufsetzen
Ubuntu steuert ganz klar in die Cloud. Und anstelle von `apt` wird auch `snap` bevorzugt. Ob ich das gut finde wird sich noch zeigen.
1. Image herunterladen
2. mit dd auf einen USB Stick kopieren
3. vom USB Stick booten
4. Installation durchlaufen lassen
5. Bei der Frage nach den Komponenten alles deaktivieren
6. `sudo apt purge lxd lxd-client`
7. `snap install lxd`

## LXC einrichten
Mit `$ sudo lxc init` erhalten wir einen Dialog, in dem wir die wichtigsten Parameter für ein Grundsystem angeben können. Soll später auf Docker/OpenStack gebaut werden, sollte `IPv6` ausgeschaltet sein. Auch das Filesystem muss in den Fall auf `dir` konfiguriert werden.

Die danach erstellten VMs haben direkt Zugriff auf das Internet. Damit sie auch von außen erreichbar sind, habe ich eine Netzwerkbrücke eingerichtet.

# Status
Es gibt eine VM, welche mittels ssh (PubKey) erreichbar ist. Jetzt räume ich noch etwas auf und schreibe dann wie die Infrastruktur aufgebaut ist.
