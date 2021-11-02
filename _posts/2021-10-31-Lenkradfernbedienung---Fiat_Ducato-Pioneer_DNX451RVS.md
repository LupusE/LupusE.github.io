---
status: published
published: true
title: Wohnmobil - Lenkradfernbedienung von Fiat Ducato auf Pioneer DNX451RVS
author: Benjamin Moeller
date: 2021-10-30 23:36:59 UTC
categories: [Wohnmobil]
tags: [UnterwegsZuhause]
comments: []
---

# Lenkradfernbedienung vom Fiat Ducato zum Pioneer DNX451RVS

## Ausgangslage

Meine Frau und ich haben uns eien [4Pfoten-Mobile Dogliner TE740](https://www.4pfoten-mobile.de/) gekauft, unser BuffyMobil. Dieser Teilintegrierte Fiat Ducato X290 hat den Luxus einer Lenkradfernbedienung, aber sie ist nicht mit dem verbauten Radio Pioneer DNX451 verbunden. Unser Verkaeufer, Joern Zimmermann vom Standort Neumuenster, war so nett und hat fuer uns die fehlenden Teile in Erfahrung gebracht:
* Kabelbaum: CAW-CCOMFI1
* Steuerbox: CAW-COMUN2
Bei [Toms-Car-Hifi](https://www.toms-car-hifi.de/) bestellt, nach 3 Tagen war alles da und die OP konnte beginnen.

Nach dieser Anleitung ist klar, das wird nicht einfach:  
![Anleitung der Verkabelung der CAW-COMUN2 Box](/media/lenkradfb_ducato_dnx451/01_anleitung.png)

Interpretation: Sehr viele schwarze kabel. Ein schwarzes Kabel der Box muss an einen gruenen Adapter vorbei an das schwarze Kabel des Radios, welches mit 'Steering Wheel Remote' bezeichnet ist??!??!?! Oder so.
Auf dem Bild oben rechts koennte man erahnen das schwarz auch blau/gelb sein koennte, mit 'Remo.cont' beschriftet. Das wird lustig.

## Das Einbauen des Adapters mit Kabelbaum
Das Radio im Ausgangszustand  
![Das Radio im fertig eingebauten Zustand](/media/lenkradfb_ducato_dnx451/02_ausgangslage.png)

Beim Aushebeln der Blende brechen sicher ein oder zwei klemmen ab. Durch das tolle klebrige silber Deko-Element (Pfeil) haelt es aber.  
Das Radio ist an dem Blech festgeschraubt, nicht eingeschoben. Ich empfehle mit den oberen beiden Schrauben anzufangen und mit schmaler Spitze (PH2) die untern beiden schrauben parallel zu loesen, so dass das Radio nach vorne oben mitkommt. Ansonsten hat man Macken an dem Radio unten rechts und links.  
![Blende offen](/media/lenkradfb_ducato_dnx451/03_schrauben.png)

Was soll ich schreiben? Kabelchaos. Wenn man keine Ahnung von Kabeln/Stecker/Elektronik hat, sollte man spaetesten hier aufhoeren. Auf jeden Fall die Stromversorgung trennen!  
Wenn man schonmal z.B. einen PC zusammengeschraubt hat, dann trennt man den ISO Stecker (2 Stecker in einem nahezu quadratischen Port) zwischen Radio und Auto und klemmt den Kabelbaum (CAW-CCOMFI1) dazwischen. Der neue Kabelbaum hat eine schwarze schmale Steckerleiste, welche in die Box (CAW-COMUN2) kommt.  
![Die Kabel hinter dem Radio. Chaos.](/media/lenkradfb_ducato_dnx451/04_kabelchaos.png)

Nochmal etwas zurechtgelegt, der nicht selbsterklaerende Teil:  
Der Box (CAW-COMUN2) liegt ein kleines Kabel bei. Der Stecker kommt in das entsprechende gegenstueck des neuen Kabelbaum (CAW-CCOMFI1). Das lose braune Kabel wird mit dem blau/gelb-Kabel des Autoradios verbunden. Den Mini-Klinkenstecker irgendwie isolieren/fixieren, vielleicht eleganter als meine Loesung mit dem weissen Panzertape.  
![Der schlecht beschriebene Adapter Kabelbaum-LenkradFB](/media/lenkradfb_ducato_dnx451/05_kabeladapter.png)

Jetzt muss die Box angelernt werden. [Siehe unten](#ablauf). Spart Euch den Schritt fruehzeitig alles wieder zusammenzubauen.  
Das Plastikteil in der Tuete der Box, welches wie abgebrochen aussieht, ist ein Stift, mit den man den Taster in der Box erreicht (siehe rote Markierung).  
![Die Box eingebaut und angeschlossen. Der Button ist erreichbar.](/media/lenkradfb_ducato_dnx451/06_box.png)

Beim Zusammenschrauben in umgekerter Reihenfolge: Erst die unteren Schrauben, das Radio langsam mit reingleiten lassen, dann die oberen. Achtet drauf, dass die unteren Schrauben trotz des Winkels auch wirklich fest sind. Das Quietschen vom Radio an der Blende auf Kopfsteinpflaster ist nicht schoen.

## Programmieren. Die Anleitung sagt

* Zuendung aktivieren, die Box blinkt.
* Wenn die Box schnell blinkt, kann sofort gestartet werden. Wenn nicht, Reset: 'Zuendung aus, Taste druecken und gedrueckt halten, Zuendung an. Wenn die LED rot blinkt, Button loslassen.'
* Man drueckt eine Taste auf der Lenkradfernbedienung, die Box zeigt mit einem aufleuchten der LED an, dass der Steuerbefehl angenommen wurde.  
Ist ja einfach.

Folgende Zustaende kann die Box anzeigen:

| LED Signal | Bedeutung |
| --- | --- |
| LED aus | Zuendung einschalten oder Box mit Strom versorgen |
| LED blinkt rot | Die Box ist im Anlernmodus |
| LED blinkt einmal, wenn Taste am Lenkrad gedrueckt wurde. | Befehl wurde erkannt |
| LED blinkt einmal, wenn 'Button' auf Box gedrueckt wurde. | Funktion wurde uebersprungen |
| LED blinkt gruen | Kommandos hinterlegt, kein Radioprofil eingestellt |
| LED leuchtet gruen | Alles OK, Box ist programmiert |


Die Box hat 12 Funktionen. Der Ducato hat, abhaengig von Baujahr, 6 oder 8 Tasten. Belegen darf jeder wie er will. Zum Beispiel:

| Funktion | In der Box              | Meine Belegung  |
| :------: | ----------------------- | --------------- |
| 1        | Lautstaerke -           | Lautstaerke -   |
| 2        | Lautstaerke +           | Lautstaerke +   |
| 3        | Suchen -                | Suchen -        |
| 4        | Suchen +                | Suchen +        |
| 5        | Quelle                  | Leere Taste     |
| 6        | Stumm                   | Stumm           |
| 7        | Hoch                    |                 |
| 8        | Sprachbefehl            |                 |
| 9        | Anruf annehmen          | Anruf annehmen  |
| 10       | Anruf beenden           | Anruf beenden   |
| 11       | X                       |                 |
| 12       | X                       |                 |


## <a name="ablauf"></a> Praktisches Anlernen der Box
* Box in Programmiermodus bringen (Entweder im Auslieferungszustand oder nach Reset: Zuendung aus -> Button an der Box gedrueckt halten. Zuendung an. Wenn die LED rot blinkt -> Button loslassen.)
* An der Lenkradfernbedienung 'Lautstaerke +' druecken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Lautstaerke -' druecken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Wippe rechts nach unten' druecken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Wippe rechts nach oben' druecken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Leere Taste (links unten)' druecken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Durchgestrichenen Lautsprecher' druecken, die Box blinkt einmal rot
* Auf der Box einmal den Button drucken (7 ueberspringen), die Box blinkt einmal rot
* Auf der Box einmal den Button drucken (8 ueberspringen), die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Telefon annehmen' druecken, die Box blinkt einmal rot
* An der Lenkradfernbedienung 'Telefon auflegen' druecken, die Box blinkt einmal rot
* Auf der Box einmal den Button drucken (11 ueberspringen), die Box blinkt einmal rot
* Auf der Box einmal den Button drucken (12 ueberspringen), die Box blinkt gruen
* Radioprotokoll auswaehlen: 'Suchen +' druecken


### Lenkradfernbedienung - Tasten

![Fiat Ducato - Lenkradfernbedienung Tasten](/media/lenkradfb_ducato_dnx451/07_lenkrad-ducato.jpg)

| Tasten links  |   Mitte   | Tasten rechts |
| :--           |   :-:     | --:           |
| Stumm         |           | Tel Annehmen  |
| Lautstaerke + |   Hupe    | Suchen +      |
| Lautstaerke - |           | Suchen -      |
| Leer          |           | Tel Beenden   |


