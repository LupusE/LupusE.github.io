---
status: published
published: true
title: Wohnmobilnetzwerk - Gl.iNet Beryl
author: Benjamin Moeller
date: 2022-05-15 16:24:00 UTC
categories: [Wohnmobil]
tags: [UnterwegsZuhause]
comments: []
---

## tl;dr

Ich hatte erwartet hier wird ein grossartiges Projekt entstehen. Leider funktioniert die Lösung so gut, dass es nicht viel zu beschreiben gibt.
1. gl.iNet Router in gewünschter Ausstattung (und Preis) kaufen
2. An Strom anschliessen, mit Daten auf der Unterseite anmelden
3. 'Internet' per Kabel, WLAN oder Tethering/USB Modem bereitstellen (siehe unten)
4. Fertig

Dabei gibt es die folgenden Wege für das Internet:
- Kabel an den Netzwerkport WAN anschliessen. Am einfachsten, aber selten beim Camping vorhanden.
- WLAN Bridge einrichten. Auf http://192.168.8.1 anmelden, links *Internet* auswählen, unter *repeater* den Button *Scan* klicken, das entsprechende WLAN auswählen, das Passwort eingeben und *Join* klicken.
- USB-Tethering. An den USB Port ein Mobiltelefon oder Tablet mit Internet anschliessen. Im Menü des Telefons 'Tethering' freigeben.
- USB-Modem. Noch nicht getestet.

Tipp: Beim ausführlichen Testen ist mir desöfteren die WLAN Verbindung abgebrochen, gerade beim Aufbau einer WLAN Bridge. Irgendwann funktiniert es, aber die Button Scan/Join müssen häufig geklickt werden, bis man zufällig den richtigen Moment erwischt und 'Success' oben in der Menuleiste steht. Per LAN Kabel gab es keine Probleme... Vielleicht geht das einfacher/stabiler per App.  


## Vorgeschichte

Heutzutage benötigt man Internet, auch im Urlaub. Nicht nur als Roadwarrior (arbeiten von Unterwegs), auch um Up-to-Date zu bleiben oder Urlaubsphotos zu posten. Vielleicht möchte man am Abend ein Video oder Musik streamen. Und wenn Kinder ab einem gewissen Alter mit reisen, dann ist das Internet unterwegs nicht merh optional.  

Für Wohnmobile werden verschiedene Systeme angeboten und auch regelmäßig in Fachliteratur getestet:  
Zum Einen gibt es Pocketrouter ('Mobile Ostereier') für 40-150 Euro. Diese werden oft mit einer billigen SIM-Karte, meist PrePaid, betrieben und sind durch internen Akku auch ausserhalb der Wohnmobils flexibel. Aber diese lösung ist auf das Mobilfunk-Netz angewiesen. Nachdem was ich weis, eher für den gelegentlichen Ein-Personen-Gebrauch eines Tablet/Notebook. Im Ausland kann man heutzutuage fast immer einfach eine lokale Karte kaufen und diese nutzen. Roaming sollte innerhalb der EU kein Thema mehr sein.Die gibt es imme rmal wieder von TCM (Tchibo) oder AldiTalk.  
Zum Anderen gibt es, oft aus dem Bootsbereich, mehr oder weniger klobige Boxen auf dem Dach mit einem kleinen Router. Diese bieten deutlich mehr, LTE(4G) und WLAN vom Campingplatz. Für 300-900 Euro oder mehr. Bald kommt 5G und ich habe von keinem Gerät gelesen, welches sich 'einfach' aufrüsten lässt. Auch ein Faktor: Meine Frau möchte keine zusätzlichen Löcher in ihr Wohnmobil gebohrt haben.  
Dazwischen gibt es um die 200-400 Euro noch ein paar portable Lösungen, die sicher auch funktionieren. Aber oft leiden diese unter einem oder mehr Nachteile der vorgenannten Lösungen, aber unter Umständen eine sehr gute Übersicht über den Datenverbrauch. Die bekanntesten dieser Klasse sind wohl die 'Netgear Nighthawk' Modelle.  

Ich war auf der Suche nach einem kleinen, flexiblen und günstigen Router, der mir im Wohnmobil ein gutes Netzwerk gibt und auch kaputt gehen darf, ohne dass es weh tut.

## Recherche

