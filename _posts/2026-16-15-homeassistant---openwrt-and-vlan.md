---
Status: Draft
Published: False
Layout: Post
Title: HomeAssistant - OpenWrt and VLAN
Author: Benjamin Moeller
Date: 2026-04-15 16:58:51 UTC
Categories: [How-to]
Tags: [HomeAssistant, OpenWrt, VLAN]
Comments: []
---


# Home Assistant

If you are using any reverse proxy to reach your HomeAssistant, make sure it is allowed in the HomeAssistant configuration.  
For example install the 'Studio Code Server' App in HomeAssistant and open the file `configuraion.yaml` from the folder 'CONFIG'. Add these lines:  

```
## Add for reverse proxy
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 192.168.40.80 # IP-Address of reverse proxy
    - 127.0.0.1 # Local address
homeassistant:
  external_url: "http://hass.domain.net"
```

Now restart your HomeAssistant.

Now add the firewall rule at your OpenWrt mein router:  
```
uci add firewall rule
uci set firewall.@rule[-1].src='dmz'
uci set firewall.@rule[-1].dest='lan'
uci set firewall.@rule[-1].name='ReverseProxy to HA'
uci set firewall.@rule[-1].dest_port='8123'
uci set firewall.@rule[-1].target='ACCEPT'
uci add_list firewall.@rule[-1].proto='tcp'
uci add_list firewall.@rule[-1].src_ip='192.168.40.80'
uci add_list firewall.@rule[-1].dest_ip='192.168.10.241'
```

## mDNS
HomeAssistant could be either in VLAN 10 (LAN) or in VLAN 50 (Server). Both has pros and cons, but I wouldn't put it to VLAN 30 (IoT), as it is far too powerful.  
Beside other protocolls, autotedection in HomeAssistant works via mDNS. A small local service at a lot of devices is boadcasting with IPv4 the Hostname and IP via UDP to 244.0.0.251 on port 5353 on both ends.  

Open your HomeAssistant and got to 'Settings - System - Network'. Down below is the 'Zeroconf-Browser' located. here you'll see the devices the HomeAssistant can see.  

The mDNS is not routable. Aanouncements will stay within its own Subnet (VLAN).  
Teh solution is called 'mDNS reflection'. We have our OpenWrt on both subnet, and the service avahi is capable of mDNS reflection.  

1. Login to your router via terminal (`ssh root@192.168.10.1`)  
2. Enter `pkg update && pkg add avahi-daemon`  
3. Open the configuration `vim /etc/avahi/avahi-daemon.conf`
4. Change `enable-reflector=no` to `yes`
5. Under `[server]` add `allow-interfaces=vSwitch.10,vSwitch.30`
6. Uncomment `domain-name=local`
7. Start/Enable the service: `/etc/init.d/dbus start && /etc/init.d/dbus enable && /etc/init.d/avahi-daemon start && /etc/init.d/avahi-daemon enable`

If we don't define the 'allow-interfaces', the mDNS requests will be reflected at all interfaces, also WAN. But for security we want to use the 'least privilege' approach and define the needed interfaces.  

Add the Firewall rule:  

- Open 'Network - Firewall'
  - Tab **General Settings**
    - Zone -> Forwards: 'IoT'
      - Input: **accept**, Output: accept, Intra Zone forward: drop

As default 'Input' is 'drop' for security. Here it will block the response of the mDNS forward in another VLAN.  

  - Tab **Traffic Rules**
    - Button 'Add'

```
uci add firewall rule
uci set firewall.@rule[-1].src='iot'
uci set firewall.@rule[-1].name='mDNS iot to HA'
uci set firewall.@rule[-1].src_port='5353'
uci set firewall.@rule[-1].dest_port='5353'
uci set firewall.@rule[-1].target='ACCEPT'
uci add_list firewall.@rule[-1].proto='udp'
uci add_list firewall.@rule[-1].dest_ip='244.0.0.251'
```


# Turn off the OpenWrt LED

If I want to place the satelites in the multimedia corner, the bedroom or similar, maybe the LED will be disturbing.

**Beryl AX (MT3000)**  

- Open 'System - LED Configuration'
  - Button 'Add LED Action'
    - Name `White off`
    - LED Name: 'white:system'
    - Trigger: 'Always off (kernel: none)
    - Interval: ' '
    - 'Default state' unchecked
    - Confirm with button 'Save'
  - Confirm with button 'Save & Apply'

The LED should turn off immediately.  

**Beryl (MT1300)**  
Here the normal LUCI Webinterface does not work.  

- Open 'System - Startup'
  - Tab **Local Startup**
  - Add the line `i2cset -f -y 0 0x30 0x04 0x00` before `exit 0`

The LED will stay off after next reboot, but you can set the line also via ssh.  


# Gl.iNet GL-S200 - Thread Border Router

## Setup for Network usage
We want the router only within the LAN. So the WAN port is a uplink, but not an internet interface.  

- Login via Browser at `http://192.168.8.1`
  - In the left menu 'System - Security'
    - Open Ports On Router - Button '+ Add'
      - Protocol: **TCP/UDP**
      - Port: `80`
      - Description: `http`
      - Enable: Check
    - Open Ports On Router - Button '+ Add'
      - Protocol: **TCP/UDP**
      - Port: `8081`
      - Description: `Thread`
      - Enable: Check

Now all relevant ports are available at the 'WAN' port.  
Your S200 should be available from your LAN at the DHCP assigned IP, for example http://192.168.30.200  

## Turn off WLAN

I've used the provided internal WLAN a long time for IoT seperation. But this isn't nesseccary anymore because of the whole new network with VLAN segmentation.  

- Login via Browser at `http://192.168.30.200`
  - In the left menu 'Wireless'
    - 'Enable Wi-Fi': Uncheck

## Setup Thread

The whole documentation is at https://docs.gl-inet.com/iot/en/thread_board_router/gl-s200/  
Special chapter for the HomeAssistant integration: https://docs.gl-inet.com/iot/en/thread_board_router/gl-s200/work_with_home_assistant/  

- Login via Browser at `http://192.168.30.200`
  - In the left menu 'Thread Mesh - Thread Network'
    - Enable if not already active
  - In the left menu 'Thread Mesh - Advanced'
    - Chapter: 'Backbone Router'
      - Choose: 'eth0'

- Open your HomeAssistant in a browser 'http://192.168.10.241:8123'
  - Go to 'Settings - Devices & Services'
    - Click '+ Add integration'
    - Search and install 'Open Thread Border Router'
      - URL: http://192.168.30.200:8081
    - Click '+ Add integration'
        - Search and install 'Thread'
- Go to 'Settings - Devices & Services'
    - Open 'Thread'
    - Click at the 'Config' symbol (wheel)
      - Select your 'GL-S200-xxx' router  
        (xxx is random, the same as your default SSID)
      - Click 'Add to prefered network'

