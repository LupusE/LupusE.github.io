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

Very common is the VLAN ID 1 as Management backend. Some VLAN equipment I've see was preconfigured and fixed on ID 1 as untagged to get initial and management access. I don't want ID 1.  
In most manuals I've found the ID where given in steps by 10. ID 10, ID 20, ID 30, ...  

## My layout would be

| Name | VLAN ID | IP range |
| --- | --- | --- |
| LAN | 10 | 192.168.10.0/24 |
| Guest | 20 | 192.168.20.0/24 |
| IOT | 30 | 192.168.30.0/24 |
| DMZ | 40 | 192.168.40.0/24 |
| Server | 50 | 192.168.50.0/24 |


### A more complex layout
If we enable IPv6, the basis configuration will most likely outsmart our whole security and port forwarding. The VLAN splitting should keep it in line.  
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
But it will need up to 3 Network interface per node. I'll think about this... later.  

# DNS
The DNS will be a simpler at the beginning, as we just want to have each host with the domain lan.domain.net, guest.domain.net and so on.

Later we need to add a Webfilter like AdGuard Home or PiHole.

The easiest way would be to provide the local DNS via DHCP:  
```
# Configure dnsmasq
uci -q delete dhcp.lan.dhcp_option
uci add_list dhcp.lan.dhcp_option="6,192.168.40.53"
uci commit dhcp
service dnsmasq restart
```

Don't forget to provide a firewall rule, so the VLANs can reach the DNS within the DMZ:  
```
uci add firewall rule
uci set firewall.@rule[-1].src='iot'
uci set firewall.@rule[-1].dest='dmz'
uci set firewall.@rule[-1].name='AdGuardHome IoT'
uci set firewall.@rule[-1].dest_port='53'
uci set firewall.@rule[-1].target='ACCEPT'
uci add_list firewall.@rule[-1].dest_ip='192.168.40.53'
```


# DHCP and DNS for VLANs in OpenWrt

If we configure multiple instances via Webfrontend, it goes crazy. The DHCP server per device tuns off. Turn it on delets the DNS settings.  
See: https://openwrt.org/docs/guide-user/base-system/dhcp_configuration
> The LuCI web interface has not been updated to support multiple dnsmasq instances. 

So we need to do the Setup manually. Like:

```
# Remove default instances
while uci -q delete dhcp.@dnsmasq[0]; do :; done
while uci -q delete dhcp.@dhcp[0]; do :; done
 
# Use network interface names for DHCP/DNS instance names
INST="lan guest iot dmz server"
for INST in ${INST}
do
uci set dhcp.${INST}_dns="dnsmasq"
uci set dhcp.${INST}_dns.domainneeded="1"
uci set dhcp.${INST}_dns.boguspriv="1"
uci set dhcp.${INST}_dns.filterwin2k="0"
uci set dhcp.${INST}_dns.localise_queries="1"
uci set dhcp.${INST}_dns.rebind_protection="1"
uci set dhcp.${INST}_dns.rebind_localhost="1"
uci set dhcp.${INST}_dns.local="/${INST}.domain.net/"
uci set dhcp.${INST}_dns.domain="${INST}.domain.net"
uci set dhcp.${INST}_dns.expandhosts="1"
uci set dhcp.${INST}_dns.nonegcache="0"
uci set dhcp.${INST}_dns.authoritative="1"
uci set dhcp.${INST}_dns.readethers="1"
uci set dhcp.${INST}_dns.leasefile="/tmp/dhcp.leases.${INST}"
uci set dhcp.${INST}_dns.resolvfile="/tmp/resolv.conf.d/resolv.conf.auto"
uci set dhcp.${INST}_dns.nonwildcard="1"
uci add_list dhcp.${INST}_dns.interface="${INST}"
uci add_list dhcp.${INST}_dns.notinterface="loopback"
uci set dhcp.${INST}="dhcp"
uci set dhcp.${INST}.instance="${INST}_dns"
uci set dhcp.${INST}.interface="${INST}"
uci set dhcp.${INST}.start="100"
uci set dhcp.${INST}.limit="150"
uci set dhcp.${INST}.leasetime="12h"
done

uci -q delete dhcp.@dnsmasq[0].notinterface
uci commit dhcp
service dnsmasq restart
```

Let all VLAN use the AdGuard Home (or PiHole) DNS server:  
```
uci add_list dhcp.guest.dhcp_option='6,192.168.40.53'
uci add_list dhcp.iot.dhcp_option='6,192.168.40.53'
uci add_list dhcp.lan.dhcp_option='6,192.168.40.53'
uci add_list dhcp.server.dhcp_option='6,192.168.40.53'
uci add_list dhcp.dmz.dhcp_option='6,192.168.40.53'
```

And allow the communication from the VLANs to the DNS:  
```
uci add firewall rule # =cfg2992bd
uci set firewall.@rule[-1].src='lan'
uci set firewall.@rule[-1].dest='dmz'
uci set firewall.@rule[-1].name='AdGuardHome LAN'
uci set firewall.@rule[-1].dest_port='53'
uci set firewall.@rule[-1].target='ACCEPT'
uci add_list firewall.@rule[-1].dest_ip='192.168.40.53'

uci add firewall rule # =cfg2992bd
uci set firewall.@rule[-1].src='guest'
uci set firewall.@rule[-1].dest='dmz'
uci set firewall.@rule[-1].name='AdGuardHome guest'
uci set firewall.@rule[-1].dest_port='53'
uci set firewall.@rule[-1].target='ACCEPT'
uci add_list firewall.@rule[-1].dest_ip='192.168.40.53'

uci add firewall rule # =cfg2992bd
uci set firewall.@rule[-1].src='iot'
uci set firewall.@rule[-1].dest='dmz'
uci set firewall.@rule[-1].name='AdGuardHome iot'
uci set firewall.@rule[-1].dest_port='53'
uci set firewall.@rule[-1].target='ACCEPT'
uci add_list firewall.@rule[-1].dest_ip='192.168.40.53'
```

The default DNS (192.168."VLAN ID".1) could also forward to the DNS. But this would use NAT, so the DNS would see all requests just from 'the VLAN', not per device. Here we see detailed statistic in AdGuard Home for each client.  