Vor einigen Wochen habe ich einen Microrouter der Firma [Gl.iNet](https://www.gl-inet.com/) gesehen. Der GL-AR300M-Ext ist eine kleine Box für etwa 32 Euro auf Amazon, mit zwei austauschbaren Antennen. Die Box stellt in der Basiskonfiguration eine sogenante 'Bridge'. Das bedeutet ich kann entweder ein WLAN aufnehmen und das über den LAN Port weiter geben (Laptop ohne WLAN-Karte) oder ich kann ein LAN an die Box anschliessen und ein eigenes WLAN zur Verfügung stellen (Konferenztisch?).  
Interessant für uns Camper: Durch mehrere Antennen, kann ich mit geringem Verlust ein externes WLAN (Campingplatz) aufnehmen und daraus ein eigenes lokales WLAN für alle Geräte machen. Für das Wohnzimmer auf Rädern auf dem Campingplatz also perfekt. Durhc die tauschbaren Antennen könnte ich, ohne die Leistung physikalisch zu ändern, vollkommen legal mehr Reichweite durch Richtwirkung erhalten.  
Die Firma Gl.iNet (Gl steht für Goodlife) kommt aus China, wo das Privatleben im Internet eine ganz andere Gewichtung hat. Also stellt die Box zusätzlich noch ein VPN als Client oder Server zur Verfügung. Das ist für uns nicht ganz so wichtig, aber es ist eine zentrale Funktion und sehr gut umgesetzt, dazu in einem späteren Artikel mehr.  

Als Informatiker habe ich mir das Datenblatt genauer angesehen und so richtig hat es mich nicht überzeugt. Also was bieten die anderen Modelle des Herstellers?  
* [GL-AR300M](https://www.gl-inet.com/products/gl-ar300m/) (Shadow)/[GL-MT300N-V2](https://www.gl-inet.com/products/gl-mt300n-v2/) (Mango) sind kleine günstige Boxen, mit verschiedener Ausstattung. Vergleichbar mit der zuerst erwähnten.
* Die [GL-AR750S](https://www.gl-inet.com/products/gl-ar750s/) (Slate) hat einen deutlich stärkeren Prozessor und mehr RAM (Arbeitsspeicher) und sollte für die meisten Anwendungen im Wohnmobil ausreichen. Stromverbrauch <6W laut Datenblatt. Für 75 Euro okay.
* Der [GL-MV1000W](https://www.gl-inet.com/products/gl-mv1000/) (Brumme-W) hat mir am besten gefallen, ist aber derzeit nicht verfügbar.
* Der [GL-SFT1200](https://www.gl-inet.com/products/gl-sft1200/) (Opal) hat einen geringen Strombedarf (2A Netzteil), bei der Unterstützung moderner WLAN-Protokolle und einem schnellen Prozessor. Für unter 50 Euro auch erschwinglich. Dafür nur 2 feste WLAN Antennen. Preis-/Leistungssieger.  
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

Er ist der teuerste unter allen bewerteten Modellen. Meine Entscheidung hat besonders die Unterstützung von IPv6 und der Einsatz einer SD Karte beeinflusst. Wem das nicht wichtig ist, der wird mit dem GL-SFT1200 (Opal) 30 Euro günstiger weg kommen. Wem bisher nur stört, dass das Android Telefon/Tablet kein WLAN Tethering kann, der kann die deutlich günstigeren Shadow/Mango Boxen ohne 5GHz WLAN in Betracht ziehen.  
Der Beryl kann ich auch mit einer bis zu 512GB großen SD Karte füttern und per FTP Daten oder per DNLA Medien bereitstellen. Unser Fernseher im Wohnmobil ist nicht smart, das wäre für mich der einzig sinnvolle Einsatz. Aber vielleicht spiele ich auch mal mit dem Chromecast rum. Ich werde berichten...  

Zunächst fragte ich mich, warum er nach Spezifikation unbedingt ein 5V/3A Netzteil verlangt, obwohl der Verbrauch mit <8,65W angegeben ist (8,65W/5V=1,75A). Beim Testen ging mir dann ein 15 Watt Licht auf. Ein Mobiltelefon am USB Port will ja auch mit Strom versorgt werden. Wenn dieses 2,1A zieht, dann hat das Board nicht mehr genügend Strom.  
Tetherung = Mobilfunk vom Mobiltelefon/Tablet weitergeleitet. Meist über USB.  

Die Kaufentscheidung hängt ab von:
- Binde ich das Gerät ins WLAN, per Kabel ein oder Tethering? Oder will ich flexibel alle Möglichkeiten haben?
- Wie viel Strom habe ich zur Verfügung? Bei 3A muss ich mir schon etwas einfallen lassen, während ich bis 2,1A einfach an jedem USB Port betreiben kann.
- Will ich jetzt oder später Medien per DNLA im Wohnmobil bereitstellen? (MicroSD Slot)
- Will ich daraus noch weitere DIY Projekte bauen? Dann sollte die Box vielleicht auch auch GPIO Pins bieten, z.B. im den TIN Bus der Truma auszulesen.
- IPv6 wird heute weniger eine Rolle spielen, da es über OpenWRT sicher nachgereicht wird, sobald es salonfähig ist.

Die Größe des Wohnmobil/-wagen spielt dabei kaum eine Rolle, bis 12m Länge sollte alles problemlos auch im 5GHz Band auszuleuchten sein. Wichtiger ist die Außenwand. Ein Kastenwagen mit Metallchassis dämpft den Empfang deutlich mehr als die GFK Wand eines Aufbau.  


### Ersteinrichtung (Kabel)

Ich habe den Luxus, dass mein Wohnmobil direkt vor der Tür steht. Das bedeutet ich konnte so tun als wäre mein Haus-WLAN ein Campingplatz. Aber bevor ich raus gegangen bin habe ich die kleine Box an meinem Schreibtisch ausgiebig getestet.  

Die Ersteinrichtung war super einfach:
* Auspacken, Strom dran, LAN an Laptop, warten bis die LED vorne leuchtet
* Browser öffnen und auf http://192.168.8.1 gehen
* Beim ersten Login ein Adminpasswort vergeben

* In der Weboberfläche auf **Wireless**
* Zuerst habe ich das WLAN umbenannt (SSID) in LupusEmobi24 und LupusEmobi5 und einen eigenen Key vergeben. Dei GastWLAN habe ich ausgeschaltet gelassen.
  * Tipp: Man kann auch den gleichen Namen (SSID) und Key wie zuhause verwenden, dann können sich alle Geräte (z.B. Xbox/Playstation/Switch) auch unterwegs mit den gleichen Daten anmelden. Das geht nur nicht zum lokalen Testen.

![Browser Wireless](/media/router_beryl/browser_beryl_wireless.png)

Siehe da, ein Firmwareupdate (3.211) ist verfügbar. Über den Menüpunkt **Upgrade** hat die Box sich auf Bottonklick das Image selbst aus dem Internet gezogen und installiert. Danach ging kein Remote-WLAN mehr... Ich habe vorerst ein Downgrade (3.203) durchgeführt, es könnte mehrere Gründe (auch mein verschulden) haben.

![Browser Upgrade](/media/router_beryl/browser_beryl_upgrade.png)

**Tipp**: Ich habe ein extra Notebook für soche Aufgaben, aber manchmal hat man nur ein Mobiltelefon oder Tablet zur Verfügung. Anstelle eines Kabel kann man sich auch direkt per WLAN verbinden.  
Mit dem unten aufgedruckten WLAN verbinden. Entweder GL-MT1300-xxx (2,4GHz) oder GL-MT1300-xxx-5G (5GHz). Der Key ist immer 'goodlife'  


### Einrichtung (WLAN zu WLAN)

* Nach dem grundlegenden Einrichten bekam das Gerät unter **Internet** Die Zugangsdaten zu meinem WLAN. Fertig.

![Browser Internet](/media/router_beryl/browser_beryl_internet.png)

Ich nutze vom Endgerät (Handy/Tablet) das 5GHz Netz, weil ich ja WLAN zu WLAN haben möchte.  
Das 2,4GHz Netz hat die bessere Reichweite, das 5GHz Netz hat den besseren Durchsatz. Reichweite benötige ich auf 2,33mx7,40m nicht, aber draussen. Wenn ich intern auf einem anderen Band funkte, sorge ich gleichzeitig für weniger Störungen untereinander.


### Feintuning (Tethering)

Im Menupunkt **Internet** ist die Option **Tethering** ausgegraut.  
Wenn ein Android Telefon an einen Computer angeschlossen wird, dann steht im Drop-Down (vom oberen Bildschirmrand nach unten ziehen) 'Android-System - Gerät wird über USB aufgeladen / Für weitere Optionen tippen)'. Dann kann ich in den 'USB-Einstellungen' 'USB-Tethering' (neben z.B. 'Dateiübertragung') auswählen. Ab sofort kann ich **Tethering** in der Box auswählen.  
USB-Tethering bedeutet, dass das Mobiltelefon die vorhandene Internetverbindung über den USB Port zur Verfügung stellt. Dabei interessiert dem Gerät am USB Port nicht ob es sich um eine WLAN oder Mobilfunkverbindung handelt. Sollte ich also ein Mobiltelefon mit sehr guter WLAN-Antenne besitzen, kann ich sogar ganz auf ein WLAN Modul im Router verzichten. Dabei gilt aber zu beachten, dass in dem Fall auch immer 2 Geräte mit Strom versorgt werden müssen.  

In unserem Fall hat meine Frau ihr altes 'Sony Xperia Z3 Compact' zur Verfügung gestellt und wir haben bei O2 eine Datenkarte bestellt. Da sie Europaweit 120GB LTE Datenvolumen pro Monat hat, kann sie ein wenig davon im Urlaub teilen.  

Die Box kann auch direkt mit Linuxfähigen USB-Modems umgehen. Dabei empfiehlt es sich aber die PIN der Datenkarte zu deaktivieren. Da ich nur einen 3G Stick (Huawai E1750) mit anderer SIM-Größe hier habe, habe ich es noch nicht getestet.


## Technisch

Die Box besitzt eine OpenWRT Firmware mit eigener Gl.iNet Weboberfläche. Es wird eine App angeboten um die Verwaltung noch bequemer zu gestalten.  
Das gelieferte OpenWRT ist aktuell in der Version 19.07.7. Wer gerne basteln mag bekommt auf der OpenWRT Seite aktuelle Images für die Version 21.  
(https://openwrt.org/toh/views/toh_tfdownload <- suchen nach 'Brand = gl.inet')  

Alle Weboberflächen nutzen http anstatt https. Da wir mit einem Microcomputer arbeiten und das ausschliesslich im privaten LAN, verzichtet man auf den Overhead der Verschlüsselung und einer unschönen Sicherheitswarnung im Browser.  

### Was ist OpenWRT?

[OpenWRT](https://openwrt.org) ist ein offenes Routerbetriebssystem auf Linux Basis, mit dem Paketmanager **opkg**.  
Da bestimmt 95% der im Alltag vorkommenden Konfigurationen über die LuCI Weboberfläche erledigt werden können, ist dieses System für den ambitionierten Anwender nicht schwieriger zu benutzen als eine AVM Fritz!Box.  
Die Standardanwendungen sind gut auf deutsch übersetzt, ich benutze es aber gerne auf Englisch.

### LuCI Web UI

Die Gl.iNet Weboberfläche ist übersichtlich, aber bietet nicht alle Option die mit OpenWRT möglich sind. Dazu eignet sich besser die OpenWRT Weboberfläche LuCI.  
Dazu einfach unter http://192.168.8.1 im Menü ganz unten auf **More Settings** den unterpunkt **Advanced** auswählen. Wenn die Oberfläche noch nicht installiert ist, kann sie mit dem Button 'Install' nachinstalliert werden. Wenn die Oberfläche installiert ist, wird der Link angezeigt zum aufrufen. Der Benutzer ist 'root' und das Passwort wieder das zuerst vergebene.

![Browser LuCI](/media/router_beryl/browser_beryl_luci_overview.png)

### Länderkonfiguration (Kanäle)

Wie erwähnt kommt die Box aus China, demnach ist die Konfiguration auch darauf ausgelegt. Die erlaubten WLAN Kanäle im 2,4GHz Band sind 1-11, bei uns 1-13. Daher kann es sein dass das eigene oder das Campingnetz nicht gefunden wird, wenn diese als WLAN Kanal 12 oder 13 konfiguriert haben.  

Um das Problem zu beheben logt man sich per SSH auf die Box ein. Unter Windows per **PuTTY** oder unter Linux/Mac mit **ssh** aus dem 'OpenSSH' Paket. Erlaubt ist nur ssh-rsa als Algorithmus. Daher gibt man auf der Console den folgenden Befehl ein:

> ssh -oHostKeyAlgorithms=+ssh-rsa root@192.168.8.1

... als Passwort gibt man das im ersten Schritt gesetzte ein. Dann bearbeitet man die Konfigurationsdatei ...

> vim /etc/config/wireless

Mit der Taste [i] kommt man in den editier-Modus.  
~~... indem 2x die Zeile **option Country 'CN'** mit **option Country 'DE'** ersetzt wird.  
Zusätzlich habe ich in beiden Blöcken (2,4GHz und 5GHz) **option region '1'** und **option aregion '1'** gesetzt um den Europäischen Regularien gerecht zu werden.~~  
**Update**: In der neusten Firmware (3.211 vom 27.12.2021) gibt es kein **option Country** mehr. Im Block mit **option Band '5g'** den Eintrag **option region '1'** setzen (zuvor 10). Im Block mit **option Band '2g'** kontrollieren **option region '1'**. [Details zu den Werten](https://blog.csdn.net/linbounconstraint/article/details/80899321) und [Wikipedia List of WLAN channels](https://en.wikipedia.org/wiki/List_of_WLAN_channels)  
Aus dem Editor kommt Ihr mit der Tastenfolge: [Esc][:][x][Enter]. Es gibt auch die Variante [:][w][q], das kommt auf das selbe hinaus.  
Nach einem Neustart des Routers werden diese Werte automatisch in die Treiberkonfigurationen unter /etc/Wireless/... geschrieben.

Tipp: Hier sollte nicht zu viel gespielt werden, denn die falschen Einstellungen können Störungen in anderen Geräten verursachen und sind daher illegal (kein Scherz)!  
Sollten die Sende-/Empfangswerte zu niedrig sein, lieber in eine Richtfunkantenne investieren.  

### glinet App 

Die App Kann entweder über den Google Playstore oder dem Apple AppStrore heruntergeladen werden. Oder direkt von der [Website](https://www.gl-inet.com/app/).  
Die App bietet weniger Möglichkeiten als die Weboberfläche, aber alles schöner aufbereitet und die relevanten Funktionen hat man ohne viel geklicke in der Hand. Funktioniert gut.

### VPN (WireGuard)

Es werden diverse VPN Provider und unterschiedliche Protokolle von Haus aus unterstützt. Da ich mir in der Vergangenheit schon oft die Zähne an IPSec oder OpenVPN ausgebissen habe, habe ich diese Runde an WireGuard vergeben.  
WireGurad ist ein recht junger Ansatz, welcher sich durch schnelle/einfache Einrichtung (das sagen sie Alle) und Schonung der Ressourcen auszeichen soll. Dabei kommen in der Voreinstellung modernste Crypto Standards zum Einsatz, welche nach heutigem Wissen als als sicher gelten.  

> root@walter:~# wget git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh

Ich bin kein Fan davon Services per Script aus dem Internet auszuführen. Aber für den Test genügt es. Das finale Produkt wird aus den Debian Bullseye Repository installiert. Das Script hat den weiteren Vorteil, dass es einfach nochmal ausgeführt werden kann, um einen weiteren Host hinzuzufügen.  
Der Befehl 'bash wireguard-install.sh' stellt ein paar Fragen. Als erstes den Namen der neu angelegten Verbindung, dann ein paar Details zu Hostname, Port und so weiter. Der Name ist wichtig, da so nachher die Datei im aktuellen Verzeichniss heisst. Das Einrichten eines weltweit verfügbaren Hosntamen oder die Portweiterleitung würde hier dne Rahmen sprengen, dafür gibt es bessere Tutorials.  
Zum Schluss wird ein qrcode auf der Console angezeigt, den man mit einem Telefon scannen kann. Die glinet App bietet auch das Einrichten der VPN Verbindung via QR Code. Das funktioniert sehr gut.

Da ich die Verbindung zuerst erstellt habe und erst später den Router eingerichtet, musst eich den Code erneut generieren, mittels:

> root@walter:~# qrencode -t ansiutf8 < beryl.conf

Der QRCode sollte nie lesbar veröffentlicht werden und auch lokal behandelt wie ein Passwort. Wer diesen hat, kann mit jedem beliebigen Gerät über einen WireGuard Client per Scan in Euer VPN!

Die Bandbreite beim Test war limitiert durch den Versuchsaufbau. Die Verbindung wurde schnell aufgebaut und hatte einen schnellen Durchsatz.

#### WireGuard Server

Bei mir Zuhause läuft eh ein Proxmox Host, als Virtualisierungslösung verschiedenster Server.  
Schnell einen neuen Container (LXC) erstellt, 8GB HDD, 512MB RAM, 1 CPU Kern und eine Netzwerkkarte mit Internetzugriff. Ein Unpriviligierter Container ist ausreichend.  


## Zukunft

- Ich werde das Gehäuse noch aufbrechen um zu sehen was ich dort für Antennen unter bekomme für optimalen Empfang. Ich stelle mir z.B. eine Ringantenne aus einem 17" Laptop vor, die um die Dachlucke kommt. Das ist nicht schlimm, Gl.iNet stellt dafür sogar eine Anleitung bereit. Die Garantie verliert man trotzdem.  
- Ein wichtiger Punkt mit Kindern ist der Datenverbrauch. Mit dem Paket vnStat kann man den Datenverbrauch im OpenWRT pro Interface gut darstellen, aber mir fehlt noch ein Tool um per Quota beim Erreichen des Tageslimit einfach den Dienst abzustellen (oder noch besser auf eine andere verfügbare Lösung zurückzugreifen. Hier bin ich noch darauf angewiesen, dass entweder das Mobiltelefon (Android) oder der Provider beim Erreichen eines Grenzwert abschaltet.  
- Praxistest. In der Theorie war bisher alles super, aber ob sich die Werte auf dem Campingplatz auch erreichen lassen? Ich bin derzeit zuhause mit 600MBit Glasfaster angebunden und verteile das WLAN über 3 strategisch verteilte Router im Mesh, also ganz ähnlich einem besser ausgestattetem Campingplatz. Davon kommt zwar nur ein Bruchteil über den Router am Endgerät an, aber es reicht um mit 3 Geräten flüssig Youtube zu streamen.  
- VPN ist zwar kein super relevantes Thema, aber da es nunmal angeboten wird, werde ich es hier auch mindestens mit WireGuard etwas ausführlicher beschreiben. Spätestens wenn ich das öffentliche WLAN einer bekannten Fastfood Kette an vielen Autobahnraststätten benutze, sollte ich ggf. darüber nachdenken.  
- Das mitgelieferte 5V/3A Netzteil ist natürlich für den Start ganz gut, unterwegs möchte ich aber mehr Autark stehen. Daher werde ich noch ein Spannungswandler DC DC 12V auf 5V/3A verbauen. Auf Amazon gibt es verschiedene Lösungen, auch mit vorkonfektionierten USB Stecker [Beispiel](https://www.amazon.de/dp/B09B7X3XKH/). Solange kein LTE notwendig ist, sollte auch ein normaler USB Stromstecker reichen. Leider habe ich gerade kein Labornetzteil zum Testen zur Verfügung, ich werde vieleleicht mit einem Multimeter zuhause einen Testaufbau wagen, bevor ich die Leitungen im Mobil riskiere.  

## Bilder

Der lokale Testaufbau für Referenzwerte.
![Testaufbau Desktop](/media/router_beryl/router_beryl_test.jpg)

Der erste Standort am zentralen Panel. Unten das Netzteil, oben der Router.
![Testaufbau Panel](/media/router_beryl/router_beryl_panel.jpg)

Der Standort über dem Fahrer ist fast perfekt. Aber nur 230V Anschluss.
![Testaufbau Dach](/media/router_beryl/router_beryl_dach.jpg)

Im Zentrum des Buffymobils für Testmessungen.
![Testaufbau Kueche](/media/router_beryl/router_beryl_kueche.jpg)

Auch hinten in der Bettenlandschaft wurde der Druchsatz nicht signifikant besser (ca. 2m weiter weg vom Router).
![Testaufbau Bett](/media/router_beryl/router_beryl_bett.jpg)

Es wurde an fast jeder Steckdose getestet.
![Testaufbau Bad](/media/router_beryl/router_beryl_bad.jpg)

Die Box würde ich auch ohne bedenken durch die Dachluke auf das Dach vom BuffyMobil stellen, wenn notwendig. Von den Übertragungswerten im Heimtest her bin ich aber über dem Panel vollkommen zufrieden.
