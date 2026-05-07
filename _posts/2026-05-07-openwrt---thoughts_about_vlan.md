---
Status: Draft
Published: False
Layout: Post
Title: OpenWrt - Thoughts about VLAN and DNS
Author: Benjamin Moeller
Date: 2026-04-15 16:58:51 UTC
Categories: [How-to]
Tags: [Products, OpenWrt, VLAN]
Comments: []
---

# VLAN
In my previous post I've set up a new home network. All started with the urge to split 'LAN', 'guest' and 'IoT'.  
But during the process I already added the VLAN 'DMZ' and as latest 'Server'.  

Very common is the VLAN ID 1 as Management backend. A lot of VLAN equipment I've see was preconfigured on ID 1 as untagged to get initial access. I don't want ID 1.  
In most manuals I've found the ID where given in steps by 10. ID 10, ID 20, ID 30, ...  

## My new layout would be

| Name | VLAN ID | IP range |
| --- | --- | --- |
| LAN | 10 | 192.168.10.0/24 |
| Guest | 20 | 192.168.20.0/24 |
| IOT | 30 | 192.168.30.0/24 |
| DMZ | 40 | 192.168.40.0/24 |
| Server | 50 | 192.168.50.0/24 |


## More complex layout
Today, while walking the dog, Willow asked me whats about splitting IPv4 and IPv6. Together we developed a schema.  

| Name | VLAN ID | IP range |
| --- | --- | --- |
| LAN | 10 | 192.168.10.0/24, SLAAC |
| LANv4 | 14 | 192.168.14.0/24 |
| LANv6 | 16 | SLAAC |
| Guest | 20 | 192.168.20.0/24, SLAAC |
| Guestv4 | 24 | 192.168.24.0/24 |
| Guestv6 | 26 | SLAAC |
| IOT | 30 | 192.168.30.0/24, SLAAC |
| IOTv4 | 34 | 192.168.34.0/24 |
| IOTv6 | 36 | SLAAC |
| DMZ | 40 | 192.168.40.0/24, SLAAC |
| DMZv4 | 44 | 192.168.44.0/24 |
| DMZv6 | 46 | SLAAC |
| Server | 50 | 192.168.50.0/24, SLAAC |
| Serverv4 | 54 | 192.168.54.0/24 |
| Serverv6 | 56 | SLAAC |
| VPN | 60 | 192.168.50.0/24, SLAAC |
| VPNv4 | 64 | 192.168.54.0/24 |
| VPNv6 | 66 | SLAAC |

The main VLAN would provide IPv4 and IPv6, as usual. With a dedicated cut between IPv4 and IPv6 I could at one hand be sure my firewall rules will be set and on the other hand I could test dedicated IPv6 connections. SLAAC, AutoMTU, ...  
But it will need up to 3 Network interface per node. I'll think about this.

# DNS
In my first post I've started with a simple OpenWrt DNS and AdGuard Home as filter. Its really hard not to make a loop or knot in the configuration and keep it secure.  

As we defined the VLAN earlier, I would use subdomains to split the local DNS as well.  

- Go to OpenWrt in a browser at 192.168.10.1
- Go to 'Network - DNS'
- On the top you'll find the 'default instance'.
  - Subtab **General**
    - Local Domain is 'lan.lupuse.net'
  - Subtab **Devices & Ports**
    - Listen interfaces: `LAN`
- Below is the field **New Instance Name**
  - Enter `guest` and confirm with 'Add server instance'
  - Subtab **General**
    - Local Domain is 'guest.lupuse.net'
  - Subtab **Devices & Ports**
    - Listen interfaces: `guest`

Repeat these steps with 'dmz', 'server', ... 

And here it gest crazy. The DHCP server per device tuns off. Turn it on delets the DNS settings.
To Analyze!
