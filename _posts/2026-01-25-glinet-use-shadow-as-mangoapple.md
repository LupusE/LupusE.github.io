---
status: published
published: true
layout: post
title: Gl.iNet - Shadowapple
author: Benjamin Moeller
date: 2026-01-25 18:34:03 UTC
categories: [experimente]
tags: [produkte, glinet, shadow]
comments: []
---

# Was ist ein Mangoapple?
Es gibt von Hak5 den Wifi Pinapple. Die kleinste Version nutzt den gleichen Chipset wie der [GL.iNet Mango](https://www.gl-inet.com/products/gl-mt300n-v2/). Also hat ser Benutzer xchwarze das Projekt portiert: https://github.com/xchwarze/wifi-pineapple-cloner  
Der Benutzer SHUR1K-N hat das ganze auf den GL.iNet Mango adaptiert und einige hilfreiche Anleitungen geschrieben: https://github.com/SHUR1K-N/WiFi-Mangoapple-Resources  
Leider setzt dieses Projekt die uralt Version 19.07 von OpenWrt voraus. Anscheinend wurde es vor kurzem auf zumindest 21.02 aktualisiert.  
Und es gibt einen nicht zu fixenden Bug, in einer Kernkomponente für die Mipsel Architektur: https://github.com/xchwarze/wifi-pineapple-cloner/issues/57  

# Ist der Shadow nicht nur ein anderer Mango?
Nein. Der [Shadow (GL-AR300M16-Ext)](https://www.gl-inet.com/products/gl-ar300m/) war mein erster GL.iNet Router. Der Shadow ist eher sowas wie der große Bruder des [Mango (GL-MT300N v2)](https://www.gl-inet.com/products/gl-mt300n-v2/) und im Gesgensatz zum Mango bietet er 2 in der -ext Variante externen Antennen mit SMA Port, also perfekt um 'bessere' Antennen im Wohnmobil oder beim [WarDriving](https://de.wikipedia.org/wiki/Wardriving) zu benutzen.  

# Shadowapple bauen
Die Schritte sind erneut sehr gut beschrieben von SHUR1K-N: https://github.com/SHUR1K-N/WiFi-Shadowapple-Resources leider nur als Video.  

## Firmware herunterladen
Der [Hak5 Pineapple Nano/Tetra](https://docs.hak5.org/wifi-pineapple-6th-gen-nano-tetra/wifi-pineapple-nano/tetra/) ist mittlerweile eingestellt, daher wird es dafür voraussichtlich keine Aktualisierung mehr geben. Da es nicht Open Source ist, wird es vom Cloner keinen weiterentwickelten Fork geben. Ich vermute ein komplett eigenes Projekt ist erfolgversprechender als diesen weiter zu pflegen.  
OpenWrt dagegen wird stetig weiter entwickkelt. Während der Mango auf eine veraltete Version setzt kann der Shadow heute mit der aktuellsten OpenWrt Basis betrieben werden.  
Das betrifft nur die Nano/Tetra Liie, der WiFi Pineapple wird stetig erweitert. Wer 200-1500 Euro ausgeben will anstatt von 100 (Shadow plus USB-Hub und Zubehör), der bekommt ein modernes Gerät mit noch mehr Features.  

- Unter https://firmware-selector.openwrt.org/ suchen nach **AR300M16** und `GL.iNet GL-AR300M16` auswählen 
- Den Button `Sysupgrade` klicken
- Unter https://gitlab.com/xchwarze/wifi-pineapple-cloner-builds nach **GL-AR300M** suchen und die Version `19.07.7` herunterladen  

### Den Shadow in uBoot starten
Zuerst eine RJ45 Netzwerkkarte vom PC oder Laptop mit dem LAN Port des Shadow verbinden, der WAN Port darf nicht belegt sein, der USB Port sollte an diser Stelle auch noch nicht gesteckt sein.  
Danach den Stromstecker ziehen, den Reset-Button gedrückt halten und den Strom wieder anschliessen. Nach etwa 6 Sekunden leuchten die beiden grünen LED, dann den Rest-Button loslassen.  

### OpenWrt installieren (24.x und 25.x getestet)
Die Netzwerkkarte auf die IP 192.168.1.0/24, zum Beispiel mit der IP 192.168.1.2, konfigurieren.  
Der Shadow ist im Browser unter http://192.168.1.1 erreichbar. Es ist eine einfache Webseite des uBoot loaders sichtbar. Hier unter 'Choose file' die heruntergeladene Datei (heute: openwrt-25.12.0-rc3-ath79-generic-glinet_gl-ar300m16-squashfs-sysupgrade.bin) angeben und mit dem Button 'Update gl-inet firmware' bestätigen.  
Nach unter einer Minute sollte das Installieren fertig sein und es leuchten wieder beide grünen LED dauerhaft.  

### Wifi Pineapple cloner image installieren
Jetzt wieder den Strom vom Shadow trennen und nach kurzem Warten wieder einstecken. Nach etwas 2 Minuten ist der Shadow mit der OpenWrt Firmware gestartet, angezeigt druch die beiden dauerhaft leuchtenden grünen LED. Beim erneuten öffnen (oder aktualisieren) der Webseite http://192.168.1.1 erscheint die OpenWrt (LuCI -> Lua Configuration Interface) Oberfläche.  
Ein Passwort muss nicht angegeben werden, einfach 'Login' klicken. Wenn die Seite geladen ist, oben im Menü unter 'System' den Punkt **Backup/Flash firmware** auswählen.  
Unten den Abschnitt **Flash new firmware image** suchen und unter 'Browse' das zweite heruntergeladene Image (gl-ar300m-universal-sysupgrade.bin) auswählen, mit dem Button 'Upload' bestätigen.  
Den Haken bei **'Keep settings' entfernen** und unten **'Force Upgrade' anwählen**. Mit dem Button 'Continue' fortfahren.  
Nach etwa 3 Minuten sollten alle drei LED leuchten, bei mir hat es ausgereicht dass die beiden grünen wieder recht statisch ein waren.  

### WiFi Pineapple starten, danach den USB-Hub anschliessen
Die Netzwerkkarte wird jetzt auf 172.16.42.0/24, zum Beispiel mit 172.16.42.2, konfiguriert. Der Shadowapple ist unter http://172.16.42.1 zu erreichen. Auf der Seite erscheint eine Information zum initialen Setup. Während die Meldung angezeigt wird kann ein USB-Hub mit der 2. Netzwerkkarte und einem USB Stick angesteckt werden.  
Hintergrund: Beim ersten Start wird die interne Netzwerkkarte als **wlan0** eingerichtet. Wenn die 2. Netzwerkkarte zu dem Zeitpunkt bereits angeschlossen ist, dann können die Plätze vertauscht werden. Der Port an dem die 2. Netzwerkkarte angeschlossen ist sollte nach dem Setup auch nicht geändert werden.  

Zum Abschluss kurz auf 'Reset' drücken, damit das Setup ohne Wifi stattfindet.  

### WiFi Shadowapple konfigurieren
Auf der ersten Seite wird das admin (root) Passwort definiert. Einfach etwas sicheres wählen, was sich merken lässt.  
Der 'Management AP' wird auf der ersten Netzwerkkarte (intern) gestartet und bietet die Möglichkeit den Shadowapple per WLAN zu erreichen, auch während die Hauptkarte am Scannen ist.  
Den OpenAP schalte ich in der Regel aus, ist aber jedem frei gstellt. Wer sich damit verbindet ist selbst schuld.  
Die Filter Settings sollten auf 'Allow mode' gestellt werden. Hier dürfen sich nur Geräte und SSID mit dem Shadowapple verbinden, welche in der Allow Liste stehen. Im Deny Mode nimmt der Shadowapple alles entgegen, was schnell zu Chaos in der gesamten Funkreichweite führen kann.  

Am Login Fenster behalten wir den Benutzer root und geben das zuvor vergebene Passwort ein.  

Jetzt sollte der Shadowapple WAN bekommen. Die einfachste Variante ist ein DHCP versorgtes Kabel an den WAN Port anzuschliessen.  
Alternativ kann an dieser Stelle in den USB-Hub eine weitere Netzwerkkarte eingesteckt werden. Am besten ist eine Karte mit nativ unterstützten Chip, ansonsten gibt es viele Anleitungen zu diversen Karten, siehe z.B. [Troubleshooting]. Links im Menu unter 'Networking' im Abschnitt 'WiFi Client Mode' das Interface `wlan2` auswählen und mit dem Button 'scan' nach Netzwerken in der Umgebung suchen. Das eigene auswählen und das Passwort eingeben.  

Wenn der Shaddowapple Internet hat, mit SSH verbinden. Unter Linux in einem Terminal mit `ssh root@172.16.42.1` verbinden. Unter Windows mit Putty ist die Adresse dieselbe (benutzer@host). Das Passwort ist das am Anfang der Einrichtung vergebene.  

#### USB Speicher bereitstellen
Wenn am USB-Hub ein USB Stick oder eine SD-Karte mit Adapter angeschlossen ist, wird diesr mittels `wpc-tools format_sd` formatiert und dem System bereitgestellt. Das dauert eine ganze Weile, je nach Größe des Speichers. Ein 32GB Stick sollte mehr als Ausreichend sein, weniger als 4 GB sollte er nicht haben.  
Danach muss der formatierte Speicher noch bereinigt werden, mittels `rm -rf /sd/*`. Wenn das Verzeichnis danach nicht lehr ist den Befehl noch einmal wiederholen.  

#### Missing Packages unmissen.
Mit dem Befehl `wpc-tools missing_packages` werden Pakete nachgeholt, die im Ursprungsimage nicht vorhanden oder veraltet sind. Diese sind unter anderem verantwortlich dafür, dass im Recon die Ansicht automatisch aktualisiert wird.  

Die Shell sollten wir ab jetzt nicht mehr benötigen.  

### Module
Jetzt haben wir einen basis Wifi Pineapple clon. Aber mächtig wird er erst durch die Module.  
Auf der Webseite im Menü Links gibt es den Punkt 'Modules'. Mit dem Button 'Get Modules' holen wir uns eine Liste einiger bereitgestellten Module.  
Da wir uns zuvor den Speicher initialisiert haben, haben wir bei den meisten Modulen die Wahl ob wir diese auf dem Gerät oder auf SD installieren wollen. Ich empfehle immer SD, denn der Speicher des Shadow ist begrenzt. Und im Falle eines Defekt lässt sich der USB Speicher deutlich schneller tauschen.  

Die Module sind alle nicht mit Magie geschrieben. Im Grunde bieten sie Basiswerkzeuge, die man von Kali Linux oder ParrotOS kennt.  

Das Modul 'p0f' ermittelt anhand von parametern das Betriebssystem anhand eines aufgebauten Socket (IP/Port). Dsa kann zwar auch nmap, aber p0f ist deutlich schlanker. Manchmal erschreckend wie genau die Schätzung ist.  

Die Module 'Signalstrenght' und 'Site Survey' sind ncith nur für den Hobby Hacker interessant, sie können druchaus helfen die WLAN Ausleuchtung zu optimieren. Auch wenn es bessere Tools mit Karte gibt, zum Beispiel Staubsaugroboter.  

Vielleicht klingt die Beschreibung cool, aber bevor ich eines von den Tools benutze sollte ich mir über die Konsequenzen bewusst sein.  
Eines der eher destruktiven Tools ist 'Deauth', welches mittels externem Befehl den Client vom AP trennt. Da es eine Funktion im WPA/WPA2 Protokoll ist ist die einzige Möglichkeit mich davor zu schützen auf WPA3 umzusteigen. Dazu sollte man sagen dass dieses Modul nicht gerade leise ist, in der Regel bekommen die Leute mit, wenn das Streaming plötzlich abbricht. An eigenen Geräten kann man es natürlich gerne testen.  


# Wifi Pineapple und nun?
Im Dashboard sieht man zunächst nicht viel, ausser dass die CPU Last zwischen 30% und 50% schwankt, im Gegensatz zum Mango wo 50-70% 'normal' waren. Im Einsatz sind beide oft auf 100%.  
Der Punkt 'Recon' aus dem Menu ist eine grosse Hilfe. Je nach verwendete Netzwerkkarte oder zu untersuchender Umgebung wählt man hier 2,4 GHz, 5 GHz oder Both und bestätigt mit 'Start'. Ja, 6 GHz gab es zu der Zeit noch nicht, mir ist kein Chipset bekannt der das einfach unter Linux/OpenWrt unterstützt.  
Der Modus ist als Standard 'Continous' also fortlaufend. Je nach Bedarf kann ein kürzerer Zeitraum gewählt werden.  
Wenn nicht vorher gestartet, weisst die Webseite einen darauf hin, dass PineAP nicht gestartet ist und bietet gleich einen Button um da nachzuholen. Der Scan startet im Anschluss an dien Dienststart.  

## Recon - Das Suchen nach WLANs
Im unteren Teil erscheinen nach kurzer Zeit die gefundenen AP (Access Points) und wenn in Reichweite auch die damit verbundenen Clients. Es werden darunter auch Geräte außerhalb der Reichweite aufgelistet. Die sind aber gößtenteils uninteressant.  
Wir stellen uns unseren Standpunkt als Zentrum vor. Um uns herum wird ein Kreis gespannt, der die Reichweite unseres WLAN darstellt. Innerhalb dieses Kreises gibt es APs und Clients. Es können aber auch Clients in unserer Reichweite sein, aber der AP nicht oder ein AP ist im Kreis und die Clients nicht. das muss nicht physikalisch so sein, aber ein AP hat unter Umständen eine höhere Empfangs-/Sendeleistung als ein IoT Client.  

### Die Sendeleistung
In der Tabelle haben wir den Wert 'Signal', der angegeben ist in [RSSI (Received Signal Strength Indicator)](https://de.wikipedia.org/wiki/Received_Signal_Strength_Indication). Dieser wird als negativer dB Wert angegeben, wobei -30 ein sehr guter Wert ist und -80 eher schlecht. Wir können das Signal mit der Veränderung unser Position beeinflussen, in der Regel wissen wir aber nicht in welche Richtung, einfach ausprobieren.  

### Der Handshake
Bei einem Signal von schlechter als -50 können wir uns den Handshake sparen. Wenn überhaupt erhalten wir einen Teilweisen Handshake. Bei einem Wert um -30 haben wir gute Chancen einen kompletten Handshake zu bekommen.  
Der Handshake findet statt, wenn ein Client sich an einem AP anmeldedet. Damit der AP auch weiss, dass der Client das Passwort kennt wird es cryptisch ausgetauscht. Wenn ich diesen cryptischen Austausch habe, kann ich alle mir bekannten Kennworte dagegen testen udn schauen ob etwas sinnvolles dabei raus kommt.  
Stell Dir vor Du stehst vor einem Club und möchstest rein. Du nennst dem Türsteher 100 verschiedene Gerheime Handschläge. Wenn der Handschlag 101 richtig ist, lässt er Dich rein? Wohl kaum, zumal Du jedes Mal auf eine Antwort warten musst. Aber wenn Du aufnimmst wie ein Gast dem Türsteher das Passwort übergibt, dann kannst Du so lange vor dem Spiegel verschiedene Hsndshläge üben, bis es genauso aussieht ... Elegant? Nein, aber es zeigt warum Du ein komplexes Kennwort nutzen solltest anstelle eines einfach nachzumachenden.  

### Die SSID und die Mobiltelefone
WLAN AP senden Beacons (wie das Licht von einem Leuchtturm) mit der eigenen SSID aus, diese sehen wir in der Liste 'WLAN in der Nähe'. Wenn ein Mobilgerät oder Laptop dieses Beacon empfängt und die SSID gespeichert hat, dann versucht es eine Verbindung mit dem gespeicherten Passwort aufzubauen.
WLAN Clients haben die Angewohnheit alle gespeicherten Netzwerke in die Welt hinaus zu posaunen (Probe Request). Damit hoffen sie dass ein AP sich angesprochen fühlt und die Verbindung aufgebaut wird. Die Idee ist, dass man keine 100ms wartet bis ein Beacon kommt, sondern schneller eine Verbindung initiieren kann.

Jetzt stellt Euch vor Ihr habt technisch weniger Versierte Personen, die von einem Zettel SSID und Passwort ablesen und in das Mobiltelefoin eingeben. Wie oft ist es Euch passiert, dass das Passwort als SSID eingegeben wurde oder beides hintereinander? Im grunde nicth schlimm, das Telefon wird weitergereicht und der nächste gint es richtig ein -> WLAN Verbindung steht.  
Aber die falsche Eingabe wurde gespeichtert. Dasss heisst das Telefon weiss nicht, dass diese SSID nicht existiert, versucht es aber per PRobe Request zu erreichen.  

Im Wifi Pineapple habe ich im Menupunkt 'PineAP' den Block 'SSID Pool'. Der kann für gezielte attacken manuell beladen oder mittels Konfiguration 'Capture SSIDs to Pool' automatisch gefüllt werden.  
Wenn ich in dne Pool schaue sind bekannte AP Namen FRITZ!Box 7412, NETGEAR07, Dallmeyers-Backhus, ... Aber es tauchen auch Namen auf, wie "ZL-ldgdf76f45708ge0", "zu13a599#", "34522299819022680715" (das sind keine echten Werte, die habe ich aus Beobachtungen kombiniert). Der 2. Block sieht doch eher nach WiFi Passworten aus, als nach SSID.  
Leider weiss ich nicht welche nicht SSID zu welcher SSID gehört. Aber es ist ein start.  

Tipp: Löscht falsch eingetragene WLAN aus Euren Mobiltelefonen!  


# Troubleshoot

## 3. Netzwerkadapter
Als Netzwerkadapter habe ich nur einen alten `ID 0bda:8176 Realtek Semiconductor Corp. RTL8188CUS 802.11n WLAN Adapter` rumliegen. Nich toll, aber ausreichend.  
Nach dem Einstecken sagt `dmesg` zwar das etwas gefunden wurde, aber kein weiteres WLAN Interface.  
```
[   87.501464] usb 1-1.4: USB disconnect, device number 5
[   89.586368] usb 1-1.4: new high-speed USB device number 6 using ehci-platform 
```

Ein kurze Onlinesuche nach `RTL8188CUS openwrt` zeigt, dass dieser Chip vom Treiber `kmod-rtl8192cu` unterstützt wird. Mit `opkg install kmod-rtl8192cu` ist auch dieser in der Weboberfläche zu finden.  
