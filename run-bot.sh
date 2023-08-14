#!/bin/bash
#!/bin/bash
# (C) Copyright 2021-2022
# ==================================================================
# Name        : VPN Script Quick Installation Script
# Base        : *****
# Mod By      : test
# ==================================================================

# // Export Color & Information
export RED='\033[0;31m';
export GREEN='\033[0;32m';
export BLUE='\033[0;34m';
export LIGHT='\033[0;37m';
export CYAN='\033[0;36m';
export NC='\033[0m';
export BG1='\e[36;5;44m'
export BG='\e[30;5;47m'

# // Export Banner Status Information
export ERROR="[${RED} ERROR ${NC}]";
export INFO="[${CYAN} INFO ${NC}]";
export PS1="${BG1} INFO ${NC}";
export OKEY="[${GREEN} OKEY ${NC}]";

# // Exporting maklumat rangkaian
source /root/ip-detail.txt;
export IP_NYA="$IP";
export USER_NYA="Manpokr/mon"

# // Getting
export IZIN=$(curl -sS https://raw.githubusercontent.com/${USER_NYA}/main/ip | awk '{print $6}' | grep $IP_NYA )
if [[ "true" = $IZIN ]]; then > /dev/null 2>&1;
     curl -sS https://raw.githubusercontent.com/Manpokr/Bot/main/bot-vpn.sh | bash -
else
     echo -e ""
     echo -e " ${ERROR} You Cant Use This Bot Panel !";
     rm -f /root/ins-nginx.sh;
  exit 0;
fi
