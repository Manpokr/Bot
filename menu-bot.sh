#!/bin/bash
# (C) Copyright 2021-2022
# ==================================================================
# Name        : VPN Script Quick Installation Script
# Base        : *****
# Mod By      : *****
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

# // Install Kq
[[ ! -f /usr/bin/jq ]] && {
    red "Mengunduh file jq!"
    wget -q --no-check-certificate "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -O /usr/bin/jq
    chmod +x usr/bin/jq
}

# // Make Folder Bot
dircreate() {
    [[ ! -d /root/multi ]] && mkdir -p /root/multi && touch /root/multi/voucher && touch /root/multi/claimed && touch /root/multi/reseller && touch /root/multi/public && touch /root/multi/hist && echo "off" >/root/multi/public
    [[ ! -d /etc/.maAsiss ]] && mkdir -p /etc/.maAsiss
}

function botonoff(){
clear
echo "";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "         ${RED}•••${NC} BOT PANEL ${RED}•••${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
dircreate
[[ ! -f /root/multi/bot.conf ]] && {
echo -e "
• Status ${GREEN}Installer${NC} And ${GREEN}Running!${NC}
"
[[ ! -f /root/ResBotAuth ]] && {
   echo -ne " Input Your Bot Token = "
read bot_tkn
   echo "Toket: $bot_tkn" >/root/ResBotAuth
   echo -ne " Input Your Admin Id = "
read adm_ids
   echo "Admin_ID: $adm_ids" >>/root/ResBotAuth
}
   echo -ne " Bot Username, Dont Use '@' ( example_bot ) = "
read bot_user
[[ -z $bot_user ]] && bot_user="example_Bot"
   echo ""
   echo -ne " Limit Free Config ( default:1 ) = "
read limit_pnl
[[ -z $limit_pnl ]] && limit_pnl="1"
echo -e "";
cat <<-EOF >/root/multi/bot.conf
Botname: $bot_user
Limit: $limit_pnl
EOF

fun_bot1() {
clear
[[ ! -e "/etc/.maAsiss/.Shellbtsss" ]] && {
   wget -qO- https://raw.githubusercontent.com/Manpokr/Bot/main/bot-api.sh >/etc/.maAsiss/.Shellbtsss
}
[[ "$(grep -wc "run_bot" "/etc/rc.local")" = '0' ]] && {
    sed -i '$ i\screen -dmS run_bot run' /etc/rc.local >/dev/null 2>&1
}
}
screen -dmS run_bot run >/dev/null 2>&1
fun_bot1
[[ $(ps x | grep "run_bot" | grep -v grep | wc -l) != '0' ]] && {
echo "";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "         ${RED}•••${NC} BOT PANEL ${RED}•••${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PS1} Bot successfully activated !";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "";
echo -e -n "Press ( ${BLUE}Enter${NC} ) To Back Menu Bot"; read  menu
menu-bot
} || {
echo "";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "         ${RED}•••${NC} BOT PANEL ${RED}•••${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PS1} Information not valid !";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "";
echo -e -n "Press ( ${BLUE}Enter${NC} ) To Back Menu Bot"; read  menu
menu-bot
}
} || {
clear
fun_bot2() {
screen -r -S "run_bot" -X quit >/dev/null 2>&1
[[ $(grep -wc "run_bot" /etc/rc.local) != '0' ]] && {
sed -i '/run_bot/d' /etc/rc.local
}
rm -f /root/multi/bot.conf
sleep 1
}
fun_bot2
echo "";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "         ${RED}•••${NC} BOT PANEL ${RED}•••${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PS1} Bot Stoped Successfully !";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "";
echo -e -n "Press ( ${BLUE}Enter${NC} ) To Back Menu Bot"; read  menu
menu-bot
}
}
clear
echo "";
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "         ${RED}•••${NC} BOT PANEL ${RED}•••${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "";
echo -e "${LIGHT}  (${GREEN}01${LIGHT}) ${RED}•${LIGHT} START && STOP BOT";
echo -e "${NC}"
echo -e "${LIGHT}  (${RED}00${LIGHT}) ${RED}• BACK TO MENU${LIGHT}";
echo -e "${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "";
echo -e -n " ${LIGHT}Select menu (${GREEN} 0 - 1 ${LIGHT})${NC} = "; read x
if [[ $x = 1 || $x = 01 ]]; then
 clear
 botonoff
 elif [[ $x = 0 || $x = 00 ]]; then
 clear
 menu
 else
  echo -e " ${ERROR} Please Input The Correct Number"
  sleep 1
  menu-bot
 fi
