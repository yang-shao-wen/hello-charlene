# helloCHARLENE

helloCHARLENE is a remotely accessible monitoring system for a goldfish (Charlene). The system utilizes whatever hardware was available at hand and is therefore not the simplest nor most elegant solution for such a system.

## Requirements

- The system shall have two cameras.
- All cameras shall be livestreamed.
- The livestreams shall be accessible over the internet through a web server.
- The system shall be wireless, requiring only a power cable for power.

## Available Hardware

- Raspberry Pi 3 Model B (has ethernet and wireless)
- 2 x Raspberry Pi 2 Model B (has ethernet but no wireless)
- 2 x Raspberry Pi Camera Module
- Linksys Router Model BEFSR41 (four ethernet ports, no wireless)

## System Map

INTERNET ----- Wireless Router ----- Pi 3
               192.168.1.1           wlan0: 192.168.1.100
                                     eth0: 192.168.0.100
                                          |
                                          |
                                          |
                                     Linksys Router
                                     192.168.0.1
                                     /         \
                                    /           \
                                   /             \
                   Pi 2                     Pi 2
                   eth0: 192.168.0.101      eth0: 192.168.0.102
                             |                        |
                             |                        |
                             |                        |
                           Camera                   Camera

## System Configuration

### Linksys Router

- Very old router, DHCP does not support static IP assignment
- Need to disable DHCP and have each device specify its own unique IP

1. Set router IP to `192.168.0.1`.
2. Disable DHCP.

### Raspberry Pi 2

1. Install camera module and enable using `raspi-config`.
2. Install `motion` and configure: `/etc/motion/motion.conf`.
3. Set hostname: `/etc/hostname` and `/etc/hosts`.
4. Set static IP: `/etc/dhcpcd.conf`.

### Wireless Router

1. Statically assign IP `192.168.1.100` to the Raspberry Pi 3.
2. Open ports 80, 8081, and 8082, and forward to `192.168.1.100`.

### Raspberry Pi 3

1. Set hostname: `/etc/hostname` and `/etc/hosts`.
2. Set static IP for eth0: `/etc/dhcpcd.conf`.
3. Connect to the internet using wlan0.
4. There are now two competing default gateways (via eth0 and wlan0). In order to successfully access the internet, need to delete the default gateway via eth0:
```
sudo cp config-eth0.service /etc/systemd/system
sudo cp config-eth0.sh /etc/systemd/system
sudo systemctl enable config-eth0
sudo reboot
```
5. Set up the web server:
```
sudo apt install nginx
sudo cp index.html /var/www/html/
```
6. Set up tunneling between wlan0 and eth0.
