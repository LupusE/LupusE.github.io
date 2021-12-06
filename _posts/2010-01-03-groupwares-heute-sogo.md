---
status: published
published: true
title: Groupwares - Heute SOGo
author: Benjamin Moeller
date: 2010-01-03 14:09:32 UTC
categories: [QuickAndDirty]
tags: [cnf, linux, qnd]
comments: []
---

Seit langem befasse ich mich schon mit dem Thema Groupware, und heute will ich von meinem Misserfolg **SOGo** schreiben. Die Screenshots auf der Projektseite [http://www.scalableogo.org/](http://www.scalableogo.org) machten was her. Das Konzept erschien mir sinnig, wenn auch mit deutlich eingeschränktem Funktionsumfang, aber mit scheinbar brauchbarer Handheld-Anbindung.  
Der Einfachheit halber habe ich mich des Debian Pakets bedient, also musste franklin wieder herhalten.  
MySQL und LDAP sind schon vorhanden, also zum Start die Paketquelle eintragen  

`# echo "deb http://inverse.ca/debian lenny main" >> /etc/apt/sources.list`

Da in den Abhängigkeiten das Paket **gnustep-make** fehlt einfach manuell hinzufügen  
`# aptitude install sogo gnustep-make`

noch schnell MySQL vorbereitet  
```
$ mysql -u root -p
mysql> CREATE DATABASE `sogo`;  
mysql> CREATE USER 'sogo'@'localhost' IDENTIFIED BY 'sogopasswd';  
mysql> GRANT ALL PRIVILEGES ON `sogo`.'*' TO 'sogo'@'localhost' WITH GRANT OPTION;  
mysql> FLUSH PRIVILEGES;  
```

Der User sogo  wird angelegt, zu dem wir uns machen:  
`# su - sogo`

und richten die config ein.
```
defaults write sogod OCSFolderInfoURL "mysql://sogo:sogopasswd@localhost:3306/sogo/sogo_folder_info"  
defaults write sogod SOGoProfileURL "mysql://sogo:sogopasswd@localhost:3306/sogo/sogo_user_profile"  
defaults write sogd SOGoServerTimeZone "Europe/Berlin"  
defaults write sogd WOParsersUseUTF8 YES  
defaults write sogd WOMessageUseUTF8 YES  
defaults write sogd SOGoDefaultMailDomain "lupuse.net"  
defaults write sogd NGUseUTF8AsURLEncoding YES  
defaults write sogd SOGoDefaultLanguage German  
defaults write sogd SOGoAppointmentSendEMailNotifications NO  
defaults write sogd SOGoFoldersSendEMailNotifications NO  
defaults write sogd SOGoACLsSendEMailNotifications NO  
defaults write sogd WOPort 20000  
defaults write sogd WOApplicationRedirectURL "http://franklin.lupuse.net"
```

Und Apache vorbereiten  
`# cp /usr/share/doc/sogo/examples/SOGo.conf /etc/apache2/sites-available/`

in dieser Datei kommentieren wir den ersten Block aus und den zweiten ein, wie es in der Datei kommentiert ist.

```
# a2ensite SOGo.conf  
# a2enmod proxy*
# a2enmod headers
```

Und wir erhalten über [http://localhost/SOGo](http://localhost/SOGo) Zugriff auf die Startseite.  
... Die Benutzer werden direkt in das LDAP geschrieben, entweder über LDIF Import oder über ein beliebiges Frontend (wie z.B. PHPLdapAdmin)  
Aber ab hier hatte ich einfach eine Lust mehr, das Produkt hat eine lausige und fehlerhafte Dokumentation, das Debianpaket ist halbherzig verpackt und weist auf keine einzige Besonderheit hin.  

Ich bin raus, In freudiger Erwartung auf die nächste Groupware.
