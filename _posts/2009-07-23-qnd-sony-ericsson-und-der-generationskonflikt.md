---
status: published
published: true
title: quick-and-dirty - Sony Ericsson und der Generationskonflikt
author: Benjamin Moeller
date: 2009-07-23 23:42:00 UTC
categories: [howto]
tags: [config, linux, handy]
comments: []
---

Vor Jahren brauchte ich ein neues Telefon, da mein Nokia 6100 kein Bluetooth konnte, ich aber unbedingt ein BT Headset haben wollte. Also entschied ich mich für das Sony Ericsson T630. Mit dieser Wahl war ich lange Zeit zufrieden (6 Monate) und kaufe mir aufgrund der positiven Erfahrungen gleich noch ein Sony Ericsson, diesmal sollte es das K600i sein.
An diesem Tag fing meine Verzweiflung an, denn das ältere T630 hat eine Funktion 'komplettes Telefonbuch übertragen' ... Pustekuchen. Einzeln übertragene Daten haben nur die Hauptnummer. Mit der SE Suite bekommt man beide Telefone getrennt gesichert, aber nicht die Daten überspielt.

Hier kommt das [gnokii](http://www.gnokii.org) Projekt zum Tragen. Anfangs für Nokia entwickelt unterstützt es heute eine breite Masse von Herstellern und Modellen. AT-Befehlen sei dank.  
Wir wissen, das es verschiedene Speicher im Handy gibt, die wichtigen heute sind ME für das Telefon und SM für die Sim Karte.  

```
gnokii --getphonebook ME 1 end --vcard > 090724_k600i_ME.dump  
gnokii --getphonebook SM 1 end --vcard > 090724_k600i_SM.dump
```

**gnokii** - Die Kommandozeilenversion des Programms, im Gegensatz zu xgnokii  
**--getphonebook** - wir wollen das Adressbuch auslesen
**ME** - benutzen dafür den Telefonspeicher  
**1 end** - vom Eintrag 1, bis zum Ende wollen wir alle sichern  
**--vcard** - weil wir mit dem Format wenig anfangen können lassen wir es als vCard ausgeben.
**090724_k600i_ME.dump** - und pipen das Ganze von stdin in eine Datei  

```
gnokii --getsms ME 1 end -f 090724_k600i_MESMS.mbox -a
```

**gnokii** - Die Kommandozeilenversion des Programms, im Gegensatz zu xgnokii  
**--getsms** - wir wollen die SMS auslesen  
**ME** - benutzen dafür den Telefonspeicher  
**1 end** - vom Eintrag 1, bis zum Ende wollen wir alle sichern  
**-f 090724_k600i_MESMS.mbox** - das ganze soll im mbox Format in eine Datei geschrieben werden (file)  
**-a** - Einträge sollen der Datei angehängt werden (append)  
Nun können wir mit einem beliebigen, mbox fähigen, eMail Client die SMS lesen.  
`mutt -f 090724_k600i_MESMS.mbox`

## [Edit]
Als Basis für die Einstellungen habe ich die /etc/gnokiirc nach ~/.gnokiirc kopiert. Hier kann man bequem daran rumspielen.  
Weitestgehend habe ich die Werte auf Default belassen, die wichtigen Optionen in meinem Fall sind:  
```
## ~/.gnokiirc
## SE T630/K600i via DSS-25 Dockingstation  
port = /dev/ttyUSB0  
model = AT  
connection = serial  
[...]
```

## [Edit 25 Juli 2009]
Und wieder zurueck ins Telefon. Hier bedienen wir uns dem Raw Format, welches am unanfälligsten gegenüber Fehlern ist, mit dem Schalter -r.  
In meinem Fall habe ich 228 Einträge im Telefonbuch.  
```
gnokii --getphonebook ME 1 228 -r > 090725_T630_ME.raw  
gnokii --writephonebook -o -m ME < 090725_T630_ME.raw
```

Und schon sind alle Kontakte auf dem neuen Telefon wieder hergestellt. Das ganze funktioniert auch mit dem vCard (-v) und ldif (-l) Format. Dann aber beim get und write denselben Schalter nutzen!  
-o steht für overwrite, da ich keine alten Einträge behalten wollte, es geht auch mit -f, dann sucht er den nächsten freien Platz im Speicher.  

