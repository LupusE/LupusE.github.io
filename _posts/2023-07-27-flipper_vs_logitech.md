---
status: published
published: true
layout: post
title: Flipper Zero vs. Logitech Unifying
author: Benjamin Moeller
date: 2023-07-27 22:38:03 UTC
categories: [experimente]
tags: [flipperzero]
comments: []
---

Ich versuche nach Möglichkeit meine Hardware Up-to-date zu halten. Ich finde es doof, wenn ein Firmwareupdater nur für Windows verfügbar ist. Wenn ich Zugriff auf ein Windows habe, dann installiere ich in der Regel die Logitech Unifying Software und schaue nach ob alle Geräte aktuell sind. Das geht dank USB in der Regel schnell.  
Vor einiger Zeit gab es in den News zuerst die Info, dass die Logitech Presenter anfällig sind, später wurde herausgefunden dass der verwendete Chip nRF24LU1+ von [Nordic Semiconductor](https://www.nordicsemi.com/) auch in vielen Unifying Dongles zu finden ist. Logitech hat schnell ein Firmwareupdate zugesagt und geliefert.  
Durch den ersten Absatz dachte ich das ist genug. Wenn dem so wäre, hätte ich diesen Text nicht verfasst.  

Kurz: Im Jahre 2016 haben Forscher herausgefunden, dass es per Funk extrem doof ist die Tastatureingaben zu verschlüsseln, die Maus aber unverschlüsselt einzubinden. Dazu noch, wenn die gesendeten Eingaben nicht nach Quelle verifiziert werden.  
Die Forschung sieht so aus: [GitHub - BastilleResearch/mousejack](https://github.com/BastilleResearch/mousejack#flash-a-logitech-unifying-dongle-back-to-the-original-firmware) ... Das ist im Jahre 2023 kein Thema mehr, oder? Oder?  


# Wie sicher ist gefühlte Sicherheit?

Ich behaupte über PC, IT und Sicherheit mehr zu verstehen als der durschnittliche Anwender. Ich gehe sogar so weit und behaupte ich habe einen guten Überblick darüber wo ich bewusst durch Geld oder Faulheit in meinen Systemen Sicherheitslücken habe.

Ich habe einen Flipper Zero. Das Hackertool, mit dem man angeblich Autos stehlen kann und durch jede Tür. Dazu gibt es zwei wichtige Fakten zu kennen: 1. Der Flipper ist kein magischer Zauberstab! 2. Das Internet (insbesondere auf Kurzvideo-Plattformen) lügt!  
Der Flipper besitzt eine GPIO Leiste. Zwei nRF24 Module gibt es auf Amazon für unter 10 Euro und Jumper-Kabel standen seit längerem auf meiner Einkaufsliste ...  

## Aufbau 

1. 7 Jumper-Kabel vom Baum trennen
1. nRF24 Modul nach Anleitung auf die GPIO Leiste des Flipper verbinden
1. Im Flipper Menu: 'Applications - GPIO - [NRF24]Sniffer'
1. Auf mittleren Button klicken um den Scan zu starten.

Jetzt heisst es warten. Der Flipper signalisiert mit einem weissen LED Leuchten und Vibrieren, wenn er etwas findet. Also man darf abgelenkt sein.  
In der Zwischenzeit schreibe ich etwas zu meinen Erfahrungen und der Vorgehensweise.  
Ja, damit das funktioniert sollte man eine CFW (Custom Firmware) nutzen. Es gibt für die Apps Ports, damit die Apps auch für die OFW (Original Firmware) kompiliert werden können, diese stürzen aber durch fehlende Schnittstellen oft ab.  

## Die Programme

Da das Bastille Research Team alle Programme offen zur Verfügung gestellt hat, musste nur jemand Python zo Flipper übersetzen. Das ging schnell.  
Die Programme für den Flipper sind OpenSource und seit 07.2023 über den Appstore flipc.org zu finden.  

### [NRF24]Sniffer

Was sehe ich auf dem kleinen Bernsteinfarbenden Bildschirm?  
* **Transfer rate**: 2Mbps* - 1Mbps (Toggle mit 'hoch', wenn Scan aus)
* **Sample Time**: 500ms 1000ms 1500ms 2000ms 2500ms 3000ms 3500ms 4000ms* 4500ms ... (toggle in 500ms mit 'rechts'/'links')
* **Channel**: 0 ... Zählt hoch bis 120, dann von vorne **Sniffing**: No*/Yes (Toggle mit mittlerem Button)
* **Found**: 0* Gefundene Paket **Unique**: 0* Bei Dopplungen die einzigartigen Adressen
* **Address,rate** Die aktuell gescannten Werte

* = Defaultwert

Die **Transfer rate** von 2Mbps kann aktiviert bleiben, nur bei alten Geräten, viel Störsignale oder langer Entfernung würde ich auf 1Mbps stellen.  
Die **Sample Time** bestimmt wie lange gescant wird, bevor automatisch ein Kanal weiter gesprungen wird. Mit 1000ms habe ich bisher Erfolge erzielt, wobei ich meistens mehr als einen Durchlauf habe. Vielleicht sind 2000ms besser.  

Der Sniffer legt die gefundenen Adressen unter `apps_data/nrf24_sniffer/addresses.txt` auf der SD karte ab, im Format `0A109A4AE8,2`. Vor dem Komma die Adresse an die gesendet wird, das hinter die Transfer rate.  

Aus dieser Datei liesst die App 'Applications - GPIO - [NRF24]Mouse Jacker`.

### [NRF24]Mouse Jacker

Dieses ist das Tool, mit dem man cool auf TikTok aussieht. Mit den zuvor gesammelten Adressen, wenn der Dongle ungepatched ist, kann ich remote Tastaturbefehle injecten. Also ein Wireless BadUSB ausführen.  
Wenn mehr als eine Adresse gefunden wurde, können diese durchgescrollt werden, vor Ausführung des BadUSB Scripts. Man sollte bei mehreren gefundenen Adaptern sicher sein, das Script auf dem richtigen Rechner auszuführen. An dieser Stelle einne lieben Gruss an meine Nachbarn, ich hoffe Eurer Dongle ist gepatched.  
Die FlipperZero-BadUSB fähigen Ducky-Scripte sollten natürlich schon auf dem Flipper liegen. Warum ich das so deutlich schriebe benötigt einen eigenen Artikel. Gesucht wird im BadUSB Ordner der SD Karte.  

Auf meinen eigenen Systemen habe ich das Script [Char_Test_ALTSTRING](https://github.com/UberGuidoZ/Flipper/blob/main/BadUSB/Char_Test_ALTSTRING.txt) ausgeführt und mir ist aufgefallen dass einige Zeichen mehrfach gesendet werden. Als ob eine Taste ca. 5 Sekunden nicht losgelassen wird.  
Das sieht bei einem ausgegebenen String auf dem Bildschirm komisch aus, und verhindert in einem Payload unter Umständen die Ausführung.  

Tipp: Die Adresse muss nicht jedes mal neu gefunden werden. Wenn sie einmal bekannt ist, kann diese beliebig oft auf dem Empfänger wiederverwendet werden. Vermutlich bis die Maus neu gepaired wird.  

### [NRF24]Scanner

Diese App gibt deutlich mehr Infos dazu aus, was so empfangen wird. Ich bin oft irritiert und bin der Meinung die Namen vom Sniffer und dem Scanner sollten getauscht sein. Aber ich bin nicht der Entwickler.  

## Die Hardware

Es gibt die kleineren nFR24 Module mit aufgedrucker Antenne auf dem Board und die längeren mit angeschraubter Antenne.  
Die kleineren Boards sollen laut Internet eine Reichweite von etwa 30 m haben und eine maximale Stromaufnahme von etwa 72mA/3,3V. -> nRF24L01+  
Die grossen Boards dagegen haben laut Datenblatt 1100m Reichweite, welche mit max. 400 m bisher gemessen wurde und eine maximale Stromaufnahme von 154mA/3,3V. Also deutlich mehr Belastung auf dem Akku des Flipper. -> nRF24L01+PA+LNA  
Es gibt Module, die extra für den Flipper Zero gebaut werden, z.B. das [TehRabbit Modul](https://rabbit-labs.com/). Diese Starten bei entsprechender Qualität bei 40-50 USD. Je nach Funktionsumfang, zum Beispiel als externes CC1101 Modul, mit ESP32, ... können sie auch mehr oder weniger über 100 USD gehen.  

Ich habe mich für die Variante mit externer Antenne entschieden, denn die geschraubte Antenne lässt bei Bedarf auch mehr Leistung/Reichweite durch eine Richtantenne zu.  

Bei den Jumperkabeln kann man nicht viel falsch machen. 20 cm sind gerade noch okay, 5 cm halte ich für ideal. Besser ist natürlich ein Board um die Verbindung bereitzustellen.  
Diese Boards habe ich auch mit 5V und einem Spannungswandler gesehen. Das hat optisch den Vorteil das ich nur eine Seite der 2-geteilten GPIO Leiste belege, aber Spannungswandeln ist immer Verlustbehaftet.  


# Erfolge

Ich habe verschiedene Unify Reciver getestet, jeder C-U0007 war angreifbar. Dokumentiert habe ich nicht alle Tests, aber:

| Type | Version | Firmware | USB ID |
| --- | --- | --- | --- |
| 2x Unifying Receiver | C-U0007 | 12.03.B0025 | 046d:C52B |

Tipp: Die Firmware des Unifying Reciever kann unter Linux mit `solaar show` anzeigt werden.  

Der C-U0008 Dongle hat einen TI Chip und kann für das MouseJacking nicht verwendet werden, obwohl er auch auf 2,4 GHz überträgt. Die Schwachstelle lässt sich auf verschiedene Wireless HID Geräte von Logitech, Dell, Lenovo und andere anwenden. Siehe Projektseite.

Aufgrund von Tests mit BadUSB Exfiltration per SPI habe ich meinen Windows Gaming PC reaktiviert. Dieser war mein erstes Ziel in diesem Experiment. Hätte ich mit Linux begonnen, hätte ich mich vermutlich über die Ausgabe von 10 Euro geärgert. Siehe Abschnitt 'Beobachtungen'.  

# Beobachtungen

* Obwohl die Logitech Unifying Software sagt meine Geräte sind Aktuell, sind die Dongles angreifbar.
  Es gibt keinen einen Hinweis auf die Sicherheitslücke. Ich muss bewusst das DFU Tool herunterladen, die [passende Firmware finden](https://github.com/Logitech/fw_updates) und anwenden. Fast gar nicht kompliziert.
* Die gleichen Unifying Receiver weden an Windows innerhalb von 5 Minuen erkannt. Unter Linux auch nach Stunden des Scannens nicht.
  Offensichtlich schützen ein paar freiwillige Nerds im Keller das System besser als zwei Multimillionen-Unternehmen zusammen. 
* Ich habe nicht herausgefunden warum ich den Stick nach Bastille Research erst flashen sollte. Bei mir sind sie ohne Aufwand direkt angreifbar.
* Es handelt sich um eine Injection! Ich kann nicht ohne weiteres Tastatureingaben auslesen. Das bitte bei der Gefahrenbewertung beachten. Das pure Sniffen wäre passiv, das Ausführen von Tastatureingaben ist sichtbar. Ich kann mit dieser Attacke auch nicht an dem Login Screen eines Systems vorbei agieren. Sperrt Eure Bildschirme!

Die gute Nachricht ist, dass es den neuen [Bolt Adapter von Logitech](https://www.logitech.com/de-de/products/mice/logi-bolt-usb-receiver.html) nicht betrifft, da alle Bluetoothverbindungen nur per bekannten Bluetooth-Lücken angreifbar sind.


# Weitere Links

* Bastille docs - https://github.com/BastilleResearch/mousejack/tree/master/doc
* Flipper Forum Discussion - https://forum.flipperzero.one/t/how-does-flipper-zero-connect-to-a-dongle/17463

