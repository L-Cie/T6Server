#!/bin/bash
## Variable Region
_script="$(readlink -f ${BASH_SOURCE[0]})" 
# Delete last component from $_script
_mydir="$(dirname $_script)"
# Your Game Path (where there is binkw32.dll)
PAT=/opt/t6server/server/multiplayer
# Paste the server key from https://platform.plutonium.pw/serverkeys
KEY="<ENTER SERVER KEY>"
# Name of the config file the server should use. (default: dedicated.cfg)
CFG=dedicated.cfg
# Port used by the server (default: 4976) -> Don't forget to allow server port in ufw
PORT=4976
# Game Mode ( Multiplayer / Zombie ) -> ( t6mp / t6zm )
MODE=t6mp
# Plutonium game dir
INSTALLDIR=/opt/t6server

# Update your server game file
$INSTALLDIR/plutonium-updater -d "$INSTALLDIR"

echo -e 'T6Server will load \e[1;33m'$CFG'\e[0m and listen on port \e[1;33m'$PORT'\e[0m/udp!' 
echo "To shut down the server close this console first!"
printf -v NOW '%(%F %H:%M:%S)T' -1
echo ""$NOW" $NAME server started."

Xvfb :0 -screen 0 1024x768x16 &

while true
do
wine bin/plutonium-bootstrapper-win32.exe $MODE $PAT -dedicated +start_map_rotate +set key $KEY +set net_port $PORT +set sv_config $CFG 2>/dev/null
printf -v NOW '%(%F %H:%M:%S)T' -1
echo ""$NOW" WARNING: T6Server closed or dropped... server restarting."
sleep 1
done
