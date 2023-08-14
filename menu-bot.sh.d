#!/bin/bash
# (C) Copyright 2021-2022
# ==================================================================
# Name        : VPN Script Quick Installation Script
# Base        : *****
# Mod By      : Manternet
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

# // Install Jq
[[ ! -f /usr/bin/jq ]] && {
  echo
  echo -e "${ERROR} Downloading jq file!"
  wget -q --no-check-certificate "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -O /usr/bin/jq
  chmod +x usr/bin/jq
}

# // Make Folder Bot
dircreate() {
  [[ ! -d /root/multi ]] && mkdir -p /root/multi && touch /root/multi/voucher && touch /root/multi/claimed && touch /root/multi/reseller && touch /root/multi/public && touch /root/multi/hist && echo "off" >/root/multi/public
  [[ ! -d /etc/.maAsiss ]] && mkdir -p /etc/.maAsiss
}

# // Bot On Off
function bot-on-of() {
      dircreate
      [[ ! -f /root/multi/bot.conf ]] && {
         echo -e "Manternet Bot Panel Installer"
      [[ ! -f /root/ResBotAuth ]] && {
         echo -e "";
         echo -ne "Input Your Bot Token ( TOKEN ) = "
      read bot_tkn
         echo -e "";
         echo "Toket: $bot_tkn" >/root/ResBotAuth
         echo -ne "Input Your Admin id ( ID ) = "
      read adm_ids
         echo "Admin_ID: $adm_ids" >>/root/ResBotAuth
    }
         echo -e "";
         echo -ne "Input Your Bot Username, Dont use '@' ( example_bot ) = "
      read bot_user
      [[ -z $bot_user ]] && bot_user="Internet302_bot"
         echo -e "";
         echo -ne "Set Limit Free Config ( default:1 ) ="
      read limit_pnl
      [[ -z $limit_pnl ]] && limit_pnl="1"
 echo ""
 cat <<-EOF >/root/multi/bot.conf
  Botname: $bot_user
  Limit: $limit_pnl
 EOF

# // Info Bot
function bot-1() {
      clear
      [[ ! -e "/etc/.maAsiss/.Shellbtsss" ]] && {
        wget -qO- https://raw.githubusercontent.com/Manpokr/Bot/main/bot-api.sh >/etc/.maAsiss/.Shellbtsss
      }
      [[ "$(grep -wc "bot-tele" "/etc/rc.local")" = '0' ]] && {
        sed -i '$ i\screen -dmS bot_tele run-bot' /etc/rc.local >/dev/null 2>&1
      }
    }
    screen -dmS bot-tele run-bot >/dev/null 2>&1

    bot-1
    [[ $(ps x | grep "bot-tele" | grep -v grep | wc -l) != '0' ]] && 
      clear
      echo "";
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "         ${RED}•••${NC} BOT STATUS ${RED}•••${NC}"
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "${PS1} Bot Status Online !";
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo "";
      echo -e -n "Press ( ${BLUE}Enter${NC} ) To Back Menu Bot"; read  menu
      menu-bot
 ||
      clear
      echo "";
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "         ${RED}•••${NC} BOT STATUS ${RED}•••${NC}"
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "${PS1} Information not valid !";
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo "";
      echo -e -n "Press ( ${BLUE}Enter${NC} ) To Back Menu Bot"; read  menu
      menu-bot
      } || {

function bot-2() {
      clear
      screen -r -S "bot-tele" -X quit >/dev/null 2>&1
      [[ $(grep -wc "bot-tele" /etc/rc.local) != '0' ]] && {
        sed -i '/bot-tele/d' /etc/rc.local
      }
        rm -f /root/multi/bot.conf
      sleep 1
    }
    bot-2
      clear
      echo "";
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "         ${RED}•••${NC} BOT STATUS ${RED}•••${NC}"
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "${PS1} Bot Status Offline !";
      echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo "";
      echo -e -n "Press ( ${BLUE}Enter${NC} ) To Back Menu Bot"; read  menu
      menu-bot
  }
}

function instbot() {
      clear
      echo -e "     ${LIGHT}----------------------------------------------
                                 ⚠️ ATTENTION ⚠️
       ${RED}•${NC} Go to @BotFather Create Your Own Bot By Type = /newbot
       ${RED}•${NC} Go to @MissRose_bot And Get Your ID By Type = /id
        
        WELCOME TO MANTERNET VPN Script V2.0${LIGHT}
     ----------------------------------------------${LIGHT}"
     echo -e "Note:

    ( Y ) Start Bot
    ( C ) Cancle Start Bot
    ( D ) Delete Configuration File Before
    "
  echo -ne "Do You Want To Continue ? ( y/c/d ) = "
  read resposta
  if [[ "$resposta" = 'd' ]] || [[ "$resposta" = 'D' ]];  then
    rm -f /root/multi/bot.conf
    menu
  elif [[ "$resposta" = 'y' ]] || [[ "$resposta" = 'Y' ]]; then
    bot-on-off
  else
    echo -e "Returning..."
    sleep 1
    menu
  fi
}
[[ -f "/etc/.maAsiss/.Shellbtsss" ]] && bot-on-off || instbot
