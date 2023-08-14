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
function bot1() {
      clear
      [[ ! -e "/etc/.maAsiss/.Shellbtsss" ]] && {
        wget -qO- https://raw.githubusercontent.com/CodeKambing1/multi/main/BOT_PANEL/BotAPI.sh >/etc/.maAsiss/.Shellbtsss
      }
      [[ "$(grep -wc "sam_bot" "/etc/rc.local")" = '0' ]] && {
        sed -i '$ i\screen -dmS sam_bot bbt' /etc/rc.local >/dev/null 2>&1
      }
    }
    screen -dmS sam_bot bbt >/dev/null 2>&1
    fun_bot1
    [[ $(ps x | grep "sam_bot" | grep -v grep | wc -l) != '0' ]] && echo -e "\nBot successfully activated !" || echo -e "\nError1! Information not valid !"
    sleep 2
    menu
  } || {
    clear
    echo -e "Info...\n"
    fun_bot2() {
      screen -r -S "sam_bot" -X quit >/dev/null 2>&1
      [[ $(grep -wc "sam_bot" /etc/rc.local) != '0' ]] && {
        sed -i '/sam_bot/d' /etc/rc.local
      }
      rm -f /root/multi/bot.conf
      sleep 1
    }
    fun_bot2
    echo -e "\nBot Scvps Stopped!"
    sleep 2
    menu
  }
}

fun_instbot() {
  echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -e "         ⚠️ ATTENTION ⚠️"
  echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -e " • Go to @BotFather Create Your own Bot by Type : /newbot"
  echo -e " • Go to @MissRose_bot And Get Your ID by Type : /id"
  echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -e "Note:

    y = to start bot panel
    n = to cancel start bot panel
    d = delete configuration file before
    "
  echo -ne "Do you want to continue ? [y/n/d]: "
  read resposta
  if [[ "$resposta" = 'd' ]]; then
    rm -f /root/multi/bot.conf
    menu
  elif [[ "$resposta" = 'y' ]] || [[ "$resposta" = 'Y' ]]; then
    fun_botOnOff
  else
    echo -e "Returning..."
    sleep 1
    menu
  fi
}
[[ -f "/etc/.maAsiss/.Shellbtsss" ]] && fun_botOnOff || fun_instbot
