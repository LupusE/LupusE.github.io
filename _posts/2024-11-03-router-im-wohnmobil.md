---
status: published
published: true
layout: post
title: SpitzAX - Router im Wohnmobil
author: Benjamin Moeller
date: 2024-11-03 07:35:32 UTC
categories: [Wohnmobil]
tags: [dogliner, spitz ax, GL-X3000]
comments: []
---

Vor ein paar Monaten habe ich mit der Firma [GL.iNet](https://www.gl-inet.com/) an einer Verbesserung des Marketing gearbeitet. Als Kompensation gab es Rabatt auf einen [Spitz AX (GL-X3000)](https://www.gl-inet.com/products/gl-x3000/).  
Diesen Router hatte ich schon länger ins Auge gefasst, aber 400 Euro sind mir einfach zu viel Geld, auch wenn vergleichbare Produkte anderer Hersteller mehr kosten. Daher kam mir der Rabatt entgegen.  

## Der Router

Der Router bietet 2+4 (2x Wifi6 (PR-SMA), 4x 5G (SMA)) Buchsen. Es werden passende Antennen mitgeliefert, durch die schraubbaren Antennen kann, ohne am Router zu basteln, ein Dome oder andere Aussenantenne genutzt werden. Siehe Produktseite.  

Er bietet 2 SIM Slots, mit automatischen Failover (wenn ein Anbieter nicht erreichbar ist, springt er zur zweiten Karte) oder manuellen Umschalten (9-17h Firmen Datenkarte, ansonsten die private Datenkarte). Anstelle von 2 SIM-Karten kann als Failover eine SIM Karte zusätzlich zum WLAN des Campingplatz genutzt werden, oder andersrum. Die Konfigurationsmöglichkeiten sind vielfältig. Dank MIMO kann die gesamte Sende/Empfangsleistung für beste Anbindung genutzt werden, oder die Antennen tleilen sich das externe und interne Netz auf. Voll atomatisch.  

Wie alle GL.iNet Router bietet er VPN Unterstützung zu mehr als 30 Anbieter. Ich selbst nutze nur mein Heimnetzwerk als Gegenstelle, mit einem zusätzlichen GL.iNet Router zuhause.  

Das Betriebssystem läuft auf Basis von OpenWrt, die nicht properitären Teile sind als Opensource verfügbar und können angepasst werden. Sicherheitslücken werden im Backport gepatched und offen kommuniziert.  

### Features
- WLAN mit den Standards a/b/g/n/ac/ax (Wifi6)
- 512 GB RAM und 8 GB Speicher, also ausreichend Platz für Erweiterungen
- RJ45 WAN mit bis zu 2,5Gbps, falls man doch einmal im Ferienhaus mit Glasfaster ist
- RJ45 LAN mit bis zu 1000Mbps um einen Laptop ohne WLAN zu versorgen
- Micro SD Karten Slot for bis zu 1 TB zusätzlichen Speicher
- 5 diskrete Status LED (Power, 5G Wifi, 2,4G Wifi, Internet, Mobile Signalstärke)

- Stromstecker: DC5521, 12V/2.5A (5.5*2.1mm)
- Stromverbrauch: < 14 W


## Der Einbau

### Vorgeschichte

Ich habe meinem Kontakt bei GL.iNet versprochen Photos vom Einbau zu schicken. Leider kam einiges dazwischen, so verzögerte sich der Einbau von Woche zu Woche.  
Dann kam der Tag, an dem ich auf eine Firmenveranstaltung musste und kein Zimmer mehr frei war. Also fuhr ich mit dem Wohnmobil und meine Frau kam mit. Endlich wollte ich den Router einbauen, damit die in der Zwischenzeit streamen kann.  
Es war kalt, ich war müde, ich bastelte am Strom rum. Also Panel auf, ich entschied mich den vorhandenen Anschluss des TV abzugreifen, den wir nur selten benutzen. Der hat eine 5A Sicherung, perfekt. Kabel verbunden, alles wieder zu gemacht und Router angeschlossen. Ein kurzes grün und aus. Verdammt. Aber es war auch deulich leiser als vorher. Der halbe Wohnbereich war aus, keine Heizung, kein Kühlschrank, kein TV ... Verdammt! Ich wollte meiner Frau nicht erzählen dass wir mirgen losfahren und sie keine Heizung hat. Es war immernoch kalt, aber die Müdigkeit war dem Adrenalin gewichen ...  

Nach einigem Messen und Suchen habe ich unter dem Fahrersitz, im Elektroblock, die passende Sicherung gefunden und die war durch. Also gegen eine neue 10A Sicherung getauscht und zumindest der Wohnbereich war wieder hergestellt.  
Noch etwas genervt und wieder müde habe ich dem GL.iNet Kontakt geschrieben dass sich aus diesem Grund die Dokumentation noch etwas verschiebt.  

Womit ich nicht gerechnet habe:  
Auf der anderen Seite der Erde hat er seinen Technikern davon erzält und die meinten das ist typisch bei einer falschen Polung.  
In der Tat habe ich das Kabel aus meiner Restekiste und es war nicht beschriftet. Ich habe Plus- und Minuspol geraten ... Verdammt!

### Der richtige Einbau

Letztes Wochennende war es dann so weit, ich war ausgeschlafen und habe viel gelernt.  

Zunächst wird nachgemessen wie die echte Polaität am original Netzteil ist. Einfach in die Steckdose und ein Voltmeter anschliessen.  
![Kontrollmessung mit GL.iNet original Netzteil](/media/router_spitzax_rv/router_spitzax_rv_1.JPG)

Der Pluspol ist innen, 12,2 V. Nichts überraschendes.  

In der Regel gibt es hinter dem Kontrollfeld genügend Anschlüsse. Bei uns ist das große graue Feld einfach nur eingeclipt und kann ohne Werkzeug abgezogen werden.  

![Das Kontrollfeld am Eingang](/media/router_spitzax_rv/router_spitzax_rv_2.JPG)

Und so sieht es geöffnet aus  
![Das Kontrollfeld offen](/media/router_spitzax_rv/router_spitzax_rv_3.JPG)

Am unteren Rannd sehen wir einen grauen Klotz mit einer Halterung für eine Glassicherung. Hier ist der Fernseher angeschlossen. Vertrauen ist gut, Kontrolle muss sein!  

![13,2V, das ist unser Anschlusspunkt](/media/router_spitzax_rv/router_spitzax_rv_4.JPG)

Und weil ich die Erfahung bereits gemacht habe, vor dem Zusammenbau wird nochmal direkt am Stecker gemessen. 13,2V am Stecker, Pluspol in der Mitte, perfekt.  

![13,2V am Stecker, Pluspol in der Mitte](/media/router_spitzax_rv/router_spitzax_rv_5.JPG)

Es ist an dieser Stelle auch nicht schlimm dass das Voldmeter am original Netzteil 12,2 V und am Wohnmobil 13,2 V anzeigt. Der SpitzAX ist nach Datenblatt für 9-36 Volt ausgelegt.  
Wohnmobil Batterien geben in der Regel eine Spannung von 13-14V ab, dieser Router kann mit der Schwankung also umgehen.  

... und fertig!!  
![SpitzAX im Wohnmobil](/media/router_spitzax_rv/router_spitzax_rv_6.JPG)


Leider habe ich über ide Zeit meine Montageplatte verlegt. Damit wird der Router noch an die Wand geklebt.  
Der SpitzAX selbst ist recht kompakt. Grüßer als die anderen Reiserouter, aber er kann auch deutlich mehr. Mit dne Antennen ist er sehr mächtig.  
Auch wnen es verlockend ist die Antennen um 90° zu winkeln und an dem Dach lang zu führen, für die besten Empfangswerte sollten die Antennen vertikal stehen, nicht horizontal.  
Die Wellen breiten sich omnidirektional vom Sender aus, je paralleler die Antennen stehen desto besser. Zum Glück ist es egal ob nach oben oder unten zeigend.  


Jetzt werde ich es ein paar Fahrten testen und weiter berichten.  
