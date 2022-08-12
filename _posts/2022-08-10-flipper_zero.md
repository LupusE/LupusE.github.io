---
status: published
published: true
layout: post
title: Flipper Zero
author: Benjamin Moeller
date: 2022-06-12 21:14:03 UTC
categories: [experimente]
tags: [produkte]
comments: []
---

Um Mitte 2020 herum haben ein paar Entwickler gedacht man könnte ein paar Antennen und einen kleinen Prozessor mit einem kompakten Display in ein Tamagotchi Gehäuse stecken und so verschiedenste 'Pentest Tools' handlicher machen.  
Da das aber Entwicklung, und somit Geld uns Zeit kostet, haben sie die Idee auf [Kickstarter](https://www.kickstarter.com/projects/flipper-devices/flipper-zero-tamagochi-for-hackers) im August 2020 angeboten. Das bedeutet sie schrieben was sie vorhaben, aber anstelle einem Banker einen Finanzierungsplan vorzulegen sucht man verrückte (interessanter Weise 'Backer' genannt) mit zu viel Geld aus dem Internet. Mein Bruder ist so einer, aufgrund der Idee hat er 232$ in den Topf geworfen, ohne zu wissen ob das Produkt jemals kommen wird. So wie viele Andere auch und anstelle der mindestens 60.000 USD kamen knapp unter 5 Mio zusammen.  

Dem letzten Fakt ist es wohl auch zu verdanken, dass das Projekt diverse Krisen überwunden hat. Corona/Lockdown, Chipmangel und querliegende Containerschiffe (Evergreen im Suez Kanal), eine heftige Unterhaltung über Ländergrenzen (Russland/Ukraine) ...  Die Entwicklung und Produktion findet zu in HongKong (Shzenen) statt. Das Team ist auch Russisch, was für viele Spekulationen gesorgt hat.  
An dieser Stelle möchte ich erwähnen, dass nach dem sogenannten '[Hacker Manifest](https://www.ccc.de/hackerethics)' der Glaube, das Geschlecht, Alter, Herkunft, Hautfarbe, Rasse und so weiter keine Rolle spielen. Da wir uns hier auf einem sehr technischen Gebiet befinden und vermutlich viele der beteiligten zur Gruppe 'Hacker' gezählt werden können, denke ich dass die politische Situation in einer parallelwelt stattfindet. Also nicht für das Projekt relevant ist. Das Hackermanifest wird z.B. erwähnt im Film '[Hackers](https://www.imdb.com/title/tt0113243/)' von 1995.  

Von vorne herein war klar, dass das Projekt Open Source wird. Dabei hat das Unternehmen 'Flipper Devices Inc.' die Quellen auf GitHub zeitweise auf 'privat' gestellt, weil sie durch zu viel Unterstützung nicht mehr mit den Kernaufgaben voran kamen. Auch das hat für Spekulationen geführt, man behauptete zum Beispiel dass das Team sich mit dem Geld abgesetzt hätte.  
Die Flipper Devices Inc. war zu jeder Zeit so nett und hat Updates gegeben und über Entwicklungsmeilensteine informiert. Nicht oft, aber fast immer mit interessanten Einblicken in die Entwicklung und Produktion. Das ist für so eine Kampagne in dieser Situation nicht selbstverständlich. Es gab viele Kritiker, Zweifler und negative Stimmen. Aber:  
Am Ende gab es den [Flipper Zero](https://flipperzero.one/).

Da mein Bruder nun Mitte 2022 2 Flipper hatte und wir und zwischenzeitlich viel darüber unterhalten haben, hat er mir einen Geschenkt. Deshalb? Ich weis es nicht, auf jeden Fall: Vielen Dank!

# Was ist der Flipper Zero?

Wie gesagt erinnert das Äussere sehr an einen Tamagotchi. Man sieht nur ein 1,4" Display, welches mit 64x128 Pixeln monochrome auflöst. Rechts daneben ein 4-Wege 'Joypad' mit bestätigungsbutton und einen 'Zurück' Button.  
Oben hat man 18 Löscher für 'Jumper Kabel'. Rechts befindet sich ein IR-Fenster, wie bei Fernbedienungen. Links eine USB-C Schnittstelle zum Laden und für die Kommunikation mit einem PC oder Telefon. Unten gibt es einen SD Karten Slot. Auf der Rückseite gibt es drei iButton Kontakte.  

Schauen wir einmal genauer rundherum:

## Das Display

Das Display ist bernstein Hintergrundbeleuchtet und auch bei direkter Sonneneinstrahlung sehr gut zu lesen. Wenn der Flipper gerade nicht benutzt wird gibt es niedliche Animationen von ... einem Delfin.  
Unterstützt wird die Anzeige für verschiedene Stati von einer LED unten rechts neben dem Display.  

## Das IR Fenster

Es gibt schon lange das Projekt '[TV-B-Gone](https://de.wikipedia.org/wiki/TV-B-Gone)'. Eine kleine Platine, die auf Knopfdruck alle bekannten 'Power' codes per IR (Infrarot) sendet. Damit sollen sich z.B. im Pub die TV ausschalten lassen.  
Dieses Gerät ist ein schönes Spielzeug, aber nicht einfach erweiterbar, und mit kaum Lerneffekt. Zudem ist der Prozessor sehr klein, so dass nur einfachste Befehle funktionieren.  
Im [Blog](https://blog.flipperzero.one/infrared/) des Flipper lernen wir sehr komprimiert, wie ein IR Signal aufgebaut ist, wlechen Sender und Empfänger der Flipper vernwendet. Und vor allem, dass eine TV Fernbedienung deutlich einfacher ist als das signal eines AC (Air Conditioner/Klimaanlage).  
Kurzgesagt:  
Eine TV Fernbedienung sendet ein IR Signal, welches generell aus zwei Teilen besteht. Zuerst das Protokoll, dann den Steuerbefehl. Da ein Teil immer gleich ist und keine Verschlüsselung stattfindet, ist es im Verhältnis einfach zu analysieren.  
Ein AC dagegen hat auf der Fernbedienung oft ein Display. Da sie aber keine Daten empfängt, sendet sie nicht nur den Befehl '1°C wärmer', sondern immer den gesamten Status der Fernbedienung. Das Datenpaket ist also deutlich breiter oder länger.  
Erklärung: Wenn ich ansonsten ausserhalb der Sichtweite von 20° auf 25° stelle und innerhalb der Sichetweite von 25° auf 26°, würde der AC nuf 21° erhöhen obwohl auf der Fernbedienung 26° steht ... Das ist der Grund, warum die Fernbedienung immer alle Daten sendet um 'ohne bidirektionale Kommunikation synchron' zu bleiben. Ein TV macht einfach ein lauter, sobald sich die Fernbedienung in sichtweite befindet und zeigt es in den meisten Fällen sogar direkt an.

Im Gegensatz zum zuerst genannten Gerät und deren Alternativen kann der Flipper sowohl direkt von einer Fernbedienung lernen als auch durch Datenbanken aus dem Internet aufgefüllt werden. Im Menü muss dabei unterschieden zwischen 'Universal Remotes' (Sende alle bekannten Codes für Aktion x nacheinander) und 'Saved Remotes' (lese Konfiguration einer Fernbedienung aus der Datenbank).

Was mich persönlich stört ist der Umstand, dass in den Bezeichnungen Das Modell der Fernbedienung und die Modelle der TV oft durcheinander geworfen werden. nicht nur im Flipper Projekt, bei allen IR Datenbanken.  
Für die normalen Tasten ist es relativ einfach, einige Fernbedienungen beherrschen aber auch die Steuerung anderer Geräte. Daher ist es durchaus sinnvoll zu definieren für welches Gerät ich 'einprogrammiert' habe. aber das ersetzt nicht die Angabe des Fernbedienungsmodell.  

Meine Idee ist, dass der Code abgespeichert wird mit folgenden Informationen:  
`[Funktion ] - [Protocol] - [Steuercode] - [Fernbedienung] - [Gerät] - [Typ]`  

* Funktion - Power, Volup, Voldn, Chup, Chdn, ...
* Protocol - NEC, Samsung, ...
* Steuercode - Irgendwas in Hex
* Fernbedienung - Hersteller und Modell
* Gerät - Hersteller und Modell
* Typ - TV, AVR, BD, DVD, AC, ...

Da die IR Codetabellen in der Regel Textdateien sind, gibt es einige Github Verzeichnisse für verschiedene Projekte, welche mal besser und mal schlechter dedupliziert sind.

## Die GPIO Buchse

Mittels GPIO kann man mit dem Flipper so ziehmlich alles nachbauen, was man mit dem Arduino schon konnte und ein wenig mehr. Das Thema ist so komplex, dass es mindestens einen, vermutlich aber deutlich mehr eigene Blog Artikel benötigt.  
Man kann nicht nur Jumperkabel stecken, sondern auch ganze Platinen. Durch den Pinabstand von 2,75mm sehr universell. Aus der einfachen Steckerleiste werden dann Sender und Empfänger für Bluetooth, WLAN, Zigbee, nRF24, ... Diese Boards benötigen aber am besten eine eigene Firmware mit einer API. Der Speicher im Flipper Zero ist begrenzt.  

## Die USB Schnittstelle

Das Gerät ist noch ganz jung und Open Source. Das bedeutet es gibt oft und viele Aktualisierungen. Es gibt verschiedene Wege diese zu installieren. Mein favorisierter Weg ist das Aufrufen des Helper 'qFlipper', den Flipper erkennen zu lassen und dann einfach auf 'Install' klicken.  
Es ist auch möglich über USB auf das GPIO Panel zuzugreifen und den Flipper zum Programmer zu machen. Später.

## Die SD Karte

Der Flipper hat einen Speicher von etwa einem MB. Die Firmware ist aktuell ca. 800KB gross. Das bedeutet man hat einen theoretischen Nutzspeicher von 200KB. dieser Blog Artikel ist shcon größer. Die Lösung ist eine SD Karte.  
Wie auch beim Display war bei der SD karte der geringe Stromverbrauch massgebend, daher greift man auf diese per SPI und nicht per SPIO auf die Karte zu. Das ist wichtig, wenn man eine Karte kauft. Denn SPIO können alle, SPI ist nicht zwangsläufig implementiert.  Der Flipper kann Karten bis 512 GB lesen, aber das macht irgendwann keinen Spass mher, das Team empfiehlt Karten bis 32 GB größe zu nutzen.  
Auf die Karte kommen auch die Datenbanken. Eigentlich sind 'die Datenbanken' nur textdateien mehr ode rminder sinnvoll soetiert in Ordnern. Gerade beim ersten Einrichten sollte man die SD Karte lieber aus dem Flipper nehmen und am favorisierten Desktop bearbeiten.  
Es gibt spezielle Datenbanken für IR Codes, es gibt SubGHz Protokolle, NFC Wörterbücher ... Dabei ist immer zu beachten: Manchmal ist weniger mehr. Jeder Eintrag kostet Rechenzeit.  

## Der iButton

Der iButton ist in einigen Ländern recht gängig als Zugangssystem. Zumindest in Deutschland ist das nicht der Fall, man trifft diese nur sehr selten. Ich habe noch nie eines in echt gesehen.

# Ist das alles?

Von außen macht der Flipper schon einiges her. Es gibt noch mehr im Innenleben. Wenn ich ihn beschrieben soll, dann sage ich 'Ein Tamagotchi mit vielen Antennen'. Diese sieht man nicht, da sie für drei Bereiche sind: SubGHz, RFID, NFC.  

## Was ist SubGHz?

Viele haben ein Auto mit Fernbedienung für die Zentralverrieglung. Einige haben eine weitere Fernbedienung für das Garagentor. Auf beiden steht eine Frequenz, meist irgendwas um die 400 oder 880 MHz. -> Unter 1GHz = SubGHz ...  
Bluetooth findet im 2,4GHz Band statt und WLAN im 2,4GHZ sowie 5GHz Band. Diese fallen also aus der Zuständigkeit des Flipper heraus. Wobei er ein BLE (Bluetooth Low energy) Modul hat um mit Handys zu sprechen ... anderes Kapitel.

Ich kann also den Flipper starten, im Menü 'Sub-GHz' raussuchen und mit dem 'Frequenz Analyzer' was in meiner Umgebung so ab geht. Dabei zeigt der 'Frequenz Analyzer' an, wenn er etwas erkennt was ein Signal sein könnte und gibt dazu die Stärke an. Die Stärke steht als RSSI dort, also nicht die absolute Stärke in dB, sondern viel mehr die 'Nutzstärke' über dme Grundrauschen.  
Bekannte Signale kann ich dann mit 'Read' lesen. Unbekannte Signale kann ich mit 'Read RAW' aufnehmen und zur Analyse speichern oder direkt wieder abspielen.  

### Ich kann damit Autos knacken?

Halt stopp. Abgesehen davon, dass das höchst illeal wäre: Nein.  
Zunächst einmal hat ein Auto heutzutage einen sogenannten Rolling Code. Das bedeutet wenn die Tür geöffnet wurde, dann wechseln Sender und Empfänger den Code. Wenn ich genug dieser Codes sammeln würde und mich mit Mathematik auskenne, dann könnte ich rein theoretisch den nächsten Code erraten. Dazu brauche ich aber mehr als einen zufällig aufgeschnappten RAW Code zum Parkplatz des Supermarkt. Und wenn ich einen Schlüssel bekomme und so oft drauf drücke, wie notwendig wäre, dann ist die Chance sehr hoch, dass sich der Schlüssel und das Fahrzeug desynchronisieren...  
Das Flipper Projekt steht dafür ein, dass Rolling Codes nicht implemnetiert werden. Da es eine Open Source Plattform ist kann das theoretisch jeder selbst, aber wenn ich diese Fähigkeiten habe kann uahc auch andere Empfänger/Sender kaufen oder bauen. wir sind durch den Flipper kein Stück unsicherer als zuvor.  

## NFC

Wie bei SubGHz kann auch auch NFC Karten auslesen, speichern und 'abspielen'. Dabei gibt es diverse standards und noch nicht alle werden aktuell unterstützt. Hier arbeitet das Team sehr daran alle möglichen Kartentypen zu erkennen.  

### Aber Bankkarten kann ich damit Hacken?

Halt stopp! Wieder Nein.  
Eine Bankkarte hat zwei Bereiche. Einen lesbaren und einen sicheren. Der Lesbare enthält solche informationen, wie die Kontonummer, BLZ, das Ablaufdatum, ... Grob gesagt: maximal das was auf der Karte gedruckt ist. Wenn eine Transaktion stattfindet, dann gibt das Terminal einen Wert an die Karte. Die Karte berechnet eine Antwort und gibt diese an das Terminal zurück... Keiner weis was in der Karte passiert und wie die Berechnung stattfindet (stark vereinfacht). 
Das Terminal kann bei der Bank anfragen ob die beiden Werte richtig sind, ohne je zugriff auf den sicheren Bereich gehabt zu haben.

Wenn ich etwas Clonen kann, dann vielleicht die Zutritskarte zu meinem Büro. Aber will ich das bei den ganzen Kameras riskieren?

## RFID

RFID hat einen ähnlichen Zweck, wie NFC, nur für einen weiteren Wirkungsbereich. Während NFC oft zur Authentifizierung einer Person eingesetzt wird, werden RFID als zugangskontrolle oder in der Logistik zum Identifizieren von Lieferungen eingesetzt.  
Auch hier hilft das Blog wieder: https://blog.flipperzero.one/rfid/

## Die Firmware

Die Firmware ist das Betriebssystem des Flipper. dieses ist aktuell noch in starker entwicklung. 
Dabei scheint eines der Hauptaufgaben der Entwickler zu sein, auszusortieren was illegal ist und schauen was verwendbar ist. Dabei gibt es keine Grauzone, denn wenn etwas fragwuerdig ist, gibt es genug Anfragen,die sicher umgesetzt werden können.  

Wie bereits geschrieben ist die Firmware auf einem sehr kleinen Speicher untergebracht, das limitiert auch die Möglichkieten. Eine der wichtigsten Entwicklungen ist altuell der ELF Loader, mit dem Plugins von der SD Karte geladen werden können. Das erhöht den Lese-/Schreibzugriff auf der Karte und damit die IO Last auch auf der CPU. Aber ich denke dennoch dieses wird ein Durchbruch, wnen man eigene Projekte nicht immer komplett kompilieren muss.  

Die Firmware liegt auf GitHub und kann einfach kompiliert werden. Es gibt seit dieser Woche eine .vscode Unterstützung, aber unter Linux ist es deutlich einfacher.  

Beispiel Kali Linux 2022.2:
* `apt install git openocd clang-format-13 dfu-util protobuf-compiler gcc-arm-none-eabi`
* `git clone --recursive https://github.com/flipperdevices/flipperzero-firmware.git`
* `cd flipperzero-firmware`
* `./fbt`
* Bei Fehlern lassen die sch relativ unkompliziert lösen.
* unter `/dist/` liegt die Datei `flipper-z-{target}-full-{suffix}.dfu`
* die .dfu mit `./qFlipper` installieren (Button [install from file])

## Die Dokumentation

Hat Lücken. Das bringt es auf den Punkt.  
Bis zur Firmware 1.0 wollen sie das aber beheben. Aktuell gibt es so viele Änderungne in den APIs, dass eine offizille Dokumentation nicht nachzupflegen wäre.  

Der Tipp, wie man eigene Progrramme schreibt: Es ist OpenSource. Schau Dir an was schon existiert.


# Ist das nicht illegal?

Der Flipper Zero selbst vereint nur diverse Scanner. Die Wellen fliegen um uns herum durch den Äther und können aufgenommen werden. Sobald ich versuche diese Aufnahme zu analysieren ist es das gleiche, als wenn ich mit einem Dietrich an Deiner Tür stehe und versuche es zu knacken. Das ist Straffbar, egal wie erfolgreich ich bin.  
Die Original Firmware legt größten Wert darauf 'sauber' zu sein, also weder das Auslesen von Bankkarten zu ermöglichen, noch vorberechnete Rolling Codes bereitzustellen oder überhaupt vom Gerät einen Rolling Code errechen zu lassen.  

Leider sieht man im Forum oft 'Ich bin Noob, wie kann ich auf xyz zugreifen?'. Die haben sich vorgestellt auf dem Supermarktparkplatz kurz einen Tastendruck mitzuschneiden und dann jedes beliebige Auto zu öffnen.  
Das Resultiert darin, dass es vielen zu aufwändig ist und es gibt mittlerweile Marktplätze für gebrauchte Flipper.  

Also nein, der Flipper ist nicht Illegal. Er ist auch nicht entwicklet worden für illegale Aktivitäten. Sicher kann man im Rahmen eines angemeldeten/erlaubten Pentesting verschiedene Vektoren ausprobieren, die vorher nicht so einfach/handlich möglich waren. Auch dabei muss man sich aber zunächst mit der Materie befassen und die Grundlagen lernen. Es reicht nicht den Flipper hinzuhalten und auf magischer Weise ist jedes Tor offen. Und wie zuvor erwähnt, wer das kann, der konnte es auch vorher mit relativ geringen Hürden.  

## Und wenn ich nichts kaputt mache?

Stellen wir uns einen gut besuchten Pub vor, es ist gerade Bundesliga. Natürlich rundherum viele begeisterte, die auch lautstark 'ihrem' Verein zujubeln, so dass man es im Stadion hört. Ich will eigentlich nur gemütlich mein Guinness geniessen und vielleicht über ein Projekt mit einem gleichgesinnten sprechen. Was liegt näher als den Flipper rauszuholen und per 'Universal Remote' den TV abzuschalten?  
Auch wenn ich dadurch sicher nicht in das Gefängniss komme, so ist es nicht ratsam wenn der Barkeeper oder ein Fan herausfindet, dass du die 2. Fernbedienung in der Hand hälst. Vielleicht wünscht man sich dann sogar die Polizei herbei.  

Laufe ich herum und öffne Garagentore, dann ist das sicher eine Zeit lang interessant. Möchte ich das Picklocking an meiner Haustür 'probiert' wird?  
Tesla hat einen recht einfachen Befehl um die 'Tank'klappe zu öffnen. Das macht Sinn für automatische Ladestationen, später. Auch hier würde ich den Besitzer vor dem ausprobieren zu fragen. Ich kann mir sogar vorstellen dass die Besitzer sogar interessiert sind was möglich ist. Das Öffnen ohne erlaubnis wäre, wie an Autos vorbeizugehen und die Tankklappen zu öffnen ... also nicht legal.  

# Und was kann ich praktisch damit anfangen?

Tja, das ist die große Frage. Bis Mitte 2022 hat jeder in der Gesellschaft auch ohne Flipper überlebt. Also ich wage zu behaupten keiner hätte länger gelebt, hätte er einen besessen.  
Hier kommen zwei Weltern zusammen.
1. Der Arduino. Ein kleiner Microcontroller, mit dem man spielerisch Projekte umsetzen kann. Auch der RaspberryPi geht in diese Richtung der 'Gamification' oder auch 'Rapid Development'. Man kann sich die Umgebung ansehen, man kann Token/Karten/Schlüssel emulieren. Halt nur im erlaubten Bereich. Begreifen durch anfassen.
2. Im BackTrack Linux (heute [Kali Linux](https://www.kali.org/)) heisst es "Je leiser du wirst, desto mehr kannst du hören.". Ich muss nicht alles hacken, knacken, penetrieren. Es reicht manchmal auch einfach zuzuhören. Und vielleicht dadruch schon ableiten zu können wie etwas einfacher oder besser geht. Wenn ich zuhöre weis ich ja noch gar nicht was gesagt wird und ide Fragen oder Ideen kommen erst dann.  

Die Fragen im Forum zeigen aber auch, dass diese Art der Forschung notwendig ist. Es gibt Menschen, die nicht glauben, dass von der Sonne Infrarotstrahlung kommt. Für mich persönlich war das Kapitel AM (Amplituden Modulation) und FM (Frequenz Modulation) bisher am aufschlussreichesten. Auf die Anwendungen in der Welt der GPIO bin ich sehr gespannt.  
Wichtig ist auch zu wissen, dass der Flipper in der Regel keine 'Wellen' speichert. Alle aufgenommenen Signale werden von den Chips bereits zu 1 und 0 verarbeitet und weitergegeben. Wir haben also eher eine sehr niedrig auflösende MP3, als eine 1:1 Kopie in WAV. Daher ist es wichtig, dass der Flipper in seinen Datenbanken möglichst viele Codierungen zu kennen, denn die lassen sich besser als 0 und 1 verarbeiten als irendwelche Spitzen eines vermutlichen Signals.

# Fazit

Ja, mehr als Lernen kann man damit wirklich nicht machen. Verabschieden wir uns vom 'schnellen Hack' und wandern wir zum bewussten Nutzen von Technik.  
Jedes mal, wnen ich auf den Knopf drücke und die Tür zu meinem Auto auf geht, passiert 'Etwas'. Dieses Etwas ist nur ein gezieltes manipulieren von Schwingungen um mich herum. Dabei spricht der Schlüssel nicht direkt mit dem Auto, sondern er brüllt den Code einmal in alle Richtungen. Aber entweder verstehen die anderen Geräte die Sprache (den Code) nicht oder dieser ist nicht für die anderen Autos gedacht. Daher reagiert nur mein Auto.  
Dabei ist in der Theorie die IR Fernbedienung gar nicht viel anders als der Autoschlüssel. Nur im Aufbau deutlich einfacher und ohne Rolling Code und ohne Crypto.  

Wenn ich meinen Auto-Pieper oder die TV Fernbedienung nicht benutze, dann kann auch niemand etwas mitschneiden. Wenn jemand etwas nmitschneiden kann, und es 'einfach kopiert', dann ist das eingesetzte Protokoll schrott. Das kommt seltener vor als man denkt, aber da die Medien sich auf jeden Fall stürzt und nicht gegenber stellt wie viele autos sicher sind, ist die Wirkung anders.  
Dann gibt es natürlich noch die, welche mit ienem Laptop und einem SDR alles mitscheniden, die gängigen Codes kennen und dne Rest mittels Brute Force (Vorschlaghammer) durchraten ... wer diesen Aufwand betreibt um meine leere Jacke aus dme Auto zu klauen, der hat diese aber auch verdient.  

