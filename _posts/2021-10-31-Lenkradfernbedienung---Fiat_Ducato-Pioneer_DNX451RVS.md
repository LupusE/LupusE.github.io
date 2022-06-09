---
status: published
published: true
title: Wohnmobil - Lenkradfernbedienung von Fiat Ducato auf Pioneer DNX451RVS
author: Benjamin Moeller
date: 2021-10-30 23:36:59 UTC
sitemap:
  lastmod: 2022-06-09
categories: [Wohnmobil]
tags: [UnterwegsZuhause]
comments: []
---

# Ausgangslage

Meine Frau und ich haben uns ein [4pfoten-Mobile - Dog-Liner TE740](https://www.4pfoten-mobile.de/) gekauft, unser BuffyMobil. Dieser Teilintegrierte Fiat Ducato X290 hat den Luxus einer Lenkradfernbedienung, aber sie ist nicht mit dem verbauten Radio Pioneer DNX451 verbunden. Unser Verkäufer, [Jörn Zimmermann](www.4pfoten-mobile.de/neumuenster/) vom Standort Neumünster, war so nett und hat für uns die fehlenden Teile in Erfahrung gebracht:
* Kabelbaum: CAW-CCOMFI1
* Steuerbox: CAW-COMUN2

Bei [Toms-Car-Hifi](https://www.toms-car-hifi.de/) bestellt, nach 3 Tagen war alles da und die OP konnte beginnen.

Nach dieser Anleitung ist klar, das wird nicht einfach:  
![Anleitung der Verkabelung der CAW-COMUN2 Box](/media/lenkradfb_ducato_dnx451/01_anleitung.png)

Interpretation: Sehr viele schwarze Kabel. Ein schwarzes Kabel der Box muss an einen grünen Adapter vorbei an das schwarze Kabel des Radios, welches mit 'Steering Wheel Remote' bezeichnet ist??!??!?! Oder so.  
Auf dem Bild oben rechts könnte man erahnen das schwarz auch blau/gelb sein könnte, mit 'Remo.cont' beschriftet. Das wird lustig.

# Das Einbauen des Adapters mit Kabelbaum
Das Radio im Ausgangszustand  
![Das Radio im fertig eingebauten Zustand](/media/lenkradfb_ducato_dnx451/02_ausgangslage.png)


Beim Aushebeln der Blende brechen sicher ein oder zwei Klemmen ab. Durch das tolle klebrige silber Deko-Element (Pfeil) hält es aber.  
Das Radio ist an dem Blech festgeschraubt, nicht eingeschoben. Ich empfehle mit den oberen beiden Schrauben anzufangen und mit schmaler Spitze (PH2) die untern beiden schrauben parallel zu loesen, so dass das Radio nach vorne oben mitkommt. Ansonsten hat man Macken an dem Radio unten rechts und links.  
![Blende offen](/media/lenkradfb_ducato_dnx451/03_schrauben.png)


Was soll ich schreiben? Kabelchaos. Wenn man keine Ahnung von Kabeln/Stecker/Elektronik hat, sollte man spätesten hier aufhören. Auf jeden Fall die Stromversorgung trennen!  
Wenn man schon z.B. einen PC zusammengeschraubt hat, dann trennt man den ISO Stecker (2 Stecker in einem nahezu quadratischen Port) zwischen Radio und Auto und klemmt den Kabelbaum (CAW-CCOMFI1) dazwischen. Der neue Kabelbaum hat eine schwarze schmale Steckerleiste, welche in die Box (CAW-COMUN2) kommt.  
![Die Kabel hinter dem Radio. Chaos.](/media/lenkradfb_ducato_dnx451/04_kabelchaos.png)

Nochmal etwas zurechtgelegt, der nicht selbsterklärende Teil:  
Der Box (CAW-COMUN2) liegt ein kleines Kabel bei. Der Stecker kommt in das entsprechende gegenstück des neuen Kabelbaum (CAW-CCOMFI1). Das lose braune Kabel wird mit dem blau/gelb-Kabel des Autoradios verbunden. Den Mini-Klinkenstecker irgendwie isolieren/fixieren, vielleicht eleganter als meine Lösung mit dem weißen Panzertape.  
![Der schlecht beschriebene Adapter Kabelbaum-LenkradFB](/media/lenkradfb_ducato_dnx451/05_kabeladapter.png)


Jetzt muss die Box angelernt werden, [siehe unten](#ablauf). Spart Euch den Schritt frühzeitig alles wieder zusammenzubauen. Ich habe die Box mehrfach neu programmiert, bis es mir gefallen hat.  
Das Plastikteil in der Tüte der Box, welches wie abgebrochen aussieht, ist ein Stift, mit den man den Taster in der Box erreicht (siehe rote Markierung).  
![Die Box eingebaut und angeschlossen. Der Button ist erreichbar.](/media/lenkradfb_ducato_dnx451/06_box.png)


Beim Zusammenschrauben in umgekerter Reihenfolge: Erst die unteren Schrauben, das Radio langsam mit reingleiten lassen, dann die oberen. Achtet drauf, dass die unteren Schrauben trotz des Winkels auch wirklich fest sind. Das Quietschen vom Radio an der Blende auf Kopfsteinpflaster ist nicht schön.

## Programmieren. Die Anleitung sagt ...

* ... Zündung aktivieren, die Box blinkt.
* Wenn die Box schnell blinkt, kann sofort gestartet werden. Wenn nicht, Reset: 'Zündung aus, Taste drücken und gedrückt halten, Zündung an. Wenn die LED rot blinkt, Button loslassen.'
* Man drückt eine Taste auf der Lenkradfernbedienung, die Box zeigt mit einem aufleuchten der LED an, dass der Steuerbefehl angenommen wurde.  

Das ist ja einfach. Bis auf das man gleichzeitig drücken und auf die LED achten muss.  

## Folgende Zustände kann die Box anzeigen

| LED Signal | Bedeutung |
| --- | --- |
| LED aus | Kein Strom. Zündung einschalten oder Box mit Strom versorgen |
| LED blinkt rot | Die Box ist im Anlernmodus |
| LED blinkt einmal, wenn Taste am Lenkrad gedrückt wurde. | Befehl wurde erkannt |
| LED blinkt einmal, wenn 'Button' auf Box gedrückt wurde. | Funktion wurde übersprungen |
| LED blinkt grün | Kommandos hinterlegt, kein Radioprofil eingestellt |
| LED leuchtet grün | Alles OK, Box ist programmiert |


Die Box hat 12 Funktionen. Der Ducato hat, abhängig von Baujahr, 6 oder 8 Tasten. Belegen darf jeder wie er will. Zum Beispiel:

| ID  | Funktion der Box | Meine Belegung |
| :-: | ---------------- | -------------- |
| 1   | Lautstärke -     | Lautstärke -   |
| 2   | Lautstärke +     | Lautstärke +   |
| 3   | Suchen -         | Suchen -       |
| 4   | Suchen +         | Suchen +       |
| 5   | Quelle           | Leere Taste    |
| 6   | Stumm            | Stumm          |
| 7   | Hoch             |                |
| 8   | Sprachbefehl     |                |
| 9   | Anruf annehmen   | Anruf annehmen |
| 10  | Anruf beenden    | Anruf beenden  |
| 11  | X                |                |
| 12  | X                |                |


## <a name="ablauf"></a> Praktisches Anlernen der Box
* Box in Programmiermodus bringen (Entweder im Auslieferungszustand oder nach Reset: Zündung aus -> Button an der Box gedrückt halten. Zündung an. Wenn die LED rot blinkt -> Button loslassen.)
* An der Lenkradfernbedienung 'Lautstärke +' drücken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Lautstärke -' drücken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Wippe rechts nach unten' drücken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Wippe rechts nach oben' drücken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Leere Taste (links unten)' drücken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Durchgestrichenen Lautsprecher' drücken, die Box blinkt einmal rot
* Auf der Box einmal den Button drücken (7 überspringen), die Box blinkt einmal rot
* Auf der Box einmal den Button drücken (8 überspringen), die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Telefon annehmen' drücken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Telefon auflegen' drücken, die Box blinkt einmal rot
* Auf der Box einmal den Button drücken (11 überspringen), die Box blinkt einmal rot
* Auf der Box einmal den Button drücken (12 überspringen), die Box blinkt grüen
* Radioprotokoll auswaehlen: 'Suchen +' druecken


### Lenkradfernbedienung - Tasten

![Fiat Ducato - Lenkradfernbedienung Tasten](/media/lenkradfb_ducato_dnx451/07_lenkrad-ducato.jpg)

| Tasten links  |   Mitte   | Tasten rechts |
| --:           |   :-:     | :--           |
| Stumm         |           | Tel Annehmen  |
| Lautstärke +  |   Hupe    | Suchen +      |
| Lautstärke -  |           | Suchen -      |
| Leer          |           | Tel Beenden   |


# Fazit

Die Box war das Geburtstagsgeschenk 2021 an mich von meiner Frau, als wegen Corona alles zu hatte. So konnten wir die Funktion zwar nicht sofort testen, aber ich konnte am Wohnmobil basteln.  
Jetzt, nach einigen Fahrten, muss ich sagen der Mehrwert ist gewaltig. Es handelt sich immernoch um einen Transporter, das heisst es ist nicht zu vergleichen mit dem Multimediacockpit eines Mini Cooper oder BMW, aber man muss nicht mehr in die Mitte greifen und versuchen per Touch das richtige Feld zu treffen.  
Das Radio hat seine Schwächen, aber das Telefonieren per Bluetooth auf Landstrasse und Autobahn funktioniert sehr gut. Auch hier ist Lenkradfernbedienung ein deutlicher Mehrwert.

Es gibt per Amazon auch Boxen, welche etwa ein drittel der orignalen Lösung kosten. Von denen habe ich ersteinmal abstand genommen, denn in meinem Urlaub soll es funktionieren. Wenn jemand Erfahrungne mit diesen 3rd Party Lösungen aus China hat, bin ich sehr an einem Erfahrungsbericht interessiert.

# Nachtrag 09.06.2022: Leitung braun/blaugelb

In der Zwischenzeit hat die Lenkradfernbedienung schon ein paar KM gesehen, und sie setzte immer wieder aus. Ich vermutete schon, dass es an meiner professionellen Panzertape Kabelverbindung liegt. Seit ich dort eine Wago-Klemme einsetze läuft auch alles zuverlässig.  
Beim nächsten Mal auseinandernehmen werde ich die leere Taste von 'Quelle' auf 'Sprachbefehl' programmieren.  

