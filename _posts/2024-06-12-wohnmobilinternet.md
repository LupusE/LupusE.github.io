---
status: published
published: true
layout: post
title: Wohnmobilinternet
author: Benjamin Moeller
date: 2024-06-12 20:42:01 UTC
categories: [wohnmobil]
tags: [wohnmobil, router]
comments: []
---

Warum benötigt man im Urlaub überhaupt Internet? Auch wenn es so edel klingt digitales detoxing zu betreiben, ich denke keiner möchte darauf verzichten. Denn selbst bei Hotels und Ferienwohnungne wird darauf geachtet, dass WLAN verfürbar ist. So auch auf dem Campingplatz.

## Das Wohnmobil und der Strom

Im mobilen Heim hat man grundsätzlich zu wenig Steckdosen. Als wir 2020 unser neustes 4-Pfoten-Mobile gekauft haben, war ich zuerst sehr angetan. Eine Steckdose über dem Fahrersitz, eine unter der Sitzecke, eine hinter dem Fernseher im Eingang, eine im Bad und eine hinten bei den Betten. Aber um ehrlich zu sein nutzen wir 230V eher selten. Wir stehen eher autark.  
Hinter dem TV und über den Betten waren je ein 12V Stecker, welche über die Bordbatterie versorgt wurden. Die Zeiten von KFZ-Steckern ist definitiv vorbei, daher habe ich daraus je eine doppel USB Steckdose gemacht. Und bin glückich. An den Betten werden oft Switch oder Mobiltelefon geladen, vorne am TV steckt dauerhaft ein Uhrenladekabel (Garmin) und nach Bedarf ein Router.  

Um diese Router soll es heute auch gehen.  

Mein Lieblingsrouter ist weiterhin (ich hatte schon geschrieben) der GL-iNet Shadow (GL-AR300M-Ext). Am USB Port frisst er 5V/1A und bietet dafür 2.4 GHz WLAN. Dabei kann ich sowohl eines zum Campingplatz-Netz aufbauen als auch ein eigenes im Mobil bereitstellen. Am Laptop mit Strommessgerät sehe ich einen Verbrauch von 5,1V auf 0,18A. Weniger als 2 Watt laut Datenblatt. 33 Euro.  
Letzte Tour hatte ich meinen Shadow verlegt, aber meinen Slate Plus (GL-A1300) dabei. Lange Zeit habe ich mich nicht getraut, da ich aus dem Forum weiss dass es beim falschen Netzteil zu Verbindungsabbrüchun und Freezes kommen kann. Ich wollte gar nicth wissen was das am Wohnmobil Bordnetz auslöst ... Aber nun war ich neugierig, immerhin habe ich eine USB Strommultimeter dabei. 5,1V auf 1,2A kurzzeitig beim Boot, dann um die 0,5A, je nach Last. 17h durchgängig, ohne Unterbrechnung oder Freeze. Weniger als 6,5 Watt laut Datenblatt. Das mitgelieferte 5V/3A Netzteil schreckt doch mehr ab als es müsste. 90 Euro.  

Jetzt habe ich mir einen Spitz AX (GL-X3000) bestellt. Dieses Modell hat einen angegeben Verbrauch von 14 Watt. Aber bietet dafür 6 Antennen: 2 für WLAN (MIMO) und 4 für 5G LTE GPS und so weiter. Es ist nicht auf 5 Volt fix, sondern man kann ihn angeblich zwischen 3 und 12 Volt betreiben. Vermutlich wäre hier der KFZ-Steker noch sinnvoll gewesen. 580 Euro.  


Was mir am Portfolio von GL.iNet sehr gefällt ist das breite Portfolio. Man bekommt für verschiedenes Geld verschiedene Ausstattungen. Alle oben beschriebenen Router machen am Ende das selbe, nur unterschiedlich schnell.  

## VPN Server

Zugegeben ist es nun gedanklich ein kleiner Sprung, aber ich nutze diese Router speziell aus einem Grund: Ich will sicher in öffentlichen Netzwerken sein.  

Bei der Einrichtung kann man mit 2 Techniken aus 30 Anbietern für VPN wählen. Unterstützt werden immer das neuere WireGuard und das bewährte OpenVPN. Manche Modelle bieten das flexiblere Tor als dritte Option eines Tunnels an. Ich nutze keinen Anbieter. Da ich zuhause eine 500 MBit Glasfaser Leitung habe, steht dort mein Endpunkt unter meiner Kontrolle.  

