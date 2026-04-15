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

For as long as I can remember, I've used AVM Fritz! devices as routers for my home network. First the Fritz!ISDN USB, then an external ISDN card, and then all sorts of Fritz!Box models. A device that simply does everything, from internet routing and a DECT base station with VoIP telephony to a fax modem when I no longer wanted a separate device at home. And all this with outstanding Linux support in a simple "mesh" network.  
The marketing term "mesh" here means, on the one hand you configure the Wi-Fi at a central point and the configuration is then distributed to all connected access points. On the other hand, it means that a device (e.g., a mobile phone) can seamlessly switch from one access point to another. This only works with AVM devices.  

From a technical perspective, several technologies come into play:  
The "Wireless Mesh Network (WMN)" is described in the standard [IEEE 802.11s](https://en.wikipedia.org/wiki/IEEE_802.11s). This standard enables the setup of a wireless mesh network with minimal configuration at the endpoints. Do I need this? OpenWRT addresses this in [are_you_sure_you_want_a_mesh](https://openwrt.org/docs/guide-user/network/wifi/mesh/802-11s#are_you_sure_you_want_a_mesh)... but in most cases, the following is sufficient:  
The "Fast Basic Service Set (BSS) Transition" from the standard [IEEE 802.11r](https://en.wikipedia.org/wiki/IEEE_802.11r).  


Standards mentioned in this context include:  
The term "roaming" is often used, which is defined by the standard [IEEE 802.11f](https://en.wikipedia.org/wiki/IEEE_802.11f) and ensures that there are no connection interruptions. This has been incorporated into the IEEE 802.11r standard since 2006. Therefore, I will not discuss it further.  
Roaming is also frequently mentioned. To optimize a mesh network, OpenWrt also supports the standards [IEEE 802.11k](https://de.wikipedia.org/wiki/IEEE_802.11k) (Neighbor Reports) and [IEEE 802.11v](https://en.wikipedia.org/wiki/IEEE_802.11v) (Network-assisted roaming), see: https://openwrt.org/docs/guide-user/network/wifi/roaming ... Both are now part of the general standard from 802.11-2024.  

# If it's available ready-made, why build it yourself?
AVM worked perfectly for me for over 25 years. Last year, the family-run business was bought by a large corporation. It had already become apparent that their QA was no longer functioning flawlessly. Compared to other "big players," there are still very few security reports, but the firmware is being loaded with more and more features, and the bugs are piling up.  
The standards mentioned above aim to be vendor-independent. Today, I'm building my entire network with GL.iNet devices because they best suit my infrastructure. Tomorrow, I might use a different company.  

# ISP Router Setup
In Germany, there was much discussion, but the mandatory use of a specific router (https://de.wikipedia.org/wiki/Routerzwang) was abolished in August 2016. This means I can use any router I want at my endpoint; I'm not required to use a device from my ISP (Internet Service Provider).  
This sounds very positive on paper, but in practice, it often turns out that the end customer is held responsible in support cases because the router can't be accessed for analysis. As an end customer, do I want the provider to have access to my router and thus my network? Probably not. Changing routers requires a basic understanding of technology, so you might be tempted to argue to a first-level support representative that a service restart is sufficient and a power cycle isn't necessary... but in the end, you still end up unplugging it just to finally get a solution.  
While many providers offered Speedport or Zyxel routers, the AVM Fritz!Box was usually available as an alternative for an additional fee. Those who received a Fritz!Box from one of the major providers were sometimes lucky enough to have the standard firmware installed, while other times it required more effort, such as modifying the serial number in the [mdt](https://openwrt.org/docs/techref/flash.layout#mtd_memory_technology_device_and_mtdsplit) or similar steps.  

For this reason, I decided to switch to GL.iNet.  
GL.iNet is based on OpenWrt and offers many features in its own interface, which makes it significantly easier to use. Perfectly adequate for normal home use, and the travel routers are invaluable when you're on the go.  
Unfortunately, GL.iNet builds some of its router hardware with a closed-source SDK, making an upgrade or switch to native OpenWrt not so easy. Therefore, I chose the Flint2 as the base and the Beryl series as satellites, which are 100% OpenWrt supported.  

## GL.iNet Flint2 (GL-MT6000)
The [Flint2 (GL-MT6000)](https://www.gl-inet.com/products/gl-mt6000/) is a bit dated, but with 2x 2.5 Gbit RJ45 (plus 4x 1 Gbit) and WiFi 6, it's not too old. Compared to my newest Fritz!Box 7590, its features are even more up-to-date.  

### Download OpenWrt
The Firmware Selector for OpenWrt is available at [https://firmware-selector.openwrt.org/](https://firmware-selector.openwrt.org/). Searching for `MT6000` will suggest the result `GL.iNet GL-MT6000`, which we should select.  
In the upper right corner, behind the search field, you can select the version. I'm creating these instructions using version 25.12.2. As long as we have a working Flint2, we select the `SYSUPGRADE` button below.  

For every conceivable status from 'Router working' to 'Router on fire', there are different firmware options. Explaining them all would require a separate post.  

### Installing OpenWrt
When the Flint2 is freshly started, the GL.iNet admin interface can be accessed at [http://192.168.8.1/](http://192.168.8.1/). The client connected to one of the LAN ports automatically receives an IP address from the 192.168.8.0/24 network. This can be set manually if desired.  

On the left side of the menu, under 'System - Upgrade', you can access the internal firmware upgrade. In the new window, under the 'Firmware Local Upgrade' tab, any compatible firmware file can be uploaded. Here we upload the file we just downloaded, e.g., `openwrt-25.12.2-mediatek-filogic-glinet_gl-mt6000-squashfs-sysupgrade.bin`.  
Very important: We absolutely do not want to copy the settings! While this might sound tempting, the settings of the GL.iNet firmware and OpenWrt are incompatible.  

After successful installation, OpenWrt can be accessed at [http://192.168.1.1/](http://192.168.1.1/). Enter `root` as the username and leave the password blank.  

## OpenWrt Basic Configuration
In general, OpenWrt is secure in its default state, as no unnecessary services are installed or started. Nevertheless, there are a few settings that should be configured before starting.  

In the top menu: System - Administration  

- Tab: Router Password -> Set password for root
  No default password is set in the default configuration, so you can't forget to change it.
- Tab: SSH Access -> Interface: lan
  This means that the remote Secure Shell (SSH) is only accessible via the LAN interface and not from the WAN or a subsequently configured VLAN.  
- Tab: HTTP(S) Access -> Redirect to HTTPS
  OpenWrt is compatible with HTTP at its maximum. This option redirects it to HTTPS, so that, for example, passwords are no longer transmitted in plain text over the network.  

A few system settings help integrate the system into the infrastructure.  


In the top menu: System - System  

- Tab: General Settings ->
  - Timezone: 'Europe/Berlin', Button: Sync with Browser (or NTP server).
  - Hostname: Adjust for Mesh
  - Tab: Time Synchronization -> leave as is or select a different source

### Updating OpenWrt
A router is an embedded device with a very specific task. This system should be treated differently than a PC or a game console. Blindly updating all packages (`apk upgrade`) is useful during initial installation, but once the services are configured, this approach can overwrite important configurations or individual customizations, thus breaking the network.  
At best, you'll immediately notice that one or more functions are no longer accessible; at worst, an undiscovered security vulnerability arises. If there's no urgent reason (bug fix, security vulnerability, etc.), you should consider whether upgrading packages between major releases is necessary.  
Don't believe me? OpenWrt also claims this: https://openwrt.org/docs/guide-user/additional-software/apk#updating_packages

In the top menu: System - Software  

Actions: Button: 'Update Lists ...' -> Wait and Dismiss  
Tab: Updates -> Select each package using the 'Upgrade...' button.  
Be careful with the 'Allow overwriting conflicting package files' option, as local configurations can be overwritten. This also applies to certificate keys and VPN configurations. See above.  

In the terminal:  
Connect to OpenWrt via SSH, e.g., `ssh root@192.168.1.1`  
`opkg update opkg list-upgradable | cut -f 1 -d ' ' | xargs -r opkg upgrade`  

Starting with OpenWrt 25.12, the package manager changes from **opkg** to **apk**. This also makes the cut/xargs magic unnecessary:  
`apk update && apk upgrade`  

Help with switching to APK: https://openwrt.org/docs/guide-user/additional-software/opkg-to-apk-cheatsheet  

### Configuring DHCP
OpenWrt has a DHCP setting, but this is for the service itself. The more relevant setting for your router is found under 'Network - Interfaces' and the corresponding network adapter. The DHCP service is configured individually for each network adapter.  

In the menu at the top: Network - Interfaces  

Adapter: LAN - Button: Edit  

- Tab 'General Settings' ->
  - IPv4 address: 192.168.1.1 (The interface address determines the first octet of the assigned DHCP addresses)
  - IPv4 netmask: 255.255.255.0 (Determines the network size, here 192.168.1.0/24)
  - Tab: 'Advanced Settings' -> Settings for the DHCP server, not for the clients
  - Tab: 'DHCP server' -> Settings for the DHCP server
  - Tab: 'General Settings' -> DHCP Options for, e.g., individual DNS servers via DHCP (save with +)

In practice, it has proven effective to set the lease time to 2 hours for the first few days to allow misconfigurations to be resolved quickly. In practice, this can be set to a significantly longer time.


### DNS (Domain Name Service)

DNS consists of two parts. First, names are resolved internally by the router's own DNS server, which can also include DHCP clients. Second, there is an upstream DNS server to which all queries that cannot be answered internally are forwarded.  

In the menu at the top: Network - Interfaces  

#### Internal
By default, clients receive the router's own DNS server (IP address) via DHCP. If this is not desired, the DNS server(s) can be configured using DHCP Option 6:  

Adapter: LAN - Button: Edit  

- Tab: 'DHCP server' -> DHCP server settings
  - Tab: 'General Settings' -> `6,192.168.1.53,8.8.8.8` (save with +)

#### Upstream
Adapter: WAN - Button: Edit  

- Tab: 'Advanced Settings' -> Uncheck 'Use DNS servers advertised by peer'  

#### NTP (Time Server)
Various protocols on the network and internet are highly time-dependent. For example, Kerberos for Windows authentication via Active Directory, but also OTP services and some encryption methods. An incorrect local system time will cause a discrepancy and thus a malfunctioning system.  

Top menu: System - System

- Tab: Time Synchronization -> Check 'Provide NTP Server'
  This activates the time server function for clients in OpenWrt.
  - 'Bind NTP server': LAN

(To do: DHCP NTP server)

## Creating Networks with VLANs
Networks require a bit more planning. Take a short break here, take a deep breath, and grab a drink.

OpenWrt has a security mechanism that saves configuration changes and activates them. If no new login to the web interface occurs within 90 seconds, the configuration is rolled back.  
This is very convenient for testing, especially at the beginning. However, I did manage to lock myself out despite the rollback. So, it's better to make smaller, incremental changes, saving and confirming them, rather than making one large change.  

I can easily create a bridge for each planned network segment and add the corresponding physical ports. I then assign the necessary configurations for DHCP and other settings to the bridge via 'Interfaces'.  
It works. However, keeping track of the VLAN configurations becomes complicated.  

I choose to create a device called 'vSwitch' and assigned all LAN ports (except WAN) to it. This simplifies centralized management.  

There are two types of ports for VLANs.  
1. Untagged means that anything connected to this port is a standard network device, not using the IEEE 802.1v standard.  
2. Tagged means that the connected devices understand VLANs according to IEEE 802.1v and specify which VLAN ID they belong to.  

A special feature of OpenWrt is that the port can handle a single untagged VLAN and multiple tagged VLANs. Anything connected to the port without VLAN configuration is routed to a default VLAN. This doesn't work with all VLAN devices; most I know can only manage one untagged ID or any number of tagged IDs per port.  

In the menu at the top: Network - Interfaces

- Tab: 'Devices'
  - Button 'Add device configuration ...'
    - Device Type: 'Bridge device'
    - Device Name: 'vSwitch', ...
    - Ports: Select ports that are not bound elsewhere
    - Tab: 'VLAN'

| VLAN ID | LAN1  | LAN2  | LAN3  | LAN4  | LAN5  |
| :---    | :---: | :---: | :---: | :---: | :---: | 
| 1       | U     | U     | U     | U     | U     |
| 10      | T     | T     | T     | T     | T     |
| 20      | T     | T     | T     | T     | T     |

- Tab: 'Interfaces'
  - Device 'LAN' -> 'Edit' button
  - Device: Change from 'br-lan' to 'vSwitch.1' (.1 is your VLAN ID)

The 'br-lan' device can be removed after access has been tested and continues to work.  

Now create the other VLANs:  

- Tab: 'Interfaces'
  - Button 'Add new interface ...'
  - Name: 'guest' ('iot', 'dmz', ...)
  - Protocol: 'Static address'
  - Device: 'Bridge: "vSwitch.10"' ("vSwitch.20", "vSwitch.nn", ...)
  - Button 'Create Interface'
  - IPv4 Address: 192.168.n.1, Netmask: 255.255.255.0
    It has proven effective for /24 networks to set the third octet (n) to the same value as the VLAN ID.  
- Tab: DHCP
  - Enable DHCP

Button 'Save and Apply'

## Firewall
The firewall is generally understood as a blocker for malicious traffic from the internet. However, a Linux firewall can do much more. Using the firewall (up to OpenWrt 21.02, `iptables`; from OpenWrt 22.03 onwards, `nftables`), network traffic can not only be blocked but also redirected according to specific parameters.  

First, we will optimize the firewall for general use in a home network.  

At the top of the menu: Network - Firewall  

- Tab: 'General Settings'
  - Check 'Drop invalid packages'
  - Forward: 'Drop'
    The default setting 'Reject' is secure but requires more CPU because it generates a negative response to requests. With 'Drop', the packet is simply discarded.
  - Zones:
    - LAN -> WAN: IPv4 Masquerading if main router
    - WAN -> Reject: Input drop, Intra-zone forward: drop, Masquerading: uncheck
  - Button: Add
    - Guest -> Reject: Input drop, Output accept, Intra-zone forward: accept, Masquerading: check
  - Button: Add
    - IoT -> Reject: Input drop, Output accept, Intra-zone forward: accept, Masquerading: check

Under 'Allow forward to destination zone', you define where the network is allowed to send data. 'WAN' is usually specified here to allow internet access.  
Under 'Allowed forward from source zone', you define which network is allowed to communicate with this network. In the overview, this entry is then reversed and listed as 'destination' in the 'Source zone'.  

Individual rules are created to ensure the new network can reach a router. Depending on your preference, multiple protocols can be combined into one entry, but I would recommend separating the entries, especially for basic services. I might want to offload the DNS server later, but the router itself will remain the DHCP server.  

- Tab: 'Traffic Rules'
  - Button: 'Add'
    - Name: 'guest-dhcp'
    - Protocol: UDP for DHCP
    - Source zone: guest
    - Destination zone: Device (input)
    - Destination port: 67 68
  - Button: 'Add'
    - Name: 'guest-dns'
    - Protocol: UDP, TCP
    - Source zone: guest
    - Destination zone: Device (input)
    - Destination port: 53

Repeat this for all VLANs with corresponding names.

### NAT
IPv4 addresses are limited, meaning you typically only get one IP address assigned by your Internet Service Provider. NAT (Network Address Translation) ensures that any device on the LAN can send a request to the WAN, and the response is sent back to the requesting device. To the internet, multiple requests from different devices appear as if they all originated from the router itself.  

Enable or disable NAT using the checkbox next to each rule. More granular control is possible via the 'NAT rules' tab.  

So far, we've created a wired network. This works with any OpenWrt device. If the device has at least two RJ45 ports (one for WAN, one for LAN), the configuration described above should work without any issues. In this case, all end devices should be VLAN-capable if we can't configure LAN ports for an extra untagged VLAN.  

## WLAN
Like many routers, the Flint2 has a WLAN function. This router has two radio devices, one for the 2.4 GHz band and one for 5 GHz. These are not active in the default OpenWrt configuration, even though a default profile with the SSID 'OpenWrt' is configured.  

In the menu at the top: Network - Wireless  
Hint: If this tab is not present, a driver for the Wi-Fi card must be installed. A list of supported drivers can be found at https://openwrt.org/docs/techref/driver.wlan/start  

### 2.4 GHz Main Wi-Fi

Under 'Radio 0', click the 'Edit' button on the template with 'SSID: OpenWrt' or create a new one using 'Add'.

- Tab: 'General Setup'
  - Operating Frequency: AX, Channel 1, 6, or 11, Width: 20 MHz
  - Sub-tab: 'General Settings'
    - ESSID: The name of the WLAN
    - Network: One of the interfaces created under 'Network - Interfaces'.
  - Sub-tab: 'WLAN Encryption'
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
  - Sub-tab: 'WLAN Roaming'
    - 802.11r -> Enable checkbox
    - NAS ID: 0001 for the main access point, all other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. Default on newer OpenWrt versions: The first 4 bytes of the SSID MD5sum.

Overview of WLAN encryption:  
- Open - No.  
- WEP/WPA - Too old, we don't want that in our network; you might as well choose "Open," which at least doesn't reveal the password.  
- WPA2 - Offers maximum compatibility; especially for older devices or IoT devices, this should still be supported.  
- WPA3 - This is the current standard. It's not only inherently more secure but also prevents remote deauthentication by unauthorized users.  

Hint: Generally, you're free to use any channel. However, it's recommended to stick with channels 1, 6, or 11, as these frequencies have the least overlap. While Wi-Fi can compensate for interference from competing Wi-Fi networks to a certain extent, this works better with Wi-Fi networks in the same frequency spectrum than with overlapping networks.  
1. Perform a frequency scan and see which channel has the least traffic.  
2. If possible, choose an unused frequency band.  
3. If no band is available, use the one with the lowest occupancy (and overlap) on channels 1, 6, or 11.  

### 5 GHz Main Wi-Fi
Under 'Radio 1', click the 'Edit' button on the template with 'SSID: OpenWrt' or create a new one using 'Add'.

- Tab: 'General Setup'
  - Operating Frequency: AC, Channel 134 (three-digit channels allow for higher power output in some areas), Width: 40 MHz
  - Sub-tab: 'Wi-Fi Roaming'
    - 802.11r -> Enable the checkbox
    - NAS ID: 0001 for the main access point, all other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.  

### Guest/IoT Wi-Fi
Create a new template under 'Radio 0' (2.4 GHz) using 'Add'.

- Tab: 'General Setup'
  - Operating Frequency: AX, Channel 1, 6, or 11, Width: 20 MHz
  - Tab: 'Advanced settings': Isolate clients

Create a new template under 'Radio 1' (5 GHz) using 'Add'.

- Tab: 'General Setup'
  - Operating Frequency: AC, Channel 161 (three-digit channels allow higher power in some areas), Width: 40 MHz
  
# MeshAP Setup
OpenWrt refers to the 'satellites' in the mesh network as "Dumb APs." These are essentially routers, but all routing functions and services (DHCP, DNS, etc.) are removed.  

## Beryl AX (Gl.iNet MT-3000)
The [Beryl AX (GL-MT3000)](https://www.gl-inet.com/products/gl-mt3000/) is a significantly smaller device than the Flint2. It offers only two LAN ports: one 2.5 GHz for WAN and one 1 Gbps for LAN. Since it will only function as an access point, its WiFi 6 is perfectly adequate. The upgrade to the Flint2 is handled via the WAN port.  
For the initial setup, it is recommended to connect only one PC or laptop to the Beryl AX LAN port via cable. It can then be connected to the existing LAN via the WAN port, for example, to download the OpenWRT image.  

### Download OpenWrt
The Firmware Selector for OpenWrt is available at [https://firmware-selector.openwrt.org/](https://firmware-selector.openwrt.org/). Searching for `MT3000` will suggest the result `GL.iNet GL-MT3000`, which we should select.  
In the upper right corner, behind the search field, the version can be selected. I am creating this guide using `25.12.2`. As long as we have a working Beryl AX, we select the `SYSUPGRADE` button below.  

### Install OpenWrt
When the Beryl AX is freshly started, the interface can be accessed at [http://192.168.8.1/](http://192.168.8.1/). The client on one of the LAN ports automatically receives an IP address from the 192.168.8.0/24 network. This can be set manually if desired.  


On the left side of the menu, under 'System - Upgrade', you'll find the internal firmware upgrade. In the new window, under the 'Firmware Local Upgrade' tab, you can upload any compatible firmware file. Here, we upload the file we just downloaded, for example, `openwrt-25.12.2-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin`.  
Very important: we absolutely do not want to copy the settings! While this might sound tempting, the settings of the GL.iNet firmware and OpenWrt are incompatible.

After successful installation, OpenWrt can be accessed at [http://192.168.1.1/](http://192.168.1.1/). Enter `root` as the username and leave the password blank.  

## DumbAP Basic Configuration
In its basic installation, OpenWrt is a fully functional router. We can't use two routers in the network; they would then compete for DHCP assignments and similar tasks. Therefore, we'll disable some services first.  

### OpenWrt Router to Dumb AP
... to be continued ...
