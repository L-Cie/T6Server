
![alt text](https://img.shields.io/badge/Arch_Linux-blue?logo=Archlinux)
![alt text](https://img.shields.io/badge/Plutonium-T6-orange)

<img src="https://imgur.com/bBrx8Hf.png" alt="drawing" width="350"/> <img src="https://i.postimg.cc/W3Ptmq0R/Final-Fantasy-Female-xr4zz.png" alt="drawing" width="340"/>

# T6Server
This repository provides all necessary files for a simple installation and configuration of a T6 server on Arch Linux.

## Requirements
- Tested on LXC Container:
   - 1 CPU Core
   - 1 GB RAM
   - approx. 10 GB disk space

## Installation
1. Download files: <pre>git clone https://github.com/xr4zz/T6Server.git</pre>
2. Make it executable:  <pre>chmod +x ~/T6Server/install.sh</pre>
3. Run the installation script `install.sh` and follow the instructions: <pre>sudo env "HOME=$HOME" ~/T6Server/install.sh</pre>

## Launch Server
1. Switch to the new `t6server` user: <pre>sudo su t6server</pre>
2. Go to the home directory: <pre>cd /opt/t6server</pre>
3. Launch the server: <pre>./t6server.sh</pre>
I advise you to use `screen` to open and manage the server.


## Source
- **Plutonium:** https://plutonium.pw
- **Thread by Minami:** https://forum.plutonium.pw/topic/12870/guide-debian-t6-server-on-linux-vps-dedicated-server
- **Plutonium-Updater by mxbe:** https://github.com/mxve/plutonium-updater.rs
- **Debian install script by Minami:** https://github.com/Sterbweise/T6Server
- **Bot-Script by ineedbots:** https://github.com/ineedbots/pt6_bot_warfare
