---
status: published
published: true
layout: post
title: 'quick-and-dirty Debian: Kernel bauen'
author: Benjamin Moeller
date: 2007-02-10 11:08:29 UTC
categories: [howto]
tags: [linux, qnd, kernel]
comments: []
---

## Vorwort

Ich wollte im Grunde keine quick-and-dirty (Quick'n'Dirty) Howtos im Blog, da ich .txt Files bevorzuge. Erreichbar über w3m, lynx, ... einfaches Kopieren und keine Datenbank, die sterben kann.  
Heute werde ich mich ueber meine eigenen Ideale hinwegsetzen und sündigen!

---
Angepasster Kernel unter Debian? Dank einiger Werkzeuge gar nicht so schwer.  
Zuerst installiert man alle noetigen Pakete  

`# aptitude install gcc binutils bin86 make kernel-package tk8.2-dev libncurses5-dev wget bzip2 module-init-tools'`

Nach dieser Vorbereitung zieht man sich den Kernel ...  

```bash
# mkdir -p ~/sys/kernel/  
# cd ~/sys/kernel/  
# wget ftp://ftp.de.kernel.org/pub/linux/kernel/v<$version>/linux<$revision>.bz2  
```

... und entpackt ihn.  

```bash
# cd /usr/src  
# tar xjvf /home/<$user>/sys/linux<$revision>.bz2  
```

Jetzt legen wir einen Symlink an ... `# ln -s linux<$revision> linux`
... in das Verzeichnis wechseln ... `# cd linux`
... und das Konfigurationsmenu aufrufen. `# make menuconfig`  


Jetzt wird es Uneinheitlich, da die Kernelkonfiguration von der vorhandenen Hardware abhängt. Es soll ja ein 'angepasster' Kernel werden :)  
Im Grunde sage ich: Soviel als Modul wie möglich, was man beim Booten braucht (IDE/SATA, Filesystem, Framebuffer, ...) in den Kernel. Mit initrd befasse ich mich ein anderes mal.  

Nun wird der Kernel entsprechend der Konfiguration kompiliert `# make-kpkg kernel_image --revision=zoe1.0` zu finden ist das fertige Paket eine Etage tiefer `# cd ..`.  
Zum Abschluss installieren `# dpkg --install linux-image-2.6.20_zoe1.0_i386.deb` und das System neu starten `# reboot`.

Zu sehen ist das Ergebnis in der Konsole mit  
```bash
# uname -a<br />
Linux zoe 2.6.20 #1 PREEMPT Tue Jan 6 22:28:20 CET 2006 i686 GNU/Linux
```` 

Linux, Hostname, Version, #wie oft installiert, wann kompiliert, Architektur,  GNU/Linux  


Wenn man dann vergessen haben sollte ein Modul einzubauen, neue Hardware (z.b. usb-webcam) kauft, oder einfach nach Laune was neues probieren moechte, der wechselt wieder in das Verzeichnis des Kernels `# cd /usr/src/linux` ändert die Konfiguration. Diesesmal aber nur Module(!) entfernen und hinzufügen und aktualisiert das System:  

```bash
# make modules modules_install && depmod -a  
# modprobe <$modul>  
````

die letzten Änderungen (Module) sind auch ohne Reboot aktiv.


Mit ein wenig Routine automatisiert man das Wichtigste:
```bash
# cd sys/kernel/; wget ftp://ftp.de.kernel.org/pub/linux/kernel/v2.6/linux*20*.bz2; cd /usr/src/; tar xjvf ~/sys/kernel/linux*20*.bz2; ln -s linux<$revision> linux; cd linux; make menuconfig  
# make-kpkg kernel_image --revision=zoe1.0; dpkg --install ../linux-image-2.6.20_zoe1.0_i386.deb  
```
