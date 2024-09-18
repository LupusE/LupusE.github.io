---
status: published
published: true
layout: post
title: Flipper Zero - CLI und IR
author: Benjamin Moeller
date: 2024-09-11 23:02:32 UTC
categories: [experimente]
tags: [produkte, flipper zero]
comments: []
---

Seit geraumer Zeit ist der kleine Flipper Zero nun mein treuer Begleiter. Ich habe viel gelernt über verschiedenste Wege der Datenübertragung.  

Auch über Menschen, aber das wollte ich nie. Der Flipper ist weiterhin kein magischer Zauberstab um alle Türen und Tore zu öffnen.  
Je besser ich ein Protokoll verstehe, desto ehe rhabe ich eine Chance zu verstehen wie ich eine Tür öffne, oder eben warum ich das nicht kann. Und warum ärgert es mich nicht, wenn ich mein Garagentor nicht mit einem 200 Euro Multi-Protokol-Tool öffnen kann? Dann kann es auch kein anderer, es ist in dem Bereich sicher.  

## Infrarot im Generellen

Die erste Anlaufstelle um Infrarot-Signale zu bekommen ist die Flipper-IRDB. Dabei gibt es drei Hauptquellen:
- https://github.com/UberGuidoZ/Flipper-IRDB ist ein Fork von:
- https://github.com/logickworkshop/Flipper-IRDB ist ien Fork von:
- https://github.com/Lucaslhm/Flipper-IRDB

Man kann nicht wissen wo jemand aktuell etwas hochgeladen hat, aber die drei Quellen gleichen sich sehr zeitnah ab. Innerhalb einer Woche sollte jede Datei auf allen drei Quellen verfügbar sein. Ich persänlich lade bei der Basis Lucaslhm hoch.  

Diese Datenbank ist bereits sehr mächtig. Oft liest man aber in den Foren und im Discord 'Ich habe die Fernbedienung für xyz verloren'. Diese Anfragen ignoriere ich in der Regel, was interessiert mich ein 10e LED streifen, kauf halt neu.  
In einigen Fällen findet sich in der DB eine ähnliche Datei. Vom gleichen Hersteller oder anderes Label und ähnliche Bezeichnung. Dann kann man das Gerät ein/aus schalten, aber noch nicht die Farben wechseln. Wie im folgenden Beispiel:  

## Infrarot im speziellen: Dualtron

Jemand fragt an, ob wer eine Fernbedienung für eine `dualtron ultra 2` hat. In der IRDB gibt es die `dualtron victor`. An/Aus geht, aber keine Farben.  
Also gehe ich auf https://github.com/Lucaslhm/Flipper-IRDB und gebe bei 'Go to file' ein: dualtron. Ich bekomme die Datei Dualtron\_Victor\_Handlebar\_Lights.ir als Ergebnis.  
Vom User weis ich bereits, dass 'POWER' geht, also schaue ich mir diesen Button in der Datei an:  

```
name: POWER
type: parsed
protocol: NEC
address: 00 00 00 00
command: 07 00 00 00
```

NEC ist ein sehr einfaches Protokoll. 16 bit Adresse und Komando, bestehend aus 8 bit+8 bit logical inversed. Daher reicht in der Datei 8 bit `command: 07`.  
Die Adresse ist hier mit 00 angegeben, das ist nicht ungewöhnlich bei billigen Produkten. Es wird halt als Adresse 16 bit 00000000 11111111 gesendet.

Ich könnte mich nun darauf konzentrieren, dass 07 ein bekanntes Kommando ist und den nahen Bereich als Buttons in einer IR File anlegen.  
Oder ich weis das ich nur 255 Werte im Hex Bereich habe und schreibe mir eine Schleife zum Testen der 255 Werte von 00 bis FF:  

```
!/bin/bash

for command in {0..255}
do
    hexcmd=$(printf "%02d" $(echo "obase=16;$command" |bc)) 
    echo "Send \"ir tx NEC 00 $hexcmd\" to /dev/ttyACM0"
    echo -e "ir tx NEC 00 $hexcmd" >> /dev/ttyACM0
    sleep 5
done
```

1. Ich lasse den Zahlenbereich 00 bis 255 durchlaufen.  `for command in {0..255}; do ...; done`
1. Zunächst konvertiere ich die Zahl in einen Hexadezimalen Wert `$(echo "obase=16;$command" |bc)`, die führende Null nicht vergessen! `$(printf "%02d" ...)`  
1. Dann gebe ich mir auf dem Bildschim aus was ich gerade mache. `echo "Send \"ir tx NEC 00 $hexcmd\" to /dev/ttyACM0"` 
1. Zu guter Letzt wird der Befehl an den Flipper gesendet. `echo -e "ir tx NEC 00 $hexcmd" >> /dev/ttyACM0` 
1. Ja, das Sleep ist notwendig, damit ich auch noch rechtzeitig reagieren kann und keine unkontrollierte Disco erzeuge. Bei 07 z.B. muss ich die Chance haben den IR Sender zu verdecken oder das Gerät wieder einzuschalten vor 08.  

## Ein bischen rechnen (Mathematik ist das noch nicht)

Dieses funktioniert nur, bei Protokollen mit 2x8 bit Kommandos.  
Wenn ich ein 16 bit Kommando habe, muss ich den Wertebereich entsprechend von 0000 auf FFFF erweitern. 65535 * 5 Sekunden (91 Stunden) macht nicht mehr so viel Spass. Ich muss die ganze Zeit dabei bleiben, da es über das Protokolle kein Feedback gibt. Zum Vergleich sind es bei 255 Variationen * 5 Sekunden gerade mal 21 Minuten, wenn ich auf 3 Sekunden Sleep gehe 12 Minuten. Diese Optimierung benötigt bei FFFF noch immer 54 Stunden.  

Erinnert Ihr Euch noch was ich oben zum Thema 'Protokolle verstehen' geschrieben habe? Das war kein Scherz, man sollte wissen wann man sich der Komplexität geschlagen gibt.  
