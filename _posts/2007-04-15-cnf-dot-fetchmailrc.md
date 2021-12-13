---
status: published
published: true
title: CNF - dot.fetchmailrc
author: Benjamin Moeller
date: 2007-04-15 12:43:08 UTC
categories: [linux]
tags: [cnf, linux]
comments: []
---

Ein Beispiel, wie eine .fetchmailrc aussehen kann.  
`poll pop3.web.de with proto POP3`  
abholen, von server, mit, protokoll  
`user "[remote user]" there with password "[pass]" is [localuser] here`  
benutzer, "login user", da mit passwort, "login passwort", ist, der benutzer, hier  
`ssl sslfingerprint "AA:BB:CC:DD:EE:FF:GG:HH:II:JJ:KK:LL:MM:NN:OO:PP"`  
ssl -> man sollte eMailverkehr verschluesseln! Denn auch das Passwort wirt im Klartext uebertragen!  
sslfingerprint -> Der Schluessel der Servers, wird angegeben bei 'fetchmail -v pop3.web.de'  
`keep`  
Die eMails auf dem Server belassen. Mehr Optionen -> man fetchmailrc  

```
# ~/.fetchmailrc
# Programm zum abholen der Mails von verschiedenen Mailservern  
set postmaster "[user]"		#postmaster/root@... geht an [user] (für lokale Dienste)  
set bouncemail  
set properties ""		  #möglichkeiten wie 'keep' nachzulesen in der Manpage  
#sslcertck  
#sslcertpath /home/[user]/.certs  
  poll pop3.web.de with proto POP3  
	user "[remote user]" there with password "[pass]" is [localuser] here  
	ssl sslfingerprint "AA:BB:CC:DD:EE:FF:GG:HH:II:JJ:KK:LL:MM:NN:OO:PP"  
#	keep  

poll pop.gmx.net with proto POP3  
	user "[remoteuser]@gmx.de" there with password "[pass]" is [localuser] here  
#      ssl sslfingerprint "AA:BB:CC:DD:EE:FF:GG:HH:II:JJ:KK:LL:MM:NN:OO:PP"  
#	keep  

#poll mail.domain.de with proto POP3  
#	user "[remote login]" there with password "[password]" is [local user] here  
#	ssl sslfingerprint "AA:BB:CC:DD:EE:FF:GG:HH:II:JJ:KK:LL:MM:NN:OO:PP"  
#	keep

#poll pop.t-online.de with proto POP3  
#	user "[user]@t-online.de" there with password "[pass]" is [local user] here  
mda '/usr/bin/procmail -f fetchmail'	# die direkte abgabe an procmail.  

# schema:  
#poll mail.server.de with proto POP3  
#        user "remote-login" there with password "passwort" is lokaler-user here  
