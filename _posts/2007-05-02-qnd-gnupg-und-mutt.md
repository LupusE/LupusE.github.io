---
status: published
published: true
layout: post
title: quick-and-dirty - GnuPG und Mutt
author: Benjamin Moeller
date: 2007-05-02 17:24:06 UTC
categories: [howto]
tags: [config, linux, gpg, sicherheit]
comments: []
---

Es ist wieder soweit, ich brauche einen neuen GPG-Key. Schon seit dem 23.12.2006, aber bisher hat sich noch niemand dran gestoert.  
Warum ich es dennoch mache? Ganz einfach, weil ich auch Debianpakete baue, die funktionieren einfach nicht ohne (was ja auch sinnig ist). Also nicht lange geschwafelt, ran an den Speck:  

Zuerst wollen wir ein Schluesselpaar erzeugen, das nimmt GnuPG ab.
```
lupus@zoe:~$ gpg --gen-key
Please select what kind of key you want:
DSA and Elgamal
```
Entscheidungen ueber Entscheidungen. Aber wir wollen das Komplettpaket.
```
What keysize do you want?
2048
```
klingt vernuenftig. Paranoia kann wer anderes schieben.  
```
Please specify how long the key should be valid.
1y
Key expires at Do 01 Mai 2008 19:28:53 CEST
```
Ein Jahr sollte der Key schon vorhalten, dann kann man sich ueberlegen ob es weiterhin Sinn macht. Was woll ich mit einem lebenslangen Key?  
```
Real name: Benjamin Moeller
Email address: bm@lupuse.de
```
Das erste Mal gibt es bei mir eine .de Adresse. Premiere!  
PASSPHRASE MERKEN!!  
```
gpg: key 704E71F2 marked as ultimately trusted
public and secret key created and signed.
gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, classic trust model
gpg: depth: 0  valid:   5  signed:   1  trust: 0-, 0q, 0n, 0m, 0f, 5u
gpg: depth: 1  valid:   1  signed:   3  trust: 0-, 0q, 0n, 0m, 1f, 0u
gpg: depth: 2  valid:   3  signed:   2  trust: 1-, 0q, 0n, 0m, 2f, 0u
gpg: next trustdb check due at 2008-05-01
pub   1024D/704E71F2 2007-05-02 [expires: 2008-05-01]
      Key fingerprint = 5C99 D505 577C B8C5 213B  DB8D 4E9E B767 704E 71F2
uid                  Benjamin Moeller <bm@lupuse.de>
sub   2048g/E9592813 2007-05-02 [expires: 2008-05-01]
```
Soso, das ist geschafft.
```
lupus@zoe:~$ vim .gnupg/gpg.conf
```
Hier den **default-key** anpassen.  
`lupus@zoe:~$ vim .muttrc`  
Hier **set pgp_sign_as=** anpassen.  
`lupus@zoe:~$ gpg --send-keys 704E71F2`

Nun wollen wir den Key noch publizieren (und natuerlich in die Mailsignatur eintragen)  
Fertig!  
