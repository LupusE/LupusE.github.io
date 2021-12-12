---
status: published
published: true
title: quick-and-dirty - IPTables meets WM61 II
author: Benjamin Moeller
date: 2009-07-22 05:09:21 UTC
categories: [QuickAndDirty]
tags: [cnf, linux, qnd]
comments: []
---

Und heute wollen wir ein Windows Mobile 6.1 ueber Linux ins Internet bringen.  

```
# echo 1 > /proc/sys/net/ipv4/ip_forward  
# iptables --table nat --append POSTROUTING --out-interface ath0 -j MASQUERADE  
# iptables --append FORWARD --in-interface rndis0 -j ACCEPT  
```

Dem aufmerksamen Leser wird auffallen, dass diese Aktion nur medium Sinn macht. Denn ich leite den Traffic von USB (rndis0) auf WLAN (ath0). Der XDA OrbitII könnte direkt per WLAN in das Internet ... Egal, es geht ums Prinzip.  

## [Edit]
Aufgrund des regen Feedbacks zu dem Thema ein kleines Update:
Damit das Forwarding funktioniert muss  die synce-sync-engine laufen. Denn ohne ActiveSync ist dem Telefon nicht bekannt, dass die Daten über USB kommen.  
Unter Ubuntu macht das HAL, unter Debian in einem Terminal einfach `synce-sync-engine &` eingeben.  

