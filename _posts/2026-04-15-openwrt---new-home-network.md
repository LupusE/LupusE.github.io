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

# Where my network come from?
For as long as I can remember, I've used AVM Fritz! devices as routers for my home network. First the Fritz!ISDN USB, then an external ISDN card, and then all sorts of Fritz!Box models. A device that simply does everything, from internet routing and a DECT base station with VoIP telephony to a fax modem when I no longer wanted a separate device at home. And all this with outstanding Linux support in a simple "mesh" network.  
The marketing term "mesh" here means, on the one hand you configure the Wi-Fi at a central point and the configuration is then distributed to all connected access points. On the other hand, it means that a device (e.g., a mobile phone) can seamlessly switch from one access point to another. This only works with AVM devices.  


From a technical perspective, several technologies come into play:  
The **"Wireless Mesh Network (WMN)"** is described in the standard [IEEE 802.11s](https://en.wikipedia.org/wiki/IEEE_802.11s). This standard enables the setup of a wireless mesh network with minimal configuration at the endpoints. Do I need this? OpenWrt addresses this in [are_you_sure_you_want_a_mesh](https://openwrt.org/docs/guide-user/network/wifi/mesh/802-11s#are_you_sure_you_want_a_mesh)... but in most cases, the following is sufficient:  
The **"Fast Basic Service Set (BSS) Transition"** from the standard [IEEE 802.11r](https://en.wikipedia.org/wiki/IEEE_802.11r).  

Standards mentioned in this context include:  
The term **"roaming"** is often used, which is defined by the standard [IEEE 802.11f](https://en.wikipedia.org/wiki/IEEE_802.11f) and ensures that there are no connection interruptions. This has been incorporated into the IEEE 802.11r standard since 2006. Therefore, I will not discuss it further.  
Roaming is also frequently mentioned. To optimize a mesh network, OpenWrt also supports the standards [IEEE 802.11k](https://de.wikipedia.org/wiki/IEEE_802.11k) (**Neighbor Reports**) and [IEEE 802.11v](https://en.wikipedia.org/wiki/IEEE_802.11v) (**Network-assisted roaming**), see: https://openwrt.org/docs/guide-user/network/wifi/roaming ... Both are now part of the general standard from 802.11-2024.  
Over the time I will check if and how these standards could improve the home network. For now I expect OpenWrt 25.x will do all the work for me.  

One thing AVM managed, which is not in any standard is the distibution of the configuration. In an AVM mesh, I am changing the SSID or the WiFi password at the master and it get synchronized with every AP. There is no IEEE standard to archive this, but as OpenWrt is deep down a linux, much can be archived by text files and the comandline.  

At first I will show how to set up one main router and one or two mesh AP wirth the web interface. At the end I will show where it will be shown in the commandline. But I assume a complete automation how to will be in another article.  

## If it's available ready-made, why build it yourself?
AVM worked perfectly for me for over 25 years. Last year, the family-run business was bought by a large corporation. It had already become apparent that their QA was no longer functioning flawlessly. Compared to other "big players," there are still very few security reports, but the firmware is being loaded with more and more features, and the bugs are piling up.  
The standards mentioned above, in contrast to the AVM Mesh, aim to be vendor-independent. Today, I'm building my entire network with GL.iNet devices because they best suit my infrastructure. Tomorrow, I might use a different company (Don't tell them!).  

For more than 7 years now, they provided a fast and reliable VPN to my home network with different travel (Shadow, Slate Plus, Slate 7, Spitz AX) and home routers (Marble, Slate AX, Flint 3e).  
It's about time to switch from a travel setup to a whole GL.iNet home network.  


# ISP Router Setup
In Germany, there was much discussion, but the mandatory use of a [specific router](https://de.wikipedia.org/wiki/Routerzwang) was abolished in August 2016. This means I can use any router I want at my endpoint; I'm not required to use a device from my ISP (Internet Service Provider).  
This sounds very positive on paper, but in practice, it often turns out that the end customer is held responsible in support cases because the router can't be accessed for analysis. As an end customer, do I want the provider to have access to my router and thus my network? Probably not.  
Changing routers requires a basic understanding of technology, so you might be tempted to argue to a first-level support representative that a service restart is sufficient and a power cycle isn't necessary... but in the end, you still end up unplugging it just to finally get a solution.  
While many providers offered Speedport or Zyxel routers, the AVM Fritz!Box was usually available as an alternative for an additional fee. Those who received a Fritz!Box from one of the major providers were sometimes lucky enough to have the standard firmware installed, while other times it required more effort, such as modifying the serial number in the [mdt](https://openwrt.org/docs/techref/flash.layout#mtd_memory_technology_device_and_mtdsplit) or similar steps. But real freedom is OpenWrt.  

For this reason, I decided to switch to [GL.iNet](https://www.gl-inet.com/).  
GL.iNet is based on OpenWrt and offers many features in its own interface, which makes it significantly easier to use. Perfectly adequate for normal home use, and the travel routers are invaluable when you're on the go.  
GL.iNet builds some of its router hardware with a closed-source SDK, making an upgrade or switch to native OpenWrt not so easy. Therefore, I chose the **Flint2 as main router** and from the **Beryl series as AP**, which are 100% OpenWrt supported.  

## GL.iNet Flint2 (GL-MT6000)
The [Flint2 (GL-MT6000)](https://www.gl-inet.com/products/gl-mt6000/) is not the newest model they are offering. Compared to my newest Fritz!Box 7590, its features are even more up-to-date. Even if there is "only" 2x2.5 Gbit ports (plus 4x1 Gbit) and WiFi 6, I still would call it the flagship.  
Most important for me: It is 100% OpenWrt compatible and supported.  

### Download OpenWrt
The Firmware Selector for OpenWrt is available at [https://firmware-selector.openwrt.org/](https://firmware-selector.openwrt.org/). Searching for `MT6000` will suggest the result `GL.iNet GL-MT6000`, which we select.  
In the upper right, behind the search field, you can select the version. I'm creating these instructions using version **25.12.2**. As long as we have a working Flint2, we select the `SYSUPGRADE` button below.  

For every conceivable status from 'Router working' to just before '[Router on fire](https://en.wikipedia.org/wiki/Lp0_on_fire)', there are different firmware options. Explaining them all would require a separate article. I will only mention [uBoot](https://docs.gl-inet.com/router/en/4/faq/debrick/) as last line of recovery here.  
In my tests, before I've had this how to, I just needed to reset the factory router by 10 seconds pressing the 'reset' button, twice. The devices are very hard to brick.  

### Installing OpenWrt
When the Flint2 is freshly started, the GL.iNet admin interface can be accessed at [http://192.168.8.1/](http://192.168.8.1/). The client connected to one of the LAN ports automatically receives an IP address via DHCP from the 192.168.8.0/24 network. This can be set manually if desired.  

On the left side of the menu, at '**System - Upgrade**', you can access the internal firmware upgrade. In the new window, under the 'Firmware Local Upgrade' tab, any compatible firmware file can be uploaded. Here we upload the file we just downloaded, e.g., `openwrt-25.12.2-mediatek-filogic-glinet_gl-mt6000-squashfs-sysupgrade.bin`.  
Very important: We absolutely do not want to copy the settings! While this might sound tempting, the settings of the GL.iNet firmware and OpenWrt are incompatible.  

After successful installation, OpenWrt can be accessed at [http://192.168.1.1/](http://192.168.1.1/). Enter `root` as the username and leave the password blank, click the button 'Login'.  
You may need to disable/enable your network interface to get a new DHCP address. If you set it manual before, you need to change it now. Of course a `dhclient -v` (Linux) or `ipconfig /renew` (Windows) would get a new DHCP address as well.  

The GL.iNet admin panel is much more modern and also intuitive. If someone is lost here in the LuCI menu, you could at every time switch back to [GL.iNet Firmware](https://dl.gl-inet.com/router/mt6000/stable) and still have a great device.  

## OpenWrt Basic Configuration
In general, OpenWrt is secure in its default state, as no unnecessary services are installed or started. Nevertheless, there are a few settings that should be configured before starting.  

In the top menu: **System - Administration**  

- Tab: **Router Password** -> Set password for root - No insecure default password is set, so you can't forget to change it.
- Tab: **SSH Access** -> Interface: 'lan' - This means that the remote Secure Shell (SSH) is only accessible via the LAN interface and not from the WAN or a subsequently configured VLAN.  
- Tab: **HTTP(S) Access** -> Redirect to HTTPS - OpenWrt is most compatible with HTTP. This option redirects to HTTPS, so passwords won't be transmitted insecure over the network.  

With the switch to 'Redirect to HTTPS', the router is using a self signed certificate. You will get a security warning in your browser, which is not an error. Just be aware what you are doing.  


A few system settings help integrate the system into the infrastructure.  

In the top menu: **System - System**  

- Tab: **General Settings** ->
  - Timezone: 'Europe/Berlin', Button: Sync with Browser (or NTP server)
  - Hostname: `OpenFlint2` Adjust for better identifying in dhcp/mesh
- Tab: **Time Synchronization** -> leave as is or select a different source

### Updating OpenWrt
Warning: A router is an embedded device with a very specific task. This system should be treated differently than a PC or mobile phone. Blindly updating all packages (`apk upgrade`) is used during initial installation, but once the services are configured, this approach can overwrite important configurations or individual customizations, thus may breake the network.  
At best, you'll immediately notice that one or more functions are no longer accessible; at worst, an undiscovered security vulnerability arises. If there's a urgent reason (bug fix, security vulnerability, etc.), upgrade the package and its dependencies. Else you should consider whether upgrading packages between major releases is necessary.  
Don't believe me? OpenWrt also claims this: https://openwrt.org/docs/guide-user/additional-software/apk#updating_packages  

In the top menu: **System - Software**  

#### Upgrade packages (one by one)
Actions: Button: 'Update Lists ...' -> Wait and Dismiss  
- Tab: **Updates** -> Select each package using the 'Upgrade...' button behind. - Be careful with the 'Allow overwriting conflicting package files' option, as local configurations can be overwritten. This also applies to certificate keys and VPN configurations. See warning above.  

#### Upgrade all packages (once)
In the terminal:  
Connect to OpenWrt via SSH, e.g., `ssh root@192.168.1.1`  

Starting with OpenWrt 25.12, the package manager changes from **opkg** to **apk**. This makes any commandline magic unnecessary:  
`apk update && apk upgrade`  

If you are using an OpenWrt before 25.12, use:  
`opkg update opkg list-upgradable | cut -f 1 -d ' ' | xargs -r opkg upgrade`  

Help with switching to APK: https://openwrt.org/docs/guide-user/additional-software/opkg-to-apk-cheatsheet  

### Configuring DHCP
OpenWrt has a top menu for DHCP setting, but this is for the service itself. The more relevant setting for your router is found in '**Network - Interfaces**' and the corresponding network adapter. The DHCP service is configured individually for each network adapter.  

In the menu at the top: **Network - Interfaces**  

Adapter: LAN - Button: Edit  

- Tab **General Settings** ->
  - IPv4 address: `192.168.1.1` (The interface address also determines the first octet of the assigned DHCP addresses)
  - IPv4 netmask: `255.255.255.0` (Determines the network size, here 192.168.1.0/24)
  - Tab: **Advanced Settings** -> Settings for the DHCP server, not for the clients - No changes necessary
  - Tab: **DHCP server** -> Settings for the DHCP service - No changes necessary
  - Tab: **General Settings** -> DHCP Options for e.g. individual DNS servers via DHCP (save with +)

#### About the lease time
In practice, it has proven effective to set the lease time to `1h` for the first few days to allow misconfigurations to be resolved quickly. In production, this can be set to a significantly longer time. Example:  
- LAN: 12h
- Guest: 4h
- IoT: 6h
- DMZ: 12h

If the DHCP Lease will time out, the client asks the server if it will be okay to stay on this IP. The DHCP either will renew the lease time or assign a new IP. In any case there is a small network traffic overhead, but not much impact on the clients.  
Only if the clients are fast changing and more than the DHCP range, a short time has advantages. In environments, like a cafe with wifi or multiple dynamic Kubernetes worker.  

### DNS (Domain Name Service)

DNS consists of two parts. First, names are resolved internally by the router's own DNS server, which can also include DHCP clients. Second, there is an upstream DNS server to which all queries that cannot be answered internally are forwarded.  

In the menu at the top: **Network - Interfaces**  

#### Internal DNS
By default, clients receive the router's own DNS server (IP address) via DHCP. In most cases of a home network, this shoud be good enough.  
If this is not desired, the DNS server(s) can be configured using DHCP Option 6:  

Adapter: LAN - Button: Edit  

- Tab: **DHCP server** -> DHCP server settings
  - Tab: **General Settings** -> `6,192.168.1.53,8.8.8.8` (save with +)

See: [https://openwrt.org/docs/guide-user/base-system/dhcp_configuration#providing_custom_dns_with_dhcp](https://openwrt.org/docs/guide-user/base-system/dhcp_configuration#providing_custom_dns_with_dhcp)

#### Upstream DNS
As default, a Router will get the DNS servers from provider at the WAN port. Not every user trusts the provider DNS, as they can make use of censorship, tracking or redirections as they like. Every internet user should decide which DNS will be the best:  
- `9.9.9.9` (`149.112.112.112`) - Quad9 is a fast european provider, which protects your privacy. On default it will block malware. Without protection: `9.9.9.10`. IPv6: `2620:fe::fe` (`2620:fe::9`)
- `8.8.8.8` (`8.8.4.4`) - gooles DNS. Fast, reliable, but google
- `1.1.1.1` (`1.0.0.1`) - Cloudflare. Fast, reliable, but also a big corporation. Other services are `1.1.1.2` with malware protecion or `1.1.1.3` with child protection.

Adapter: WAN - Button: Edit  

- Tab: **Advanced Settings** -> Uncheck 'Use DNS servers advertised by peer'  

See: [https://openwrt.org/docs/guide-user/base-system/dhcp_configuration#upstream_dns_provider](https://openwrt.org/docs/guide-user/base-system/dhcp_configuration#upstream_dns_provider)

#### NTP (Time Server)
Various protocols on the network and internet are time-dependent. For example, Kerberos for Windows authentication via Active Directory, but also OTP services and some encryption methods. An incorrect local system time will cause a discrepancy and thus a malfunctioning system.  

Top menu: **System - System**

- Tab: **Time Synchronization** -> Check 'Provide NTP Server' - This activates the time server function for clients in OpenWrt.
  - 'Bind NTP server': LAN

Provide timeserver via DHCP:  
- Tab: **DHCP server** -> DHCP server settings
  - Tab: **General Settings** -> `42,192.168.1.1` (save with +)

Check DHCP response: `nmap --script broadcast-dhcp-discover  -e eth0`  

Check timeserver on a client:  
Linux: `timedatectl` (status in systemd) or `chronyc sources` (when chrony is installed)  
Windows: `w32tm`  

## Creating Networks with VLANs
For some users there where some new information above this line. But this where just the basic configurations for one router and some clients. The network requires a bit more of planning. Take a short break here.  

Ready? Take a deep breath, grab a drink.  

OpenWrt has a security mechanism that saves configuration changes and activates them. If no new login to the web interface occurs within 90 seconds, the configuration is rolled back. This is very convenient for testing, especially at the beginning.  
However, I did manage to lock myself out despite the rollback. So, it's better to make smaller, incremental changes, saving and confirming them, rather than making one large change.  

I can easily create a bridge for each planned network segment and add the corresponding physical ports. I then assign the necessary configurations for DHCP and other settings to the bridge via 'Interfaces'.  
It works well for simple networks. But keeping track of the VLAN configurations at each port will become complicated.  

I choose to create a device called `vSwitch` and assigned all LAN ports (lan1, lan2, lan3, lan4, lan5. But not eth1 (wan)) to it. This simplifies centralized management.  

There are two types of ports for VLANs.  
1. **Untagged** means that anything connected to this port is a standard network device, not using the IEEE 802.1v standard.  
2. **Tagged** means that the connected devices understand VLANs according to IEEE 802.1v and specify which VLAN ID they belong to.  

The VLAN configuration is different on each device. At OpenWrt it is pretty easy.  
Set one VLAN ID untagged at each port, this will be your default LAN. Each device without VLAN ID will get in this network. Set the other VLAN ID to the ports as tagged and every tagged VLAN packet will be routet in its area.  
Depending on your Setup, the untagged VLAN ID could be a different per port, to route different devices in differend VLAN. But there cannot be more than one untagged, but zero, one or more tagged VLAN per port.  

### Prepare the switch

In the menu at the top: **Network - Interfaces**

- Tab: **Devices**
  - Button 'Add device configuration ...'
    - Device Type: 'Bridge device'
    - Device Name: '`vSwitch`', ...
    - Ports: Select ports that are not bound elsewhere
    - Button 'Save'
  - Device 'vSwitch', Button 'Configure'
    - Tab: 'Bridge VLAN filtering'
      - Button below left 'Add'
      - Add every VLAN ID you plan to use

The table should look something like:  

| VLAN ID | lan1  | lan2  | lan3  | lan4  | lan5  |
| :---    | :---: | :---: | :---: | :---: | :---: |
| 1       | U     | U     | U     | U     | U     |
| 10      | T     | T     | T     | T     | T     |
| 20      | T     | T     | T     | T     | T     |

Every not-VLAN-able device (normal PC and notebooks) at each port will be assigned to the VLAN ID 1, because it is untagged.  
If you want a port to be a 'guest' or 'IoT' port, just change at VLAN ID 1 the U to T and T to U at the associated VLAN ID.  

  - Button 'Save'

### Assign the main VLAN

- Tab: **Interfaces**
  - Device 'LAN' -> 'Edit' button
  - Device: Change from 'br-lan' to '`vSwitch.1`' (.1 is your VLAN ID)

The 'br-lan' device can be removed after access has been tested and continues to work.  

### Create the VLAN interfaces

- Tab: **Interfaces**
  - Button 'Add new interface ...'
  - Name: `guest` (`iot`, `dmz`, ...)
  - Protocol: 'Static address'
  - Device: 'Software VLAN: "`vSwitch.10`"' ("`vSwitch.20`", "`vSwitch.nn`", ...)
  - Button 'Create Interface'
  - IPv4 Address: `192.168.n.1`, Netmask: `255.255.255.0` - It has proven effective for /24 networks to set the third octet (n) to the same value as the VLAN ID (1, 10,20, ...).  
  - Tab: **DHCP Server**
    - Enable DHCP
    - Subtab: **General Setup**
      - Lease Time: `30m` ... just for the initial setup, later it can be increased.
  - Button 'Save and Apply'

## Firewall
A firewall is generally understood as a blocker for malicious traffic from the internet. But it can do much more. Using the firewall (up to OpenWrt 21.02, `iptables`; from OpenWrt 22.03 onwards, `nftables`), network traffic can not only be blocked but also redirected according to specific parameters (routing).  

First, we will optimize the firewall for general use in a home network.  

At the top of the menu: `Network - Firewall`  

- Tab: **General Settings**
  - Check 'Drop invalid packages'
  - Forward: 'Drop' - The default setting 'Reject' is secure but requires more CPU because it generates a negative response to requests. With 'Drop', the packet is simply discarded.
  - Zones:
    - LAN -> WAN: IPv4 Masquerading if main router
    - WAN -> Reject: Input drop, Intra-zone forward: drop, Masquerading: uncheck
  - Button: Add
    - Guest -> Reject: Input drop, Output accept, Intra-zone forward: accept, Masquerading: check
  - Button: Add
    - IoT -> Reject: Input drop, Output accept, Intra-zone forward: accept, Masquerading: check
    
| Zone -> ffd           | Input  | Output | Intra zone | IPv4 Masq | 
| :---                  | :---:  | :---:  | :---:      | :---:     |
| lan -> wan, dmz, drop | accept | accept | accept     |           |
| wan -> drop           | drop   | accept | drop       | x         |
| guest -> wan, drop    | drop   | accept | drop       |           |
| iot -> wan, drop      | drop   | accept | drop       |           |
| dmz -> wan, drop      | drop   | accept | drop       |           |

Under 'Allow forward to destination zone', you define where the network is allowed to send data. 'WAN' is usually specified here to allow internet access.  
Under 'Allowed forward from source zone', you define which network is allowed to communicate with this network. In the overview, this entry is then reversed and listed as 'destination' in the 'Source zone'.  

Individual rules are created to ensure the new network can reach a router. Depending on your preference, multiple protocols can be combined into one entry, but I would recommend separating the entries, especially for basic services. I might want to offload the DNS server later, but the router itself will remain the DHCP server.  

- Tab: **Traffic Rules**
  - Button: 'Add'
    - Name: `guest-dhcp`
    - Protocol: UDP
    - Source zone: guest
    - Destination zone: Device (input)
    - Destination port: `67 68`
  - Button: 'Add'
    - Name: `guest-dns`
    - Protocol: UDP, TCP
    - Source zone: guest
    - Destination zone: Device (input)
    - Destination port: `53`

Repeat this for all VLANs with corresponding names.  

### NAT
IPv4 addresses are limited, meaning you typically only get one IP address assigned by your Internet Service Provider. NAT (Network Address Translation) ensures that any device on the LAN can send a request to the WAN, and the response is sent back to the requesting device. To the internet, multiple requests from different devices appear as if they all originated from the router itself.  

Enable or disable NAT using the checkbox next to each rule. More granular control is possible via the 'NAT rules' tab.  

So far, we've created a wired network. This works with any OpenWrt device. If the device has at least two RJ45 ports (one for WAN, one for LAN), the configuration described above should work without any issues. In this case, all end devices should be VLAN-capable if we can't configure LAN ports for an extra untagged VLAN.  

## WLAN
Like many routers, the Flint2 has a WLAN function. This router has two radio devices, one for the 2.4 GHz band and one for 5 GHz. These are not active in the default OpenWrt configuration, even though a default profile with the SSID 'OpenWrt' is configured.  

In the menu at the top: **Network - Wireless**  
Hint: If this tab is not present, a driver for the Wi-Fi card must be installed. A list of supported drivers can be found at https://openwrt.org/docs/techref/driver.wlan/start  

### 2.4 GHz Main Wi-Fi

Under 'Radio 0', click the 'Edit' button on the template with 'SSID: OpenWrt' or create a new one using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AX, Channel 1, 6, or 11, Width: 20 MHz
  - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt LAN`
    - Network: 'lan'
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0001 for the main access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.
  - Subtab: **Advanced settings**
    - check 'Isolate clients' for Guest WLAN, if the clients should not be able to communicate with each other.

#### Overview of WLAN encryption
- **Open** - No. If you think you have a reason for an open WLAN, you don't in 2026.  
- **WEP/WPA** - Too old and insecure, we don't want that in our network; you might consider to choose "Open," which at least doesn't reveal the password.  
- **WPA2** - Offers high compatibility; especially for older devices or IoT devices, this should still be supported.  
- **WPA3** - This is the current standard. It's not only inherently more secure but also prevents remote deauthentication by unauthorized users.  

#### Information about 2,4 GHz WiFi channels
Generally, you're free to use any channel. However, it's recommended to stick with channels 1, 6, or 11, for 20 MHz channel width as these frequencies have the least overlap. This is the international rule of thumb, in Germany we have 2,4 GHz channels up to 13.  
While Wi-Fi can compensate for interference from competing Wi-Fi networks to a certain extent, this works better with Wi-Fi networks in the same frequency spectrum than with overlapping networks. Look out for 'Adjacent Channel Interference - ACI' or the opposite 'Co Channel Inteference'.  
Even the AP in your mesh should not have the same or overlapping channel to avoide interferences within the RF spectrum!  

1. Perform a frequency scan and see which channel has the least traffic.  
2. If possible, choose an unused frequency band.  
3. If no band is available, use the one with the lowest occupancy (and overlap) on channels 1, 6, or 11.  

### 5 GHz Main Wi-Fi
Under 'Radio 1', click the 'Edit' button on the template with 'SSID: OpenWrt' or create a new one using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AC, Channel 134 (three-digit channels allow for higher power output in some areas), Width: 40 MHz
  - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt LAN`
    - Network: 'lan'
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0001 for the main access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.
  - Subtab: **Advanced settings**
    - check 'Isolate clients' for Guest WLAN, if the clients should not be able to communicate with each other.

#### Information about 5 GHz WiFi channels
We have more channel in 5 GHz than 2,4 GHz, and we can use wider with. In some areas the 5 GHz band is even less occupied than the 2,4 GHz band. But physically the higher frequency results in less range.  
In the channels 52-144 (20 MHz), 38-142 (40 MHz), 58-138 (80 MHz) and 50-114 (160 MHz) is DFS (Dynamic Frequency Selection) required. You should avoid these, especially near radar stations, like airports or similar.  

### Guest/IoT Wi-Fi
For the LAN and Guest Wi-Fi you could easily use the same SSID in 2,4 and 5 GHz band. But IoT devices often do not work when there is a 5 GHz band with the same ESSID, even if they only speaking 2,4 GHz. I observed this at plenty Tuya and ESP32 devices.  
That's the reason, why I split the SSID to 'OpenWrt IoT2' and 'OpenWrt IoT5'.  

Create a new template under 'Radio 0' (2.4 GHz) using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AX, Channel 1, 6, or 11, Width: 20 MHz
    - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt Guest` (`OpenWrt IoT2`)
    - Network: 'Guest' ('iot')
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0001 for the main access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.
  - Subtab: **Advanced settings**
    - check 'Isolate clients' for Guest WLAN, if the clients should not be able to communicate with each other.

Create a new template under 'Radio 1' (5 GHz) using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AC, Channel 161 (three-digit channels allow higher power in some areas), Width: 40 MHz
    - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt Guest` (`OpenWrt IoT5`)
    - Network: 'Guest' ('iot')
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0001 for the main access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.
  - Subtab: **Advanced settings**
    - check 'Isolate clients' for Guest WLAN, if the clients should not be able to communicate with each other.

  
# MeshAP Setup
OpenWrt used to refer the 'satellites' in mesh networks as "Dumb APs". Today it is called "Bridged AP". These are essentially routers, but all routing functions and services (DHCP, DNS, etc.) are removed.  
See: [https://openwrt.org/docs/guide-user/network/wifi/wifiextenders/bridgedap](https://openwrt.org/docs/guide-user/network/wifi/wifiextenders/bridgedap)

## Beryl AX (Gl.iNet MT-3000)
The [Beryl AX (GL-MT3000)](https://www.gl-inet.com/products/gl-mt3000/) is a significantly smaller device than the Flint2. It offers only two LAN ports: One 2.5 Gbps for WAN and one 1 Gbps for LAN. Since it will only function as an access point, its WiFi 6 is perfectly adequate. The uplink to the Flint2 is handled via the WAN port as LAN port.  
For the initial setup, it is recommended to connect only one PC or laptop to the Beryl AX LAN port via cable. It can then be connected to the existing LAN via the WAN port, for example, to download the OpenWrt image.  

### Download OpenWrt
The Firmware Selector for OpenWrt is available at [https://firmware-selector.openwrt.org/](https://firmware-selector.openwrt.org/). Searching for `MT3000` will suggest the result `GL.iNet GL-MT3000`, which we should select.  
In the upper right, behind the search field, the version can be selected. I am creating this guide using `25.12.2`. As long as we have a working Beryl AX, we select the `SYSUPGRADE` button below.  

### Install OpenWrt
When the Beryl AX is freshly started, the interface can be accessed at [http://192.168.8.1/](http://192.168.8.1/). The client on one of the LAN ports automatically receives an IP address from the 192.168.8.0/24 network. This can be set manually if desired.  


On the left side of the menu, under '**System - Upgrade**', you'll find the internal firmware upgrade. In the new window, under the 'Firmware Local Upgrade' tab, you can upload any compatible firmware file. Here, we upload the file we just downloaded, for example, `openwrt-25.12.2-mediatek-filogic-glinet_gl-mt3000-squashfs-sysupgrade.bin`.  
Very important: We absolutely do not want to copy the settings! While this might sound tempting, the settings of the GL.iNet firmware and OpenWrt are incompatible.

After successful installation, OpenWrt can be accessed at [http://192.168.1.1/](http://192.168.1.1/). Enter `root` as the username and leave the password blank.  

## DumbAP Basic Configuration
In its basic installation, OpenWrt is a fully functional router. We could use two routers in the network, but this would increase the complexity. In our home network we just want to increase the WiFi and maybe have a second entry cable point.  
Two full functional routers would compete for DHCP assignments and similar tasks. Therefore, we'll disable some services first.  

### OpenWrt Router to Dumb AP

Top menu: **System - Startup**

- Tab: **Initscripts**
  - dnsmasq - Click buttons 'Enabled' and 'Stop' - No DNS resolver
  - firewall - Click buttons 'Enabled' and 'Stop' - No routing
  - odhcpd - Click buttons 'Enabled' and 'Stop' - No address assignment


A few system settings help to integrate the system into the infrastructure.  

In the top menu: **System - System**  

- Tab: **General Settings** ->
  - Timezone: 'Europe/Berlin', Button: Sync with Browser (or NTP server)
  - Hostname: `OpenBerylAX` - for a better identifying in dhcp/mesh
- Tab: **Time Synchronization** -> you may want to set it to `192.168.1.1` (main router)


### Add VLAN from main router

Top menu: **Network - Interfaces**

- Tab: **Interfaces** - we don't need the WAN uplink here
  - wan - Button: 'Delete'
  - wan6 - Button: 'Delete'

- Tab: **Devices**
  - Button: Add device configuration ...
    - Device type: 'Bridge device'
    - Device name: `vSwitch`
    - Ports: All available (eth0, lan1, ... Switch ports and Ethernet Adapter, no switches!)
  - Button Save
  - Choose 'vSwitch' and click button 'Configure ...'
    - Subtab: **Bridge VLAN filtering**

| VLAN ID | LAN1  | LAN2  |
| :---    | :---: | :---: |
| 1       | U     | U     |
| 10      | T     | T     |
| 20      | T     | T     |

Button: Save

Button 'Save and Apply'


### Change LAN access

Top menu: **Network - Interface**

- Subtab: **Interfaces**
  - Interface: lan, button: 'Edit'
  - Device: `vSwitch.1`
  - Button 'Save'
- Button 'Save and Apply'

- Subtab: **Interfaces**
  - Interface: lan, button: 'Edit'
  - Protocol: DHCP client, but don't click change protocol below! This prevents you from saving the setting.
  - Button: 'Save'
- Button: 'Save and Apply' 

Now you've got 90 seconds to connect your dumb AP to your main router, so it will get an DHCP address. See in main router at **Status - Overview** under 'Active DHCP Leases' which IP was assigned. Open this IP in a browser within 90 seconds, to confirm the changes.  
Of course you could write down the port MAC and set a static DHCP entry in your DHCP server. But even if you need to do this twice, 90 seconds is enough time.  

### Add the additional VLAN to the infrastructure  
Add every VLAN which is needed at the AP. 'Guest' and 'IoT' makes sense, but 'DMZ' proppably not.  

Top Menu: **Nnterface**  

- Subtab: **Interfaces**
  - Button: 'Add new interface...'
    - Name: `guest`, `iot`, ...
    - Protocol: Unmanaged (will be managed from the main router)
    - Device: `vSwitch.1`, `vSwitch.10`, `vSwitch.20`, ... 


### Static IP to DHCP
The AP could have a static IP, but it should be one from the management network range.  
I choose to set it as DHCP address and assign a static lease in DHCP of the main router.  

Top menu: **Network - Interfaces**

- Tab: **Interfaces**
  - Item 'Lan', Button 'Edit'
    - Change Protocol from 'Static address' to 'DHCP client'
    - Button 'Save'
  - Button 'Save and Apply'

Now connect WAN of the Beryl AX to one LAN of the Flint 2. The Flint2 will assign a address to the Beryl AX. The Flint will show the assigned addresss in the tom menu, **Status - Overview** in the chapter **DHCP Leases\Active DHCPv4 Leases**.
Remember: You've got 90 seconds to find out the address and open the portal. Else the changes will be reverted!

## WLAN
In the menu at the top: **Network - Wireless**  
Hint: If this tab is not present, a driver for the Wi-Fi card must be installed. A list of supported drivers can be found at https://openwrt.org/docs/techref/driver.wlan/start  

### 2.4 GHz Main Wi-Fi

Under 'Radio 0', click the 'Edit' button on the template with 'SSID: OpenWrt' or create a new one using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AX, Channel 1, 6, or 11, Width: 20 MHz
  - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt LAN`
    - Network: 'lan'
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0002 for the second access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.

### 5 GHz Main Wi-Fi
Under 'Radio 1', click the 'Edit' button on the template with 'SSID: OpenWrt' or create a new one using 'Add'.  

- Tab: **General Setup**
  - Operating Frequency: AC, Channel 134 (three-digit channels allow for higher power output in some areas), Width: 40 MHz
  - Subtab: **General Setup**
    - Mode: 'Access Point'
    - ESSID: `OpenWrt LAN`
    - Network: 'lan'
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0002 for the second access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.

### Guest/IoT Wi-Fi
Create a new template under 'Radio 0' (2.4 GHz) using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AX, Channel 1, 6, or 11, Width: 20 MHz
  - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt Guest` (`OpenWrt IoT2`)
    - Network: 'Guest' ('iot')
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0002 for the second access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.
  - Subtab: **Advanced settings**
    - check 'Isolate clients' for Guest WLAN, if the clients should not be able to communicate with each other.

Create a new template under 'Radio 1' (5 GHz) using 'Add'.

- Tab: **General Setup**
  - Operating Frequency: AC, Channel 161 (three-digit channels allow higher power in some areas), Width: 40 MHz
  - Subtab: **General Setup**
    - Mode: Access Point
    - ESSID: `OpenWrt Guest` (`OpenWrt IoT5`)
    - Network: 'Guest' ('iot')
  - Subtab: **Wireless Security**
    - 'WPA2-PSK/WPA3-SAE Mixed Mode'
    - Activate: "Enable KRACK countermeasure" 
  - Subtab: **Wi-Fi Roaming**
    - 802.11r -> Enable the checkbox
    - NAS ID: 0002 for the second access point, other access points with sequential numbering.
    - Mobility Domain: 4-byte hexadecimal value. This must be the same on all access points in the mesh. The default on newer OpenWrt versions is the first 4 bytes of the SSID, MD5sum.
  - Subtab: **Advanced settings**
    - check 'Isolate clients' for Guest WLAN, if the clients should not be able to communicate with each other.

## Beryl (Gl.iNet MT-1300)
The older Beryl provides only 1 Gbps LAN, but 3 ports. It has a slightly slower Wi-Fi.  
The process is pretty much the same as for the Beryl AX.


# CMD Tweaks
login to the router via `ssh root@192.168.1.1` or the IP or hostname of your main router.  

## WiFi management
There is a lot of potential for typing errors in the WLAN configuration. It does not hurt to take a look at the configuration.  

The first way to get a quick overview is the linux known standard:
`cat /etc/config/wireless`

The other is the OpenWrt way:  
`uci show config`

Changes can be made via text editor in the first example, which is known and convinient. But the OpenWrt tool uci does not need a parser for changes, for example `uci set wireless.default_radio0.ssid='OpenWrt One'`.  

