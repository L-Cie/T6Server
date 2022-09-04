#!/bin/bash
## Checking for root access
if [ "$EUID" -ne 0 ]
  then echo 'Please run as with elevated privileges'
  exit
fi

PAT=/opt/t6server

## Update the system
echo "Prepare the server key, while I am working!"
echo -e '\e[1;33m[1/8]\e[0m Enabling multilib and updating Arch Linux...'
{
  sed -i '/\[multilib\]/,/Include/''s/^#//' /etc/pacman.conf
  pacman -Syu wget --noconfirm
} > /dev/null 2>&1

## Setup the firewall to allow T6Server
echo -n 'Please specify port for T6Server [4976/udp]: '
read t6port
echo -e '\e[1;33m[2/8]\e[0m Installing ufw and allowing connectivity for T6Server...'
{
  pacman -S ufw --noconfirm && \
  ufw default allow outgoing && \
  ufw default deny incoming && \
  ufw allow ${t6port:-4976}/udp && \
  ufw -f enable && \
  systemctl enable ufw --now
} > /dev/null 2>&1

## Creating new service user for t6server
echo -e '\e[1;33m[3/8]\e[0m Creating new t6server service user and moving files to new home...'
{
  useradd t6server -m -d $PAT -s /bin/bash -r
  mv $HOME/T6Server/* $PAT/
} > /dev/null 2>&1

## Installing wine
echo -e '\e[1;33m[4/8]\e[0m Installing and configuring Wine...'
{
  pacman -Syu wine xorg-server-xvfb --noconfirm
  echo -e 'export WINEPREFIX=~/.wine\nexport WINEDEBUG=fixme-all\nexport WINEARCH=win64' >> $PAT/.bashrc
  echo -e 'export DISPLAY=:0.0' >> $PAT/.bashrc
  source $PAT/.bashrc
  cd $PAT
  runuser t6server -s /bin/bash -c "winecfg"
} > /dev/null 2>&1

echo -e '\e[1;33m[5/8]\e[0m Installing Plutonium Updater...'
{
  ln -s $PAT/server/zone $PAT/server/zombie/zone
  ln -s $PAT/server/zone $PAT/server/multiplayer/zone
  wget https://github.com/mxve/plutonium-updater.rs/releases/latest/download/plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
  tar xfv plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
  rm plutonium-updater-x86_64-unknown-linux-gnu.tar.gz
  chmod +x plutonium-updater

 # Make executable script
  chmod +x $PAT/t6server.sh
} > /dev/null 2>&1

echo -e '\e[1;33m[6/8]\e[0m Removing git files...'
{
  rm -r $HOME/T6Server
} > /dev/null 2>&1

echo -e '\e[1;33m[7/8]\e[0m Configuring your T6Server and settings permissions accordingly...'
echo -n 'Please specify your server key: '
read serverkey 
{
  sed -i '/KEY=.*/s//KEY=\"'$serverkey'\"/' $PAT/t6server.sh
  chown -R t6server:t6server $PAT
} > /dev/null 2>&1

echo -e '\e[1;33m[8/8]\e[0m Installation Complete!'