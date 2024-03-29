---
status: published
published: true
layout: post
title: Wohnmobilnetzwerk - Gl.iNet Beryl
author: Benjamin Moeller
date: 2022-05-15 16:24:00 UTC
categories: [wohnmobil]
tags: [reise, netzwerk, router]
comments: []
---

# tl;dr

Ich hatte erwartet hier wird ein grossartiges Projekt entstehen. Leider funktioniert die Lösung so gut, dass es nicht viel zu beschreiben gibt.
1. gl.iNet Router in gewünschter Ausstattung (und Preis) kaufen: [Gl.iNet Produkte](https://www.gl-inet.com/products/)
2. An Strom anschliessen, mit warten bis die Lampe durchgehend leuchtet
3. Mit den Daten auf der Unterseite anmelden
4. 'Internet' per Kabel, WLAN oder Tethering/USB Modem bereitstellen (siehe unten)
5. Fertig

Dabei gibt es folgende Wege für das Internet:
- Kabel an den Netzwerkport WAN anschliessen. Am einfachsten, gut zum ersten Einrichten, aber selten sinnvoll beim Camping.
- WLAN Bridge. Unter **Internet** **Repeater** den Button **Scan** klicken, das entsprechende WLAN auswählen, das Passwort eingeben und **Join**/Beitreten klicken. (siehe 'Tipp'). Das Mittel der Wahl auf dem Campinglplatz, in Kombination mit VPN auch für öffentliche WLAN.
- USB-Tethering. An den USB Port ein Mobiltelefon oder Tablet mit Internet anschliessen, am Telefon/Tablet 'Tethering' freigeben. Für alle Fans des 100% autarken Camping.
- USB-Modem. Noch nicht getestet.

> TIPP: In der aktuellsten Firmware (3.211) gibt es anscheinend 2 Bugs. Der eine betrifft die gesetze Zeit, welche unter Umständen das Verbinden zu WLAN mit Key verhindert. An diesem [arbeitet Gl.iNet anscheinend gerade](https://forum.gl-inet.com/t/20556) und vermutlich ist es in der aktuellen Beta behoben. Zum Anderen scheint es ein nicht näher beschriebenes [Problem mit Fritz!Boxen](https://forum.gl-inet.com/t/gl-inet-router-says-wrong-key-on-wifi-repeater-join/20556/37) zu geben, wegen dem man auf der Firmwareversion 3.203 bleiben sollte.  

--- 


# Vorgeschichte

Heutzutage benötigt man Internet, auch im Urlaub. Nicht nur als Roadwarrior (arbeiten von Unterwegs), auch um Up-to-Date zu bleiben oder Urlaubsphotos zu posten. Vielleicht möchte man am Abend ein Video oder Musik streamen. Und wenn Kinder ab einem gewissen Alter mit reisen, dann ist das Internet unterwegs nicht mehr optional.  

Für Wohnmobile werden unterschiedliche Systeme angeboten und in Fachliteratur getestet:  
* Zum Einen gibt es Pocketrouter ('Mobile Ostereier') für 40-150 Euro. Diese werden oft mit einer billigen SIM-Karte, meist PrePaid, betrieben und sind durch den internen Akku auch ausserhalb der Wohnmobils flexibel. Aber diese Lösung ist auf das Mobilfunk-Netz angewiesen. Nachdem was ich weis eher für den gelegentlichen Ein-Personen-Gebrauch eines Tablet/Notebook. Im Ausland kann man einfach eine lokale Karte kaufen und einsetzen. Roaming sollte innerhalb der EU kein Thema mehr sein. Die Systeme gibt es im Angebot von TCM (Tchibo) oder AldiTalk. Dies machen Sinn um autark zu stehen, in Kombination mit meiner beschriebenen Lösung.  
* Zum Anderen gibt es, oft aus dem Bootsbereich, mehr oder weniger klobige Boxen, fest montiert auf dem Dach. Diese bieten deutlich mehr Leistung und mehr Anbindung, z.B. Mobilfunk und WLAN vom Campingplatz. Für 300-900 Euro oder mehr. Bald kommt 5G und ich habe von keinem Gerät gelesen, welches sich 'einfach' aufrüsten lässt. Auch ein Faktor: Meine Frau möchte keine zusätzlichen Löcher in ihr Wohnmobil gebohrt haben.  
* Dazwischen gibt es um die 200-400 Euro noch ein paar portable Lösungen, die sicher auch funktionieren. Oft leiden diese unter einem oder mehr Nachteile der vorgenannten Lösungen, aber einige bieten eine sehr gute Übersicht über den aktuellen Datenverbrauch. Die bekanntesten dieser Klasse sind wohl die [Netgear Hotspot](https://www.netgear.com/de/home/mobile-wifi/hotspots/) Modelle.  

Ich war auf der Suche nach einem kleinen, flexiblen und günstigen Router, der mir im Wohnmobil ein gutes Netzwerk gibt und auch kaputt gehen darf, ohne dass es weh tut.

## Recherche

Vor einigen Wochen habe ich einen Microrouter der Firma [Gl.iNet](https://www.gl-inet.com/) gesehen. Der GL-AR300M-Ext ist eine kleine Box für etwa 32 Euro auf Amazon, mit zwei austauschbaren Antennen. Die Box stellt eine sogenante 'Bridge', übersetzt also ein gegebenes Netzwerk in ein eigenes (Network Adress Translation/NAT). Wie das Internet zuhause mit einem Router in das Heimnetzwerk gewandelt wird. Das bedeutet ich kann entweder ein WLAN aufnehmen und das über den LAN Port weiter geben (Laptop ohne WLAN-Karte) oder ich kann ein LAN an die Box anschliessen und ein eigenes WLAN zur Verfügung stellen.

> Zu kompliziert? Kurz: Ich kann alles in mein eigenes WLAN übersetzen.  

Interessant für uns Camper: Durch mehrere Antennen kann ich mit geringem Verlust ein externes WLAN (Campingplatz) aufnehmen und daraus ein eigenes lokales WLAN für alle Geräte in der Nähe bereitstellen. Für das Wohnzimmer auf Rädern perfekt. Durch tauschbaren Antennen könnte ich, ohne die Leistung physikalisch zu ändern, vollkommen legal mehr Reichweite durch Richtwirkung erhalten.  
Die Firma Gl.iNet (Gl steht für Goodlife) kommt aus China, wo das Privatleben im Internet eine ganz andere Gewichtung hat. Also stellt die Box zusätzlich noch ein VPN als Client oder Server zur Verfügung. Das ist für uns nicht ganz so wichtig, aber es ist eine zentrale Funktion und sehr gut umgesetzt, dazu in einem später mehr.  

Als Informatiker habe ich mir das Datenblatt angesehen und so richtig hat es mich doch nicht überzeugt. Was bieten die anderen Modelle des Herstellers?  
* [GL-AR300M](https://www.gl-inet.com/products/gl-ar300m/) (Shadow)/[GL-MT300N-V2](https://www.gl-inet.com/products/gl-mt300n-v2/) (Mango) sind kleine günstige Boxen, mit verschiedener Ausstattung. Vergleichbar mit der zuerst erwähnten.
* Die [GL-AR750S](https://www.gl-inet.com/products/gl-ar750s/) (Slate) hat einen deutlich stärkeren Prozessor und mehr RAM (Arbeitsspeicher) und sollte für die meisten Anwendungen im Wohnmobil ausreichen. Stromverbrauch <6W laut Datenblatt. Für 75 Euro okay.
* Der [GL-MV1000W](https://www.gl-inet.com/products/gl-mv1000/) (Brumme-W), derzeit nicht verfügbar.
* Der [GL-SFT1200](https://www.gl-inet.com/products/gl-sft1200/) (Opal) hat einen geringen Strombedarf (2A Netzteil), bei der Unterstützung moderner WLAN-Protokolle und einem schnellen Prozessor. Für unter 50 Euro auch erschwinglich. 2 feste WLAN Antennen. Preis-/Leistungssieger.  
* Der [GL-MT1300](https://www.gl-inet.com/products/gl-mt1300/) (Beryl) ist es bei mir geworden, da es das einzige Modell ist, welches zu dem Zeitpunkt bei Auslieferung IPv6 spricht. Ein Feature, welches den meisten Wohnmobilisten recht egal sein dürfte, mir aber besonders wichtig war. Für fast 80 Euro dann hart an der Grenze zum 'mal kaufen und schauen was daraus wird'. Wie zuvor auch nur mit festen WLAN Antennen.

Alle diese Lösungen haben keine SIM-Karte, sind aber einfach mittels USB-Modem oder USB-Tethering mit der derzeit aktuellen oder erschwinglichen Technik auszustatten.

### Vergleichstabelle

| Bezeichnung (Name) | CPU | RAM | Speicher | WLAN | USB | Ethernet | Micro SD | IPv6 | Power
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| GL-AR300M-Ext (Shadow) | QC9531 @650MHz | DDR2 128MB | 16MB | 300Mbps (2,4GHz) | 1x 2.0 | 2x 10/100 | Nein | Nein | 5V/1A USB-C (<2W)
| GL-MT300N (Mango) | MT7628NN @580MHz | DDR2 128MB | 16MB | 300Mbps (2,4GHz) | 1x 2.0 | 2x 10/100 | Nein | Nein | 5V/1A USB-C (<2,75W)
| GL-AR750S (Slate) | QCA9563 @775MHz | DDR2 128MB | 16MB/128MB NAND | 300Mbps (2,4GHz), 433Mbps (5GHz) | 1x 2.0 | 3x 1GB | max 128GB | Nein | 5V/2A USB-C (<6W)
| GL-MT1300 (Beryl) | MT7621 @880MHz | DDR3L 256MB | 32MB | 400Mbps (2,4GHz), 867Mbps (5GHz) | 1x 3.0 | 3x 1GB | max. 512GB | Ja | 5V/3A USB-C (<8,65W)
| GL-SFT1200 (Opal) | SF19A28 @1GHz | DDR3 128MB | SPI NAND 128MB | 300Mbps (2,4GHz), 867Mbps (5GHz) | 1x 2.0 | 3x 1GB | Nein | Ja | 5V/3A USB-C


## Meine Lösung: Gl.iNet GL-MT1300 (Beryl)

Er ist der teuerste der untersuchten Modelle. Meine Entscheidung hat besonders die Unterstützung von IPv6 und der Einsatz einer SD Karte beeinflusst. Wem das nicht wichtig ist, der wird mit dem GL-SFT1200 (Opal) 30 Euro günstiger weg kommen. Wem bisher nur stört, dass das Android Telefon/Tablet kein WLAN-WLAN Tethering kann, der kann die deutlich günstigeren Shadow/Mango Boxen in Betracht ziehen.  
Den Beryl kann ich mit einer bis zu 512GB großen SD Karte füttern und per FTP Daten oder per DLNA Medien bereitstellen. Unser Fernseher im Wohnmobil ist nicht smart, das wäre für mich der einzig sinnvolle Einsatz. Aber vielleicht spiele ich mit dem Chromecast rum. Ich werde berichten...  

Zunächst fragte ich mich, warum er nach Spezifikation unbedingt ein 5V/3A Netzteil verlangt, obwohl der Verbrauch mit <8,65W angegeben ist (8,65W/5V=1,75A). Beim Testen ging mir dann ein 15 Watt Licht auf. Ein Mobiltelefon am USB Port will ja auch mit Strom versorgt werden. Wenn dieses 2,1A zieht, dann hat das Board nicht mehr genügend Strom.  
Tethering = Mobilfunk oder WLAN vom Mobiltelefon/Tablet weitergeleitet. Meist über USB.  

Die Kaufentscheidung hängt ab von:
- Binde ich das Gerät ins WLAN, per Kabel ein oder Tethering? Oder will ich flexibel alle Möglichkeiten haben?  
- Wie viel Strom habe ich zur Verfügung? Bei 3A muss ich mir Gedanken machen, während ich bis 2,1A einfach an (fast) jedem USB Port betreiben kann. Brandgefahr bei Missachtung!  
- Will ich jetzt oder später Medien per DLNA im Wohnmobil bereitstellen? (MicroSD Slot, genug CPU/RAM)  
- Will ich daraus noch weitere DIY Projekte bauen? Dann sollte die Box GPIO Pins bieten, um z.B. den TIN Bus der Truma auszulesen?  
- IPv6 wird allgemein weniger eine Rolle spielen, da es über OpenWRT sicher nachgereicht wird, sobald es salonfähig ist.  
- Wenn ich VPN und andere Dienste zeitgleich nutzen will muss, muss ich zusätzlich auf MHz und RAM achten.  

Die Größe des Wohnmobil/-wagen spielt kaum eine Rolle, bis 12m Länge sollte es problemlos im 5GHz Band auszuleuchten sein. Wichtiger ist die Außenwand. Ein Kastenwagen mit Metallchassis dämpft den Empfang deutlich mehr als die GFK Wand eines Aufbau. Die kleinen Boxen kann man sehr gut fensternah verstauen.  

### Ersteinrichtung (Kabel)

Ich habe den Luxus, dass mein Wohnmobil direkt vor der Tür steht. Das bedeutet ich konnte so tun als wäre mein Haus-WLAN ein Campingplatz. Aber bevor ich raus gegangen bin, habe ich die kleine Box an meinem Schreibtisch ausgiebig getestet.  

Die Ersteinrichtung war super einfach:
* Auspacken, Strom dran, LAN an Laptop, warten bis die LED dauerhaft leuchtet
* Browser öffnen und auf [http://192.168.8.1](http://192.168.8.1) gehen
* Beim ersten Login Sprache einstellen und Adminpasswort vergeben

* In der Weboberfläche auf **Wireless**/Kabellos
* Zuerst habe ich das WLAN umbenannt (SSID) in LupusEmobi24 und LupusEmobi5 und einen eigenen Key vergeben. Dei GastWLAN habe ich ausgeschaltet gelassen.
  * Tipp: Man kann auch den gleichen Namen (SSID) und Key wie zuhause verwenden, dann können sich alle Geräte (z.B. Xbox/Playstation/Switch) auch unterwegs mit den gleichen Daten anmelden. Das geht nicht zum lokalen Testen.  
  * Auf gar keinen Fall die Standardeinstellungen lassen. Wer als SSID 'GL-...' sieht, wird gleich das Kennwort 'goodlife' versuchen. Wird nur die SSID umbenannt, könnte anhand der MAC Adresse ein Gl.iNet Gerät identifiziert werden.
![Browser Wireless](/media/router_beryl/browser_beryl_wireless.png)

Wer plant eine Fritz!Box einzusetzen, NICHT upgraden! Es gibt einen nicht näher beschriebenen Bug in der aktuellen Firmware. Gl.iNet arbeitet wohl dran. Leider ist genau dieser Teil der Software (Netzwerktreiber) Closed Source. Aber die Gute Nachricht: Bis Firmware 3.203 funktioniert es. [Quelle](https://forum.gl-inet.com/t/gl-inet-router-says-wrong-key-on-wifi-repeater-join/20556/34)  
Ein Firmwareupdate (3.211) ist verfügbar. Über den Menüpunkt links **Upgrade**/Aktualisierung hat die Box auf Buttonklick das Image aus dem Internet geladen und auf weiterem Klick installiert.  
Möchte man ein Downgrade (Letzte Version installieren), dann geht das nicht automatisch, aber auch einfach: Das Image von der Webseite herunteladen und im nächsten Reiter (Local Upgrade/lokale Aktualisierung) auf den Router hochladen, der Rest ist gleich.  

Vor der Installation hat man die Möglichkeit auszuwählen 'Keep Settings'/Einstellungen beibehalten und 'Keep installed Packages'/Installierte Pakete behalten. Aktuell wähle ich diese Optionen ab, da mit einem Firmwareupdate neue und verbesserte Funktionen und unter Umständen auch geänderte Konfigurationen kommen. Wenn der Router ein paar Monate läuft und einige individuelle Konfigurationen zusammen kommen, dann kann man die Einstellung übernehmen. Der Versionssprung sollte dabei nicht zu gross werden. Auf jeden Fall vorher eine Sicherung machen, falls das Update beim Übernehmen der Daten fehlschlägt.  

![Browser Upgrade](/media/router_beryl/browser_beryl_upgrade.png)

> TIPP: Ich habe ein Notebook für solche Aufgaben, aber manchmal hat man nur ein Mobiltelefon oder Tablet zur Verfügung. Anstelle eines Kabel kann man sich auch direkt per WLAN verbinden.  
> Mit dem unter der Box aufgedruckten WLAN verbinden. Entweder GL-MT1300-xxx (2,4GHz) oder GL-MT1300-xxx-5G (5GHz). Der Key ist immer 'goodlife'. Bei anderen Modellen ist die SSID ähnlich: GL-[Modellnummer]-[Letzten 3 Zeichen der MAC].  

### Einrichtung (WLAN zu WLAN)

Nach dem grundlegenden Einrichten bekam das Gerät im Menü links unter **Internet** die Zugangsdaten zu meinem Heim-WLAN. Fertig.

![Browser Internet](/media/router_beryl/browser_beryl_internet.png)

Ich nutze vom Endgerät (Handy/Tablet) das 5GHz Netz, weil ich meist WLAN auf WLAN haben möchte.  
Das 2,4GHz Netz hat die bessere Reichweite, das 5GHz Netz hat den besseren Durchsatz. Reichweite benötige ich auf 2,33mx7,40m nicht, aber draussen. Wenn ich innen und außen auf jeweils einem anderen Band funke, sorge ich gleichzeitig für weniger Störungen untereinander.  


### Feintuning (Tethering)

Im Menupunkt **Internet** ist die Option **Tethering** ausgegraut.  
Wenn ein Android Telefon an ein System angeschlossen wird, dann steht im Drop-Down (vom oberen Bildschirmrand nach unten ziehen) 'Android-System - Gerät wird über USB aufgeladen / Für weitere Optionen tippen)', tippe ich da drauf komm eich in 'USB-Einstellungen' und kann 'USB-Tethering' (neben z.B. 'Dateiübertragung') auswählen. Ab sofort kann ich **Tethering** in der Box auswählen.  
USB-Tethering bedeutet, dass das Mobiltelefon die vorhandene Internetverbindung über den USB Port zur Verfügung stellt. Dabei interessiert dem Gerät am USB Port nicht ob es sich um eine WLAN oder Mobilfunkverbindung handelt. Sollte ich also ein Mobiltelefon mit sehr guter WLAN-Antenne besitzen, kann ich sogar ganz auf ein WLAN Modul im Router verzichten. Dabei gilt aber zu beachten, dass in dem Fall auch immer 2 Geräte mit Strom versorgt werden müssen.  

In unserem Fall hat meine Frau ihr altes [Sony Xperia Z3 Compact](https://de.wikipedia.org/wiki/Sony_Xperia_Z3_Compact) zur Verfügung gestellt. Wir haben bei O2 eine Datenkarte zu ihrem Vertrag bestellt, da sie Europaweit 120GB LTE Datenvolumen pro Monat hat, ohne Telefonie.  

Die Box kann auch direkt mit Linuxfähigen USB-Modems umgehen. Dabei empfiehlt es sich bei den meisten Systemen die PIN der Datenkarte zu deaktivieren. Da ich nur einen 3G Stick (Huawai E1750) mit anderer SIM-Größe hier habe, habe ich es noch nicht getestet.  

---


# Technisch

Die Box besitzt eine OpenWRT Firmware mit eigener Gl.iNet Weboberfläche. Die Oberfläche benutzt einiges an Scripting, das bedeutet auf alternativen (LineageOS) oder sehr eingeschränkten (NoScript Plugin) Browsern muss gelegentlich per Hand nachgeladen werden. Generell funktioniert aber alles.  
Es wird eine App angeboten um die Verwaltung noch bequemer zu gestalten.  

Das gelieferte OpenWRT ist aktuell in der Version 19.07.7. Wer gerne basteln mag bekommt auf der OpenWRT Seite aktuelle Images, für den Beryl aktuell die Version 21.  
https://openwrt.org/toh/views/toh_tfdownload <- suchen nach 'Brand = gl.inet'  

Alle Weboberflächen nutzen http anstatt https. Da wir mit einem Microcomputer arbeiten und das ausschliesslich im privaten LAN konfigurieren, verzichtet man auf den Overhead der Verschlüsselung und einer unschönen Sicherheitswarnung im Browser.  

## Was ist OpenWRT?

[OpenWRT](https://openwrt.org) ist ein offenes Routerbetriebssystem auf Linux Basis, mit dem Paketmanager **opkg**.  
Da bestimmt 95% der im Alltag vorkommenden Konfigurationen über die LuCI Weboberfläche erledigt werden können, ist dieses System für den ambitionierten Anwender nicht schwieriger zu benutzen als eine AVM Fritz!Box.  
Die Standarddialoge sind meist gut auf deutsch übersetzt.  

## LuCI Web UI

Die Gl.iNet Weboberfläche ist übersichtlich, aber bietet nicht alle Option die mit OpenWRT möglich sind. Dazu eignet sich besser die OpenWRT Weboberfläche LuCI.  
Dazu auf [http://192.168.8.1/cgi-bin/luci](http://192.168.8.1/cgi-bin/luci) gehen, oder im Menü ganz unten auf **More Settings** den Unterpunkt **Advanced** auswählen. Wenn die Oberfläche nicht installiert ist, kann sie mit dem Button 'Install' nachinstalliert werden. Wenn die Oberfläche installiert ist, wird der Link angezeigt. Der Benutzer ist 'root' und das Passwort wieder das zuerst vergebene.

![Browser LuCI](/media/router_beryl/browser_beryl_luci_overview.png)

## Länderkonfiguration

Wie erwähnt kommt die Box aus China, demnach ist die Konfiguration auch darauf ausgelegt. man merkt es kaum, die offensichtlichste Auswirkung sind die erlaubten WLAN Kanäle im 2,4GHz Band: 1-11, bei uns 1-13. Daher kann es sein dass das eigene oder das Campingnetz nicht gefunden wird, wenn diese als WLAN Kanal 12 oder 13 konfiguriert haben.  

Um das Problem zu beheben loggt man sich per SSH auf die Box ein. Unter Windows per `PuTTY` oder unter Linux/Mac mit `ssh` aus dem 'OpenSSH' Paket. Erlaubt ist nur ssh-rsa als Algorithmus. Daher gibt man auf der Konsole den folgenden Befehl ein:  
`ssh -oHostKeyAlgorithms=+ssh-rsa root@192.168.8.1`  
... als Passwort gibt man das im ersten Schritt gesetzte ein. Dann bearbeitet man die Konfigurationsdatei mit `vim /etc/config/wireless`  

Mit der Taste `[i]` kommt man in den editier-Modus.  
Firmware 3.203: 2x die Zeile **option Country 'CN'** mit **option Country 'DE'** ersetzen. Zusätzlich in beiden Blöcken (2,4GHz und 5GHz) **option region '1'** (von 0) und **option aregion '1'** setzen um den Europäischen Regularien gerecht zu werden.  
Firmware 3.211: Im Block mit **option Band '5g'** den Eintrag auf **option region '1'** setzen (zuvor 10). Im Block **option Band '2g'** kontrollieren, dass **option region '1'** gesetzt ist.  
[Details zu den Werten](https://blog.csdn.net/linbounconstraint/article/details/80899321) und [Wikipedia List of WLAN channels](https://en.wikipedia.org/wiki/List_of_WLAN_channels)  
Aus dem Editor (vim) kommt Ihr mit der Tastenfolge: `[Esc][:][x][Enter]`. Es gibt auch die Variante `[:][w][q]` (write quit), das kommt auf das selbe hinaus. Nach einem Neustart des Routers werden die neuen Werte automatisch in die Treiberkonfigurationen unter /etc/Wireless/... geschrieben.

> TIPP: Hier sollte nicht zu viel gespielt werden, denn die falschen Einstellungen können Störungen in anderen Geräten verursachen und sind daher illegal (kein Scherz)!  
Sollten die Sende-/Empfangswerte zu niedrig sein, lieber in eine Richtfunkantenne investieren.  

## glinet App 

Die App Kann entweder über den Google Playstore oder dem Apple AppStrore heruntergeladen werden. Oder direkt von der [Website](https://www.gl-inet.com/app/).  
Die App bietet weniger Möglichkeiten als die Weboberfläche, aber alles schöner aufbereitet und die relevanten Funktionen hat man ohne viel geklicke in der Hand. Funktioniert gut.  

Wenn ich ein VPN nutzen möchte, kann ich dieses sehr einfach und komfortabel per QR-Code in der App einrichten. Alternativ kann ich die Konfigurationsdatei auch in den entsprechenden Browser Dialog ziehen oder alles manuell eintippen.  

Insgesamt reagiert die App schnell und ist übersichtlich. Es gibt keinen Grund die Arbeit nicht damit zu vereinfachen. Es muss nur zum Start die Cloud ignoriert werden. Alles funktioniert super lokal.  
Auf der ersten Seite finden sich die wichtigsten Punkte um sich im Netzwerk zurechtzufinden. Am untersten Rand ist das Menü um zu den weiteren Seiten zu kommen.  

Gl.iNet App Mit VPN aus (erstes Bild) oder ein (zweites Bild). Der Klick auf das Symbol überschreibt die Einstellung des Hardware-Schalter (siehe Abschnitt VPN).  
![Gl.iNetApp Home VPN Off](/media/router_beryl/N7glinet_app-1_home_VPNoff.png) ![Gl.iNetApp Home VPN On](/media/router_beryl/N7glinet_app-2_home_VPNon.png)  

Die zweite Seite bietet alle Möglichkeiten in das Internet zu kommen, sehr ähnlich der Weboberfläche. Die dritte Seite beitet einen Überblick der lokal verbundenen Geräte, mit der Möglichkeit diese auch mit einem Klick zu blocken oder 'als Favoriten' zu markieren.  

Eine Übersicht der möglichen Internetzugänge und der Clients im lokalen Netzwerk.  
![Gl.iNetApp Network](/media/router_beryl/N7glinet_app-3_network.png) ![Gl.iNetApp Clients](/media/router_beryl/N7glinet_app-4_clients.png)  

Das letzte Fenster bietet einen Schnellzugriff auf einige Systemeinstellungen. Das wichtigste sollte hier die Zeit sein, aufgrund des zuvor genannten Bug.  
![Gl.iNetApp Network](/media/router_beryl/N7glinet_app-5_system.png)  

## VPN
Vorweg: Wer nach dem Lesen dieses Absatz weniger versteht als vorher, dieser Abschnitt ist wichtig für die Privatsphäre, nicht für die grundlegende Funktion. Wenn ich zuvor einfach jedes Gerät in das Campingplatz WLAN angemeldet habe, dann macht es jetzt auch keinen Unterschied.  

Es werden diverse VPN Provider und unterschiedliche Protokolle von Haus aus unterstützt. Da ich mir in der Vergangenheit die Zähne an IPSec und OpenVPN ausgebissen habe, habe ich diese Runde an **WireGuard** vergeben.  
WireGurad ist ein recht junger Ansatz, welcher sich durch schnelle/einfache Einrichtung (das sagen sie Alle) und Schonung der Ressourcen (mehr Netzwerkgeschwindigkeit) auszeichen soll. Dabei kommen modernste Crypto Standards zum Einsatz, welche nach heutigem Stand als als sicher gelten.  
Bei mir Zuhause laufen 2 Proxmox Host, als Virtualisierungslösung verschiedenster Dienste. Schnell ist ein neuer Container (LXC/Ubuntu) erstellt: [x] 8GB HDD, [x] 512MB RAM, [x] 1 CPU Kern und eine [x] Netzwerkkarte mit Internetzugriff. Ein unpriviligierter Container ist ausreichend.  

`root@walter:~# wget git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh`  
Ich bin kein Fan davon Services per Script aus dem Internet auszuführen. Aber für den Test genügt es, ich habe mir das Script vor dme Ausführen natürlich angesehen. Es prüft die Umgebung, macht diese bereicht für Wireguard und automatisiert eine Reihe von Befehlen, die man sonst per Hand abtippt. Das Script kann beliebig oft ausgeführt werden, um weitere VPN Clients hinzuzufügen oder vorhandene zu bearbeiten.  
Der Befehl `bash wireguard-install.sh` stellt ein paar Fragen. Als erstes den Namen der neu angelegten Verbindung, dann ein paar Details zu Hostname (Server), Port (Forwarding) und so weiter. Der Name ist wichtig, da so nachher auch die Datei im aktuellen Verzeichniss heisst. Das Einrichten eines weltweit verfügbaren Hostnamen oder die Portweiterleitung (Standard: 51820/UDP) würde hier den Rahmen sprengen, dafür gibt es bessere Tutorials.  
Zum Schluss wird ein QR-Code auf der Console angezeigt, den man mit einem Telefon scannen kann. Die glinet App bietet das Einrichten der VPN Verbindung via QR Code. Das funktioniert sehr gut.  

Da ich die Verbindung zuerst erstellt habe und erst später den Router eingerichtet, musste ich den Code erneut generieren, mittels:  
`root@walter:~# qrencode -t ansiutf8 < beryl.conf`  

> TIPP: Der QRCode sollte nie lesbar veröffentlicht werden und auch lokal behandelt, wie ein Passwort. Wer diesen hat, kann mit jedem beliebigen Gerät über einen WireGuard Client in Euer VPN!  

Die Bandbreite beim Test war limitiert durch den Versuchsaufbau. Daher gibt es noch keine Testergebnisse.  

Alle Gl.iNet Router bieten einen Hardware-Switch, über den ich verschiedene Aktionen steuern kann. Zum Beispiel kann ich darüber das VPN schnell ein- und ausschalten. Zuhause, per Mobilfunk und in vertrauenswürdigen Netzen kann ich das VPN ausschalten. Wenn ich das offene WLAN bekannter FastFood Ketten oder das Campingnetz nutze, kann ich das VPN einschalten. Vorausgesetzt ich habe ein dauerhaft verfügbaren VPN Server/Provider mit gutem Duchsatz!  

Wer keinen eigenen Server bereitstellen oder nutzen kann, dem steht offen halbwegs privat/anonym das TOR Netzwerk zu nutzen.

---


# Zukunft

- Ich werde das Gehäuse noch aufbrechen um zu sehen was ich dort für Antennen unter bekomme für optimalen Empfang. Ich stelle mir z.B. eine Ringantene aus einem 17" Laptop vor, die um die Dachlucke kommt. Das ist nicht schlimm, Gl.iNet stellt dafür sogar eine Anleitung bereit. Die Garantie verliert man trotzdem.  
- Ein wichtiger Punkt mit Kindern ist der Datenverbrauch. Mit dem Paket vnStat kann man den Datenverbrauch im OpenWRT pro Interface gut darstellen, aber mir fehlt noch ein Tool um per Quota beim Erreichen des Tageslimit einfach den Dienst abzustellen (oder noch besser auf eine andere verfügbare Lösung zurückzugreifen. Hier bin ich noch darauf angewiesen, dass entweder das Mobiltelefon (Android) oder der Provider beim Erreichen eines Grenzwert abschaltet.  
- Praxistest. In der Theorie war bisher alles super, aber ob sich die Werte auf dem Campingplatz auch erreichen lassen? Ich bin derzeit zuhause mit 600MBit Glasfaster angebunden und verteile das WLAN über 3 strategisch verteilte Router im Mesh, also ganz ähnlich einem besser ausgestattetem Campingplatz. Davon kommt zwar nur ein Bruchteil über den Router am Endgerät an, aber es reicht um mit 3 Geräten flüssig Youtube zu streamen.  
- Das mitgelieferte 5V/3A Netzteil ist natürlich für den Start ganz gut, unterwegs möchte ich aber mehr Autark stehen. Daher werde ich noch ein Spannungswandler DC DC 12V auf 5V/3A verbauen. Auf Amazon gibt es verschiedene Lösungen, auch mit vorkonfektionierten USB Stecker [Beispiel](https://www.amazon.de/dp/B09B7X3XKH/). Solange kein LTE notwendig ist, sollte auch ein normaler USB Stromstecker reichen. Leider habe ich gerade kein Labornetzteil zum Testen zur Verfügung, ich werde vieleleicht mit einem Multimeter zuhause einen Testaufbau wagen, bevor ich die Leitungen im Mobil riskiere.  
- Langfristig werde ich mir das neue [Truma iNet X Panel](https://www.truma.com/de/de/produkte/inet-x-system/truma-inet-x-panel) einbauen. Dieses hat noch kein 'eigenes Modem', sondern nur Bluetooth. Für diesen Einsatz ist mir wichtig bequem alle anderen Datenverbraucher abschalten zu können. Das benötigt noch einen [GL-S10](https://www.gl-inet.com/products/gl-s10/)/[GL-S200](https://www.gl-inet.com/products/gl-s200/) oder ähnlich, als BT Gateway. Vielleicht geht das auch über den USB Port, wenn man auf das Tethering verzichtet... Ist noch Zukunft.

---


# Bilder

Der lokale Testaufbau für Referenzwerte am Schreibtisch.  
![Testaufbau Desktop](/media/router_beryl/router_beryl_test.jpg)

Der erste Standort am zentralen Panel. Oben der Router, unten das Netzteil an 230V. Die neben der 230V Landstrom-Steckdose serienmäßig verbaute 12V KFZ-Steckdose habe ich gegen eine 2xUSB (max. 2,1A) Umgebaut.  
![Testaufbau Panel](/media/router_beryl/router_beryl_panel.jpg)

Der Standort über dem Fahrer ist fast perfekt, hat aber nur einen 230V Landstrom Anschluss.  
![Testaufbau Dach](/media/router_beryl/router_beryl_dach.jpg)

Im Zentrum des Buffymobils in der Küche für Testmessungen.  
![Testaufbau Kueche](/media/router_beryl/router_beryl_kueche.jpg)

Hinten in der Bettenlandschaft wurde der Druchsatz nicht signifikant schlechter (ca. 2m weiter weg vom Router). Aber wer will die Strahlung am Kopf?  
![Testaufbau Bett](/media/router_beryl/router_beryl_bett.jpg)

Es wurde an fast jeder Steckdose getestet.  
![Testaufbau Bad](/media/router_beryl/router_beryl_bad.jpg)


Die Box würde ich bei trockenem Wetter ohne Bedenken durch die Dachluke auf das Dach vom BuffyMobil stellen (ggf. mit Geschirrtuch gegen direkte Sonneneinstrahlung), für besseren Empfang. Von den Übertragungswerten im Heimtest bin ich über dem Panel vollkommen zufrieden.  
Im 4pfoten-Mobil gibt es hinter dem Beifahrersitz eine Sitzgelegenheit mit einem Schrank drüber. In diesem ist im oberen Fach der SAT Empfänger und der Solar-Laderegler verbaut. Hier kann ich mir gut vorstellen auch den 12V->5V/3A Spannungswandler einzubauen.  
Für WLAN kann von dort ein 2-3m USB-A auf USB-C Kabel in Richtung Panel oder über den Beifahrersitz gelegt werden. Und im Extremfall auch durch die vordere oder mittlere Dachlucke. Für USB-Tethering kann der gleiche Weg benutzt werden um das Telefon/Tablet entsprechend gut zu positionieren. Wobei ein Mobiltelefon empfindlicher in der Sonne ist und sich vermutlich abschaltet.  

