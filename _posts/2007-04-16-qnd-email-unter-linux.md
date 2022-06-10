---
status: published
published: true
title: quick-and-dirty eMail unter Linux.
author: Benjamin Moeller
date: 2007-04-16 21:38:16 UTC
categories: [howto]
tags: [config, linux, mail]
comments: []
---

# eMail unter Linux. Ein Einstieg
### --nicht fertig!!--

Das Mail-System unter Linux ist in Modulen aufgebaut. also ganz ganz kompliziert. Zumindest bis man gelernt hat mit den Begriffen umzugehen. Und das ist hier das Ziel.  

> eMail-Adresse -- user@domain.tld.
Mit der eMail-Adresse wird der Empfänger der Nachricht bestimmt.  

> eMail-Header -- To: user@host, Subject: Hallo, ...  
Im Header werden Steuerbefehle für den MTA geschrieben, die das sichere Zustellen einer eMail ermöglichen.  

> MTA -- Mail Transfear Agent. exim, postfix, qmail, sendmail, exchange, ...  
Der MTA hat die Aufgabe eine aMail entgegen zunehmen und an die angegebene eMail-Adresse weiterzuleiten.  

> MUA -- Mail User Agent. Mutt, Kmail, Webmail, Outlook, ...  
Der MUA dient zum einen dem Verwalten von eMails, zum anderen übernimmt er auch die Aufgaben der Header-Anpassung und kann auch als Editor dienen.  

> MDA -- Mail Delivery Agent. Procmail, ...  
Der MDA nimmt die Mails in entgegen und sortiert Diese in verschiedene Postfächer (Mbox, Maildir, IMAP, ...)
