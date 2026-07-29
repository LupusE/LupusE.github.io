---
Status: Published
Published: True
Layout: Post
Title: OpenWrt - New Home Network
Author: Benjamin Moeller
Date: 2026-04-15 16:58:51 UTC
Categories: [How-to]
Tags: [Products, OpenWrt, Glinet]
Comments: []
---

-- Work in Progress --


In https://blog.lupuse.org/2026/04/15/openwrt-new-home-network.html I wrote about my journey from a propretary network vendor to OpenWrt, including mesh (IEEE 802.11r aka "Fast transition").  

As the basic network works, I want to extend the infrastructure.  

## Infrastructure

### VLAN

I am using 4 VLAN

| VLAN ID | Purpose                                         |
| ---     | ---                                             |
| 1       | The main VLAN, the equivalent to the former LAN |
| 10      | The Guest VLAN, for visitors                    |
| 20      | The IoT VLAN, for all the talky devices         |
| 30      | DMZ, some Servers with contact to the Internet  |

The DMZ VLAN only exists on my Main router and on my Proxmox Server. The 'Dumb AP' are not aware of the DMZ, they can only reach devices in the DMZ trough the main router or internet.  

*Proxmox* is a virtualization host for Container (LXD) or VMs (qemu).  
In contrast to an *ESX*, Proxmox is and will be free (Communitiy Edition), even if companies can buy a professional subscription.  
In contrast to *VirtualBox*, Proxmox is not Oracle and not Desktop based. The Frontend is webbased and headless right from the beginning, not as alternative.  

#### Activate Proxmox for a DNS with adbocker
At first we make sure the Proxmox knows VLAN.
- Open the Proxmox Website, for example https://192.168.1.254:8006
- Login and choose at the left panel the Host, below 'datacenter'.
  - Click in the second left menu 'Network'
  - Choose 'vmbr0' (or the Interface with access to your (V)LAN) and above the Button 'Edit'
  - Make sure the checkmark is set at `VLAN aware`
  - Confirm with the button 'OK'

## DNS
The first new server is AdGuard Home.  
I used PiHole for a long time and it worked good. But I've been told AGH is a more modern and takes things like encrypted DNS over HTTPS more serious. So I want to take a peek.  

### Install AdGuard Home
Thanks to Proxmox and the community scripts, the setup is pretty easy:  
- Search for Adguard: https://community-scripts.org/scripts?q=adguard
  - Copy the line: `bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/adguard.sh)"`

If you have any doubts, you are right ... Just execute a commandline from the internet? As root user?  
Normally I would tell you don't do it. But the manual way needs much more time. Until now, only 1 of 3 Community Scripts worked at my envirionment.  

- Go to your Proxmox Host via https://192.168.1.253:8006/ and open the Shell (or use ssh)
  - Insert the copied line, press enter and answer a few questions.
- See in your OpenWrt **Status - Overview** the assigned IP
  - Click the Button 'Reserve IP' behind
  - Go to **Network - DHCP**, search the new entry and click the Button 'Edit' behind  

As we know, the DHCP traffic is assigned to TCP nad UDP 53. Thats the reason, why I like my DNS servers at the last octet .53 ... And we want our DNS Server in the DMZ, because it has direct contact to the internet  
Enter the IP: `192.168.30.53`
(For all knowitall readers: The S in DNS stands for 'Domain Name System'. So DNS Server is valid.)

- Reach AGH at https://192.168.30.53:3000/ in a browser.
  - Now everything should be okay, but the network don't know the nes DNS, so there will be no statistics.

### Update on AdGuardHome  
Even if DHCP and local DNS is now handled by the Flint2 (Main OpenWrt router), I think I'll switch back to PiHole.  
AGH provides a nice clean interface, but it is also very limited. Butit is a goodsolution on the go on travel routers with enough smace/power (Mudi7, SpitzAX), to filter unwanted trafic before it hits the VPN.  

## Configure OpenWrt
On the top menu: **Network - Interfaces**

- Interface 'wan', button 'Edit'
  - Tab: **Advanced Settings**
    - Uncheck 'Use DNS servers advertised by peer'
    - Enter `192.168.30.53` as 'Use custom DNS servers', save with the + (Plus) behind the line
    - Button 'Save'
- Button 'Save and Apply'

If IPv6 is activated, repeat the steps for the WAN6 interface 

- Interface 'wan6', button 'Edit'
  - Tab: **Advanced Settings**
    - Uncheck 'Use DNS servers advertised by peer'
    - Enter `IPv6 IP from 'Summary at Proxmox` as 'Use custom DNS servers', save with the + (Plus) behind the line
    - Button 'Save'
- Button 'Save and Apply'

Now you'll see increasing statistics. But everything from 192.168.1.1, your router.


AGH can do much more. But I don't want to move my netzworkmanagement fom OpenWrt to to AGH.  
You could also go to **Network - Interfaces** and open the VLAN 'Guest', IoT, DMZ'.

- Click on the button 'Edit'
  - Tab: **DHCP Server**
    - Subtab: **General Setup**
    - DHCP Options: `6,192.168.30.53,192.168.[n].1`
    - Button 'Save'
  - Button 'Save and Apply'

The option 6 means 'set DHCP DNS server, if asked'. This is not a force!  
After a comma the comma you'll entera comma seperated list of DHCP servers. Teh first entry is our AGH, and if it won't be available, the secondary is the router with the steps, we've done before.  

The 'lan' VLAN is able to reach the DMZ and will work instant.  
The 'Guest' and 'IoT' networks needs a Firewall rule to rach the DNS service, but not the web interface.  

Top menu: **Network - Firewall**
On the bottom the button 'Add'
- Tab: **General Settings**
  - Name: `AdGuardHome from Guest`
  - Protocol: 'TCP/UDP'
  - Source zone: 'guest'
  - Destination zone: 'dmz'
  - Destination address: `192.168.30.53`
  - Destination port: `53`
  - Button: 'Save'
- Repeat for every network
- Button 'Save and Apply'

And now the clients are listed individial in AGH. Another advantag eis a lower latency.  
The first way is 'Client - OpenWrt - AGH - OpenWrt - Internet'  
The second way is 'Client - AGH - OpenWrt - Internet'. One hop to process less.  




```
root@eva25:~# cat /tmp/resolv.conf.d/resolv.conf.auto
# Interface wan
nameserver 192.168.21.53
search lupuse.net
# Interface wan6
nameserver fd83:3954:baa8:0:c4d3:d2ff:fe72:975e
```
