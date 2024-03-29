---
status: published
published: true
layout: post
title: quick-and-dirty Pseudosicherheit und Netzwerkanalyse
author: Benjamin Moeller
date: 2007-04-07 11:20:11 UTC
categories: [howto]
tags: [qnd, linux, analyse, nerdig]
comments: []
---

Kuerzlich verfolgte ich eine Diskussion im IRC, in der diskutiert wurde 'Ein negativer Ping sagt genauso wenig aus, wie ein positiver'. Das ist (so, wie ich das sehe) nicht ganz richtig, denn ein Ping ist immer noch ein brauchbares Analysetool.  

> lupus@zoe:~$ ping -c4 eva5.lupuse.net  
> PING eva5.lupuse.net (192.168.0.1) 56(84) bytes of data.  
> 64 bytes from eva5.lupuse.net: icmp_seq=1 ttl=255 time=0.455 ms  
> 64 bytes from eva5.lupuse.net: icmp_seq=2 ttl=255 time=0.392 ms  
> 64 bytes from eva5.lupuse.net: icmp_seq=3 ttl=255 time=0.396 ms  
> 64 bytes from eva5.lupuse.net: icmp_seq=4 ttl=255 time=0.393 ms  
> --- eva5.lupuse.net ping statistics ---  
> 4 packets transmitted, 4 received, 0% packet loss, time 2998ms  
> rtt min/avg/max/mdev = 0.392/0.409/0.455/0.026 ms  

Hier sehen wir einen positiven Ping. Also ich pinge meinen Router, der gibt mir eine Antwort. Zusaetzlich sehe ich eine Statistik (Groesse des Paketes, Host, laufende Nummerierung, time-to-live, Zeit von Anfrage bis Antwort).

> lupus@zoe:~$ ping -c4 pontus.lupuse.net  
> PING pontus.lupuse.net (192.168.0.2) 56(84) bytes of data.  
> From zoe.lupuse.net icmp_seq=1 Destination Host Unreachable  
> From zoe.lupuse.net icmp_seq=2 Destination Host Unreachable  
> From zoe.lupuse.net icmp_seq=3 Destination Host Unreachable  
> From zoe.lupuse.net icmp_seq=4 Destination Host Unreachable  
> --- pontus.lupuse.net ping statistics ---  
> 4 packets transmitted, 0 received, +4 errors, 100% packet loss, time 3009ms, pipe 3  

Das Ganze in negativ, Wir sehen nur, VON wem die Anfrage gesendet wird, NICHT das Ziel.  

Im Detail wird das ganze Protokoll besprochen unter [RFC 792 - Internet Control Message Protocol (ICMP)](http://www.faqs.org/frcs/rfc792.html)  


#### Was hat das ganze nun mit Netzwerkanalyse zu tun?
Recht einfach, denn immer mehr Personen ohne Ahnung versuchen ihr System im 'Stealthmode' (d.h. es werden ungueltige Anfragen nicht REJECTED (mit Fehler quittiert), sondern GEDROPT (ohne Rueckmeldung verworfen), und ICMP komplett ignoriert. So dass man die Moeglichkeit hat auf Services und Deamonen (ident, smtp, http, ...) zu nutzen, aber nicht zu schauen ob der Rechner generell ansprechbar ist.  

Man kommt in ein fremdes LAN, die Fehlermeldung ist 'Rechner xyz.lan.net ist nicht erreichbar' und als erstes startet man einen Ping, der natuerlich negativ ausfaellt, da der vorige 'gut befreundete Computerexperte' die IPTABLES entsprechend in Stealth geschaltet hat.  
Nundenn, ab hier wird es philosophisch. Denn der gut trainierte Turnschuhadmin rennt zum Rechner um festzustellen 'der Funktioniert und hat gutes Netz'. Der untrainierte Turnschuhadmin mit Erfahrung informiert sich ueber die Services, die laufen und versucht (Fall http Server) ein `nmap -P0 -p80 xyz.lan.net`, damit er vom Port80 ueber TCP/IP eine Reaktion des Rechners bekommt. Funktioniert unter Umstaenden sogar, wenn der Service selber nicht funktioniert, weil z.B: der Apache sich weggehaengt hat (-> siehe auch `man nmap`).  

--- to be continued ---  

Ein Appell: Kein unbedachten Stealthmode schalten! Ein Rechner stellt im Netz einen Service, und sollte dann auch erreichbar sein.  
Sinnig ist es Pakete Zu DROPEN, wenn man z.B: eine [Teergrube](http://de.wikipedia.org/wiki/Teergrube_(Informationstechnik)) baut. Dazu aber ein anderes Mal mehr.

Fragen, Anregungen und konstruktive Kritik sind hier willkommen!
