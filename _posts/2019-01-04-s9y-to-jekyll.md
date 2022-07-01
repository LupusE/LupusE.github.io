---
status: published
published: true
layout: post
title: s9y to Jekyll
author: Benjamin Moeller
date: 2019-01-03 19:18:07 UTC
categories: [howto]
tags: [blog, linux]
comments: []
---

Seit 2007 habe ich s9y als Blogengine genutzt. Leider fehlt mir die Zeit zum Pflegen der Version. Auch wenn mein Webspace gemietet ist, und sich verantwortungsvoll um den httpd und den Datenbankserver gekümmert wird, so habe ich doch ein besseres Gefühl, wenn ich wieder statische http Seiten nutze.

Ende 2018 wurde github von Microsoft gekauft. Das große und böse MS will sich nun Freunde im FOSS machen. Okay. Die Reaktion war aber nicht viele neue MS Fans, sondern das Abwandern zu anderen GIT Hostern.
Ich habe ganz am Rande gelesen, dass github auch ein Hosting bietet. Das Ruby Projekt 'jekyll' fügt in html oder Markdown geschriebene Dateien einfach in das Layout ein.
Zugegeben, es ist nicht der aus s9y bekannte WYSIWYG Editor (für den ich nie einen Mobilen/Offline Client gefunden habe), aber den Preis bin ich bereit zu zahlen.

Wer mit git und ruby nicht täglich arbeitet, wie ich, dem möchte ich kurz niederschrieben was ich getan habe.


Es hat sich herausgestellt, dass das Debian jekyll für einige Plugins aus beautiful-jekyll einfach zu alt ist. So sehr ich auch alles aus dem Debian Repository liebe, hier muss auf die gem Variante zurückgegriffen werden.
Die Fehlermeldungen beim build sind ansonsten nicht zu verstehen.
```shell
bm@zoe:~$ sudo apt-get install bundler ~~jekyll~~
bm@zoe:~$ sudo gem install jekyll
```

Ich setze voraus, dass git schon eingerichtet ist ...Ach, was solls... kurz git einrichten:
```shell
bm@zoe:~$ apt-get install git
bm@zoe:~$ git config --global user.name "Benjamin Moeller"
bm@zoe:~$ git config --global user.email git@lupuse.org
```

Verzeichnis zum Arbeiten in git erzeugen. Kann alles mögliche sein, mit Schreibrechten. Je nachdem wie schnell Änderungen im git hochgeladen werden, kann es Sinn machen einen Speicherort mit oder ohne Backup zu wählen.
Dann in das Verzeichnis wechseln, das Design beziehen (nein, es ist nicht geklaut, der Autor stellt es zur Verfügung!), das heruntergeladene Repository kopieren und in das Verzeichnis wechseln.
Zuletzt die dort enthaltene gemfile mittels bundler abarbeiten.
```shell
bm@zoe:~$ mkdir -p ~/git
bm@zoe:~$ cd ~/git
bm@zoe:~/git$ git clone https://github.com/daattali/beautiful-jekyll
bm@zoe:~/git$ mv beautiful-jekyll LupusE.github.io
bm@zoe:~/git$ cd LupusE.github.io
bm@zoe:~/git/LupusE.github.io$ bundle install
```

An dieser Stelle bin ich mir nicht sicher ob ich es vor oder nach dem `bundle install` ausgeführt habe.
```shell
bm@zoe:~/git/LupusE.github.io$ sudo apt-get install ruby-dev
bm@zoe:~/git/LupusE.github.io$ sudo gem install unidecode htmlentities reverse_markdown
```
Der nächste Teil ist zum Erstellen einer Webseite optional, ich möchte meine s9y Blogposts aber ungerne verlieren. Unter https://import.jekyllrb.com/docs/s9ydatabase/ auf der rechten Seite stehen noch weitere Blogsysteme, von den importiert werden kann. 
```shell
bm@zoe:~/git/LupusE.github.io$ sudo apt-get install mysql-server default-libmysqlclient-dev
bm@zoe:~/git/LupusE.github.io$ sudo gem install jekyll-import sequel mysql2
```

Den RSS Feed zu importieren geht viel einfacher und schneller. Allerdings bekommt man auch nur einen Teil der Daten präsentiert, wenn der Feed keine erweiterten Posts zeigt.
```shell
bm@zoe:~/git/LupusE.github.io$ ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::S9Y.run({
      "source" => "https://www.lupuse.de/blog/rss.php?version=2.0&all=1"
    })'
```

Der mühsame Weg mit allen Daten beginnt mit einem SQL Dump, den man entweder vom Provider oder über das Frontend (z.B. phpmyadmin) bekommt.
Vor dem Schreiben des Imports sollte man prüfen wo der Dump anfängt. Mein Dump hat keine eigene Datenbank erstellt.
Debian setzt in 9.x nicht mehr auf MySQL, sondern MariaDB. Das sollte weitgehend kompatibel sein, aber man muss ich daran gewöhnen, dass das Default Login jetzt per unix_socket funktioniert. Als root darf ich mich anmelden und benötige kein Kennwort, erspart euch das Kennwort zurücksetzen im safe-mode

```SQL
bm@zoe:~/git/LupusE.github.io$ sudo mysql
MariaDB [(none)]> CREATE USER bm IDENTIFIED VIA unix_socket;
MariaDB [(none)]> GRANT ALL PRIVILEGES on *.* to 'bm'@'%';
MariaDB [(none)]> exit;
bm@zoe:~/git/LupusE.github.io$ mysql
MariaDB [(none)]> CREATE USER 'jekyll_convert'@'localhost' IDENTIFIED BY 'abcdef';
MariaDB [(none)]> CREATE DATABASE temp_jekyll;
MariaDB [(none)]> GRANT ALL PRIVILIGES ON temp_jekyll.* TO 'jekyll_convert'@localhost;
MariaDB [(none)]> exit;
```

Nun den Dump in die lokale, gerade erstellte Datenbank und dem jekyll-import die Magie machen lassen.

```shell
bm@zoe:~/git/LupusE.github.io$ mysql temp_jekyll < ~/temp/s9y_dump.sql
bm@zoe:~/git/LupusE.github.io$ ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::S9YDatabase.run({
      "dbname"         => "temp_jekyll",
      "user"           => "jekyll_convert",
      "password"       => "Password1",
      "host"           => "localhost",
      "table_prefix"   => "serendipity_",
      "clean_entities" => false,
      "comments"       => true,
      "categories"     => true,
      "tags"           => true,
      "extension"      => "html",
      "drafts"         => true,
      "markdown"       => false,
      "permalinks"     => false
    })'
```

an dieser stelle kommt ganz viel vim ... Aber das ist jedem selbst überlassen sich in dem Code zurechtzufinden.
Der Ersteller des Layout hat es sich leicht gemacht und eher auf 'erfolgreich in 5 Minuten' oder 'zur Webseite in 3 Schritten' beschrieben. Die Anleitung auf https://jekyllrb.com/ hat sehr viele aufeinanderfolgende Seiten, dennoch empfehle ich durchzuhalten und einmal Schritt für Schritt den Aufbau zu erleben.

Die Seite erfolgreich hochladen:
```shell	
bm@zoe:~/git/LupusE.github.io$ jekyll build; git add --all; git commit -m "My Website!"; git push -u origin master
```

Nächste Schritte:
* Eigene Domain erklären (lupuse.github.io -> git.lupuse.de)
* https mit Lets Encrypt erklären
* Eigenes git Projekt erklären
* .js aus dem Design operieren
* Tags/Kategorien reparieren
* Konsequent übersetzen

