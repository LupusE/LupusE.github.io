---
status: published
published: true
layout: post
title: LXC - Lokal virtualisieren
author: Benjamin Moeller
date: 2019-03-31 20:10:13 UTC
categories: [howto]
tags: [server, lxd, linux]
comments: []
---

Manchmal will man schnell etwas installieren, ohne das komplette System zu zerlegen.
Ein sehr guter [Blog Artikel](https://blog.simos.info/how-to-easily-run-graphics-accelerated-gui-apps-in-lxd-containers-on-your-ubuntu-desktop/) zum Thema.

# Snap/LXC installieren
1. Neuere Version (3.x) gibt es über snap `# apt install snapd`
1. Alte Version deinstallieren, neue installieren `# apt purge lxd; snap install lxd`
1. `# adduser [benutzer] lxd`
1. LXC einrichten `# lxc init`
1. Pool als **dir** definieren. Kein IPv6, wenn nicht absolut notwendig.
1. Rechte setzen `$ echo "root:$UID:1" | sudo tee -a /etc/subuid /etc/subgid`
1. `wget https://LupusE.github.io/misc/lxdguiprofile.txt`
1. Profil anlegen `$ cat lxdguiprofile.txt | lxc profile edit gui`
1. VM erstellen `$ lxc launch --profile default --profile gui ubuntu:trusty oldbuntu`
1. In VM einloggen `$ lxc exec oldbuntu -- sudo --user ubuntu --login`


# Aufräumen
1. VM verlassen `$ exit`
1. VM beenden `$ lxc stop oldbuntu`
1. VM löschen `$ lxc delete oldbuntu`

