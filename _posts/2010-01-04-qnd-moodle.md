---
status: published
published: true
title: quick-and-dirty - Moodle
author: Benjamin Moeller
date: 2010-01-04 22:44:27 UTC
categories: [howto]
tags: [config, linux, groupware]
comments: []
---

In der Berufsschule nutzen wir die top moderne eLearning Plattform [Moodle](http://www.moodle.org). Die so was von toll ist, dass sie gleich in ganz Neuseeland eingesetzt wird, wo die Schüler komplett von zuhause aus arbeiten (Quelle: Ein Lehrkörper unserer Schule).  
Es handelt sich um ein Stück GPL Software, das einzige Positive an dem System ist wohl auch die Lizenz, also habe ich es mir mal ansehen wollen.  

Das Programm ist als [Paket](http://packages.ubuntu.com/moodle) im Ubuntu vorhanden, und ich bin faul  
```$ sudo aptitude install moodle ```

und ich bin begeistert, ein Debconf-Dialog. Einfach erklärt, und selbst der Befehl zum Prüfen des FQDN ist angegeben.  
Aber WARUM muss ich das MySQL root Passwort 2x eingeben? Confirmation für was? Da sich es bei der Einrichtung von MySQL auch 2x eingegeben habe? Okay, ein Problem im Paket selbst, nevermind.  
Dann verweist der Dialog im letzten Schritt auf die URL [http://localhost/moodle](http://localhost/moodle) und ab gehts.  

Im gewohnt sterilem Weiß präsentiert sich Moodle, und fragt natürlich ein paar Parameter ab. Zum Beispiel die Checkbox 'Unattended operation'.  
> For information about this version of Moodle, please see the online Release Notes  

Und verweist auf die aktuelle Release Notes, nicht die der verwendeten Version. Was ist nun Unattended operation?  
Der erste Hit bei Google trifft eine Moodleseite -> leider bin ich nicht eingeloggt um nachzulesen. Oh.  
Mit dem Button [Als Gast anmelden] kann man diese Frage lesen. Warum nicht gleich?  
Also es handelt sich um die Installation. Vollautomatisch oder nicht? ... Neee, ich will wissen was auf meinem Server läuft.  
Die ersten gefühlten 2 Minuten klickt man 'continue' und staunt Bauklötze über die komplexen SQL Statements. Dann wird ein Admin angelegt. Der Benutzername darf nur lowercase sein. Aha. Dafür kann ich hier noch keine deutsche Sprache wählen, aber MUSS angeben in welcher Stadt und welchem Land ich wohne.  
Okay, ich habe zwar den FQDN angegeben, aber das er nur noch darauf springt muss ich dem noch austreiben. Es soll Menschen geben, die intern einen anderen Domainnamen verwenden als extern.  
Man kann Userlisten hochladen. Dort ist der CSV Delimiter und das Encoding anzugeben, aber keine weiteren Informationen zum Format.  
Ab hier fühlt es sich an wie ein geschmolzenes Gummibärchen. Vollgestopft, nicht intuitiv und nicht geleitet. Immerhin ist das Installieren der Sprachen komplett intern mittels Klick erledigt und läuft nicht über wilde Im/Export Orgien.  
Hier benötigt es sicher einige Einarbeitungszeit, bis ich meinen eigenen 'Test' anlegen kann, so wie wir die Klassenarbeiten schreiben. Das aber nicht mehr heute.  
