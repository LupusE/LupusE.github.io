---
status: published
published: true
layout: post
title: Heute wird ein Windows XP repariert (ohne Linux)
author: Benjamin Moeller
date: 2011-06-18 08:55:01 UTC
categories: [howto]
tags: [config, linux, windows]
comments: []
---
Eines Tages ist es so weit, man startet seinen Windows XP Rechner und stellt fest, er startet nicht. Das bekannte schwarze Fenster mit weißer Schrift erscheint, mit der Option 'Im abgesicherten Modus starten' ... Ohne Erfolg. Auch nach wiederholtem versuchen aller Funktionen, es kommt einfach kein Windows.  
Im besten Fall weiß man noch welcher Treiber als letztes (automagisch?) installiert/erneuert wurde, welche Hardware zugesteckt wurde oder welche Komponente schon immer Probleme machte. Wir können lange fluchen und Meckern 'gestern hat es aber noch funktioniert, aber wenn auch der nette IT Nerd aus dem Bekanntenkreis keine Zeit hat das Gejammer anzuhören, dann müssen wir uns selbst helfen.  

Als erstes legen wir eine gute CD ein (wenn ein 2. Rechner vorhanden ist gerne auch die MP3 Sammlung), ich empfehle eine Mischung aus Trance, Chillout und Breakbeat im Shuffle.  

Nun schlagen wir gute Lektüre auf, z.b. 'Windows XP in a Nutshell' aus dem O'Reilly Verlag [www.oreilly.de](https://www.oreilly.de). Es tut aber auch ein verstaubtes MCSE Prüfungsbuch.  
In den Büchern steht dann in etwa folgendes:  
> Let's get it on!  

Wir suchen jetzt die Windows XP CD und hoffen das es keine Recovery-Version ist (wäre diese vollständig, wäre es zu einfach). Diese legen wir in das CD-ROM Laufwerk und booten. Das wir die CD booten und nicht die kaputte Windows Installation, werde ich nicht erwähnen.  

# Multiple choice
Nun sehen wir einen Fragenkatalog. Unten in der Statusleiste erscheint 'Press F6 to install an external driver', hier drücken wir 'F5'! und es kommt ein kleines Fenster mit Auswahlmöglichkeiten, wie 'Multiprozessor', 'ACPI', 'Uniprozessor', ... und 'Standard-PC'. Wir wählen Standard-PC (Wahlweise Multiprozessor, bei modernen PCs, die wahrscheinlich eher Windows 7 installiert haben werden). Es ist meine persönliche Abneigung, die ich gegenüber der Option ACPI (Advanced Configuration and Power Managment) habe.  
Entgegen den Befürchtungen des allgemeinen Volkes kann auch APM (Advanced Power Managment) veranlassen das ein ATX kompatibler PC nach dem Herunterfahren automatisch ausschaltet.  
Dazu muss man wissen, dass ACPI zwar generell eine tolle Idee ist, aber die Implementierung sehr fragwürdig. Sich an Standards zu halten kostet Geld. Geld will man nicht bezahlen, so richtet sich die Industrie nach den Wünschen der Konsumenten, die dann über die Industrie fluchen.  

Im folgenden Schritt wählen wir 'Windows installieren', denn mit der eingeschränkten Reparaturkonsole (Recovery System) kann man etwa soviel machen, wie ein Bauer mit einer ausgestopften Kuh. Schön anzusehen (schwarz mit weißen Flecken) aber irgendwie nicht nutzbar. Als Letztes entscheiden wir uns für 'Erkanntes Windows reparieren'.  

# Home sweet home
Der Rest geht automatisch. Die Routine beginnt relativ früh. Also einige Treiber- und Systemgeschichten wollen nachinstalliert werden, Einstellungen wollen kontrolliert werden usw.  
Got ya!