Zunächst suche ich mir einen GL.iNet Router aus, den ich zuhause stehen haben will.  

### Die Auswahl des Servers
* Brumme 2 (GL-MT2500) - Ein Gerät ohne WLAN, sehr kompakt und schnell dank 2,5 GBit Ethernet Port. Etwa 90 Euro
* Mango (GL-MT300N-V2) - Der schmalere Shadow, mit WLAN aber ohne externe Antennen.
* Slate AX (GL-AXT1800) - Kompakt, Wi-Fi 6, Leistungsstark. Etwa 130 Euro.
* Flint 2 (GL-MT6000) - Ein vollwertiger Routerersatz für zuhause. Sicher eine Option, wenn die Fritz!Box oder ähnliches ausgetauscht werden soll. 160 Euro
* Marble (GL-B3000) - Kommt bald. Ein schöner Router, der auch als Bilderrahmen genutzt werden kann.

Alternativen:
* Selbstgebaut mit Linux/*BSD VM oder Miniinstallation ...Das hatte ich mal, aber ist zu viel Aufwand.
* Wie oben genannt, einen von 30 Anbietern dafür bezahlen.


### Den VPN Server aufstellen
Meine Wahl fiel auf den Slate AX, der zwar sehr vielseitig ist, aber für unterwegs doch ein bisschen zu gross. Wenn der Marble raus kommt wird der sicher ersetzt.

1. Strom an dne Slate AX
2. Ethernet-Kabel vom LAN an das WAN des Slate AX
3. Kabel vom Slate AX LAN zum Laptop/PC oder per WLAN und dne Zugangsdaten auf dme Etikett unten per Smartphone/Tablet verbinden.

Im generellen ist es ohne Einschränkungen möglich sich per Smartphone/Tablet zu verbinden. Doch leider stellt sich Android so intelligent dar, dass eine Verbindung ohne Internet nicht geroutet wird, wenn eine andere Verbindung (z.B. mobile Daten) besteht. Um auf die Administrationsoberfläche zu kommen muss also kurzzeitig 'Mobile Daten' oder ähnlich deaktiviert werden. Das ist kein Problem der GL.iNet Router, weil die würden jede Anfrage annehmen und beantworten.  
Wenn das WAN Kabel gesteckt ist und der Router eine IP und ein Gateway zugewiesen bekommen hat, dann besteht das zuvor genannte Problem nicht. Eventuell muss man einen kleinen Moment warten.  

### Die VPN Server Einrichtung
Jeder GL.iNet Router wird mit der IP 192.168.8.1/24 ausgeliefert. Zwar ist bekannt, dass eine IP in einem Netzwerk nur einmal vergeben sein darf, eher unbekannt ist, dass genauso ein Netzwerk in einem VPN nur einmal existieren darf. Ich empfehle zuerst auf der Administrationsseite (http://192.168.8.1) links im Menü unter 'Netzwerk - LAN' die IP zu ändern, z.B. auf 192.168.9.1. Danach sollte der Router einmal neu gestartet werden, wenn er nicth über die IP http://192.168.9.1 errieichbar ist, den Client auch einmal neu verbinden.  

Nach der erneuten Anmeldung am Router geht man links im Menü auf 'VPN - WireGuard Server'. Die Übersetzung 'Konfiguration erzeugen' aus dem Englischen 'Generate Configuration' wird aktuell überarbeitet und ist in Zukunft sicher besser.  
Wenn der GL.iNet Router nicht direkt im Internet ist, muss auf dem Hauptrouter der hier angezeigte Port (Standard: 51820) weitergeleitet werden (Port Forwarding).  
Weiter oben gibt es den Reiter 'Profile', über den die Konfiguration für die Gegenstellen erstellt wird. Mit dem Button 'Hinzufügen' wird im Dialog ein Name angegeben, zum Beispiel 'Wohnmobil'. Ich empfehle den Schalter 'Benutze eine DDNS Domain' zu aktivieren, wenn die Erreichbarkeit des Servers aus dem Internet nicht über andere Wege sichergestellt ist.  
In dem Dialog erscheint nun ein QR Code, der in der GL.iNet App photografiert werden kann um die Verbindung herzustellen, ode rman läd sich die Configuration mit dme Button 'Herunterladen' auf den Computer oder das Smartphone um es später, bei Verbindung auf dem entfernten Router wieder hochzuladen. Dieser Dialog kann jederzeit wieder aufgerufen werden.  


## VPN Client
