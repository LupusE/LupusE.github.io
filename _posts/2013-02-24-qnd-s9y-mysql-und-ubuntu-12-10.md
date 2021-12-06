---
status: published
published: true
title: quick-and-dirty - s9y, MySQL und Ubuntu 12.10
author: Benjamin Moeller
date: 2013-02-24 00:47:16 UTC
categories: [QuickAndDirty]
tags: []
comments: []
---

## Heute sich selbst referenzierend im s9y über seine Installation
Wie einige wissen ist s9y (Serendipity) ein Blog-System, welches ich gerne einsetze, weil es schlank und einfach ist.  

Beim Upgrade von Ubuntu lucid auf Ubuntu precise hatte ich nur bemerkt, das MySQL nicht mehr installiert ist. Die Datenbanken selbst waren nach der wieder Installation alle noch vorhanden.  
Bei der Installation unter quantal bin ich auf ein ganz anderes Problem gestoßen.  
> $ sudo aptitude install serendipity  

Sieht zunächst gut aus. Beim automatischen Einrichten der Datenbank über debconf der Fehler:  
> #1214 - The used table type doesn't support FULLTEXT indexes

Die Meldung hatte ich schon mal, aber da habe ich bewusst auf einer Tabelle die InnoDB testen wollen.  

Da MySQL als Standard MyISAM nutzt kann es daran gar nicht liegen. Oder?  

### Analyse:
Zunächst gehe ich sicher, das meine Annahme stimmt:  

> $ mysql -u root -p  
> mysql> SHOW ENGINES;  
> [...]  
> | Engine             | Support | Comment  
> [...]  
> | MyISAM             | YES     | MyISAM storage engine  
> [...]  
> | InnoDB             | DEFAULT | Supports transactions, row-level locking,...  
> [...]  

Okay, stimmt nicht. Was habe ich hier falsch gemacht? Nichts! Ausser vielleicht Changelogs nicht aufmerksam gelesen.  
> Permitted Values (<= 5.5.4) Default	MyISAM  
> Permitted Values (>= 5.5.5) Default	InnoDB  
> Quelle: http://dev.mysql.com/doc/refman/5.5/en/server-options.html#option_mysqld_default-storage-engine

> Seit precise wird MySQL 5.5 eingesetzt, davor war es noch 5.1.  
Quelle: http://packages.ubuntu.com/mysql-server  

Alle Fragen geklärt. Jetzt heisst es aufräumen:  

### Lösung:
Default setzen, in die (zuvor geleerte!) Datenbank wechseln, Dump erneut einlesen.  
> mysql> SET storage_engine=MYISAM;  
> mysql> USE serendipity;  
> mysql> \. /usr/share/doc/serendipity/sql-schema/mysql  

Done.  

Der Import läuft durch es musste kein Script angepasst werden. Keep it simple.  
PS: Allen PhpMyAdmin Liebhaber sei gesagt: Macht es über die Konsole!  
Das Frontend nimmt das SET an und gibt auch positives Feedback, aber wendet es nicht auf das nächste Query an. Viel Spaß beim selbst Testen.  

PPS: Bevor jemand auf die Idee kommt jede durch den ersten Lauf angelegte Tabelle einzeln zu dropen:
> mysql> DROP DATABASE serendipity;  
> mysql> CREATE DATABASE serendipity;  
