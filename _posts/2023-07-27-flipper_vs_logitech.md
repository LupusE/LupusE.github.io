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
Durch den ersten Absatz dachte ich das wäre genug. wenn dme so wäre hätte ich diesen Text nicht verfasst.  

Kurz: Im Jahre 2016 haben Forscher herausgefunden, dass es per Funk extrem doof ist Tastatureingaben zwar zu verschlüsseln, die Maus aber unverschlüsselt einzubinden. Dazu noch, wenn die gesendeten Eingaben nicht weiter verifiziert werden.  
Die Forschung sieht so aus: [GitHub - BastilleResearch/mousejack](https://github.com/BastilleResearch/mousejack#flash-a-logitech-unifying-dongle-back-to-the-original-firmware) ... Das ist im Jahre 2023 kein Thema mehr, oder? Oder?  


# Wie sicher ist gefühlte Sicherheit?

Ich behaupte über PC, IT und Sicherheit mehr zu verstehen als der durschnittliche Anwender. Ich gehe sogar so weit und behaupte ich habe einen guten Überblick darüber wo ich bewusst durch Geld oder Faulheit in meinen Systemen Sicherheitslücken habe.

Heute habe ich einen Flipper Zero. Der Flipper besitzt eine GPIO Leiste. Zwei nRF24 Module gibt es auf Amazon für unter 10 Euro und Jumper-Kabel standen seit längerem auf meiner Einkaufsliste ...  

## Aufbau 
1. 7 Jumper-Kabel vom Baum trennen
1. nRF24 Modul nach Anleitung auf die GPIO Leiste des Flipper verbinden
1. Im Flipper Menu: 'Applications - GPIO - [NRF24]Sniffer'
1. Auf mittleren Button klicken um den Scan zu starten.

Jetzt heisst es warten. Der Flipper signalisiert mit einem weissen LED Leuchten und Vibrieren, wenn er etwas findet. Also man darf abgelenkt sein.  
In der Zwischenzeit schreibe ich etwas zu meinen Erfahrungen und der Vorgehensweise.  

## Die Programme

Da das Bastille Research Team alle Programme offen zur Verfügung gestellt hat, musste nur jemand Python zo Fliper übersetzen. Das ging schnell.  
Die Programme für den Flipper sind alle OpenSource und seit 07.2023 über den Appstore flipc.org zu finden.  

### [NRF24]Sniffer

Was sehe ich auf dem kleinen Bernsteinfarbenden Bildschirm?  
* **Transfer rate**: 2Mbps* - 1Mbps (Toggle mit 'hoch', wenn Scan aus)
* **Sample Time**: 500ms 1000ms 1500ms 2000ms 2500ms 3000ms 3500ms 4000ms* 4500ms ... (toggle in 500ms mit 'rechts'/'links')
* **Channel**: 0 ... Zählt hoch bis 120, dann von vorne **Sniffing**: No*/Yes (Toggle mit mittlerem Button)
* **Found**: 0* Gefundene Paket **Unique**: 0* Bei Dopplungen die einzigartigen Adressen
* **Address,rate** Die aktuell gescannten Werte

* = Defaultwert

Die **Transfer rate** von 2Mbps kann aktiviert bleiben, nur bei alten Geräten, viel Störsignale oder langer Entfernung würde ich auf 1Mbps stellen.  
Die **Sample Time** bestimmt wie lange gescant wird, bevor automatisch ein Channel weiter gesprungen wird. Mit 1000ms habe ich bisher Erfolge erzielt, wobei ich meistens mehr als einen Durchlauf habe. Vielleicht sind 2000ms besser.  

Der Sniffer legt die gefundenen Adressen unter `apps_data/nrf24_sniffer/addresses.txt` auf der SD karte ab, im Format `0A109A4AE8,2`. Vor dem Komma die Adresse an die gesendet wird, das hinter die Transfer rate.  

Aus dieser Datei liesst die App 'Applications - GPIO - [NRF24]Mouse Jacker`.

### [NRF24]Mouse Jacker

Dieses ist das Tool, mit dem man cool auf TikTok aussieht. Mit den zuvor gesammelten Adressen, wenn der Dongle ungepatched ist, kann ich remote Tastaturbefehle injecten. Also ein Wireless BadUSB ausführen.  
Wenn mehr als eine Adresse gefunden wurde, können diese durchgescrollt werden, vor Ausführung des BadUSB Scripts. Man sollte sich bei mehreren gefundenen adaptern sicher sein das Script auf dem richtigen Rechner auszuführen. An dieser Stelle einne lieben Gruss an meine Nachbarn, ich hoffe Eurer Dongle ist gepatched.  
Die FlipperZero-BadUSB fähigen Ducky-Scripte sollten natürlich schon auf dem Flipper liegen. Warum ich das so deutlich schreibe, benötigt einen eigenen Artikel. Gesucht wird im BadUSB Ordner der SD Karte.  

Auf meinen eigenen Systemen habe ich das Script [Char_Test_ALTSTRING](https://github.com/UberGuidoZ/Flipper/blob/main/BadUSB/Char_Test_ALTSTRING.txt) ausgeführt und mir ist aufgefallen dass einige Zeichen mehrfach gesendet werden. Als ob eine Taste ca. 5 Sekunden nicht losgelassen wird.  
Das sieht bei einem ausgegebenen String auf dem Bildschirm komisch aus, verhindert aber in einem ein Payload unter Umständne die Ausführung.  

Tipp: Die Adresse muss nicht jedes mal neu gefunden werden. Wenn sie einmal bekannt ist, kann diese beliebig oft auf dem Empfänger wiederverwendet werden. Vermutlich bis die Maus neu gepaired wird.  

### [NRF24]Scanner

Diese App gibt deutlich mehr Infos dazu aus, was so empfangen wird. Ich bin oft irritiert und bin der Meinung die Namen vom Sniffer und dem Scanner sollten getauscht sein. Aber ich bin nicht der Entwickler.  

## Die Hardware

Es gibt die kleineren nFR24 module mit Antenne auf dem Board und die längeren mit angeschraubter Antenne.  
Die kleineren Boards sollen laut Internet eine Reichweite von etwa 30m haben und eine maximale Stromaufnahme von etwa 72mA/3,3V. -> nRF24L01+  
Die grossen Boards dagegen haben laut Datenblatt 1100m Reichweite, welche mit max. 400m bisher gemessen wurde, und eine maximale Stromaufnahme von 154mA/3,3V. Also deutlich mehr Belastung auf dem Akku des Flipper. -> nRF24L01+PA+LNA  
Dann gibt es noch Module, die extra für den Flipper Zero gebaut werden, z.B. das [TehRabbit Modul](https://rabbit-labs.com/). Diese Starten oft bei 40-50USD. Je nach Funktionsumfang zum beispiel externes CC1101 Modul, ESP32, ...) können die auch mehr oder weniger über 100USD gehen.  

Ich habe mich für die Antennen Variante entschieden, denn die geschraubte Antenne lässt bei Bedarf auch mehr Leistung/Reichweite durch eine Richtantenne zu.  

Bei den Jumperkabeln kann man nicht viel falsch machen. 20cm sind gerad enoch okay, 5cm wären wohl ideal. Besser ist natürlich ein Board um die Verbindungen bereitzustellen.  
Diese Boards habe ich auch mit 5V und einem Spannungswandler gesehen. Das hat optisch den Vorteil das ich nur eine Seite der 2-geteilten GPIO Leiste belege, aber Spannungswandeln ist immer Verlustbehaftet.  


# Erfolge
| Type | Version | Firmware | USB ID |
| --- | --- | --- | --- |
| 2x Unifying Receiver | C-U0007 | 12.03.B0025 | 046d:C52B |

Tipp: Die Firmware des Unifying Reciever kann unter Linux mit `solaar show` anzeigt werden.  

Der C-U0008 Dongle hat einen TI chip und kann hier nicht verwendet werden, obwohl er auch auf 2,4GHz überträgt. Das vorgehen lässt sich aber auf verschiedene Wireless HID Geräte von Logitech, Dell und andere anwenden. Siehe Projektseite.

Aufgrund von Tests mit BadUSB Exfiltration per SPI habe ich meinen Windows Gaming PC reaktiviert. Dieser war mein erstes Ziel dieses Versuchs. Hätte ich mit Linux begonnen, hätte ich mich vermutlich über die Ausgabe von 10 Euro geärgert. Siehe Abschnitt 'Beobachtungen'.  

# Beobachtungen
* Obwohl die Logitech Unifying Software sagt meine Geräte sind Aktuell, sind die Dongles angreifbar.
  Es gibt keinen einen Hinweis auf die Sicherheitslücke. Ich muss bewusst den DFU Updater herunterladen, die [passende Firmware finden](https://github.com/Logitech/fw_updates) und anwenden. Fast gar nicht kompliziert.
* Die gleichen Unifying Receiver weden an Windows innerhalb von 5 Minuen erkannt. Unter Linux auch nach Stunden des Scannens nicht.
  Offensichtlich schützen ein paar freiwillige Nerds im Keller das System besser als zwei Multimillionen-Unternehmen zusammen. 
* Ich habe nicht herausgefunden warum ich den Stick nach Bastille Research erst flashen sollte. Bei mir sind sie ohne Aufwand angreifbar.
* Es handelt sich um eine Injection! Ich kann nicht ohne weiteres Tastatureingaben auslesen. Das bitte bei der Gefahrenbewertung beachten. Das pure Sniffen wäre passiv, das Ausführen von Tastatureingaben ist sichtbar. Ich kann mit dieser Attacke auch nicht an dem Login Screen eines Systems vorbei agieren. Sperrt Eure Bildschirme!

Die gute Nachricht ist, dass es den neuen [Bolt Adapter von Logitech](https://www.logitech.com/de-de/products/mice/logi-bolt-usb-receiver.html) nicht betrifft und auch alle Bluetoothverbindungen nur per den bekannten Bluetooth Lücken angreifbar sind.


# Weitere Links
* Bastille docs - https://github.com/BastilleResearch/mousejack/tree/master/doc
* Flipper Forum Discussion - https://forum.flipperzero.one/t/how-does-flipper-zero-connect-to-a-dongle/17463

