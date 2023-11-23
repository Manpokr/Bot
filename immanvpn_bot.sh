#!/bin/bash
[[ ! -d /var/lib/scrz-prem ]] && exit 0
[[ ! -f /etc/.maAsiss/res_token ]] && touch /etc/.maAsiss/res_token
[[ ! -f /etc/.maAsiss/user_flood ]] && touch /etc/.maAsiss/user_flood
[[ ! -f /etc/.maAsiss/log_res ]] && touch /etc/.maAsiss/log_res
[[ ! -f /etc/.maAsiss/User_Generate_Token ]] && touch /etc/.maAsiss/User_Generate_Token
[[ ! -d /etc/.maAsiss/.cache ]] && mkdir /etc/.maAsiss/.cache

if [[ ! -f /etc/.maAsiss/.cache/StatusDisable ]]; then
touch /etc/.maAsiss/.cache/StatusDisable
cat <<-EOF >/etc/.maAsiss/.cache/StatusDisable
SSH : [ON]
VMESS : [ON]
VLESS : [ON]
TROJAN : [ON]
TROJAN-GO : [ON]
WIREGUARD : [ON]
SHADOWSOCK: [ON]
TCPXTLS : [ON]
EOF
fi

#source /root/ResBotAuth
source /etc/.maAsiss/.Shellbtsss
User_Active=/etc/.maAsiss/list_user
User_Token=/etc/.maAsiss/User_Generate_Token
Res_Token=/etc/.maAsiss/res_token
User_Flood=/etc/.maAsiss/user_flood
Toket=$(sed -n '1 p' /root/ResBotAuth | cut -d' ' -f2)
Admin_ID=$(sed -n '2 p' /root/ResBotAuth | cut -d' ' -f2)
admin_bot_panel=$(sed -n '1 p' /root/multi/bot.conf | cut -d' ' -f2)
_limitTotal=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
nameStore=$(grep -w "store_name" /root/multi/bot.conf | awk '{print $NF}')

ShellBot.init --token $Toket --monitor --return map --flush
ShellBot.username
echo "Admin ID : $Admin_ID"
rm -f /tmp/authToken
rm -f /tmp/authAdmin

AUTOBLOCK() {
if [[ "$(grep -wc ${message_chat_id[$id]} $User_Flood)" != '1' ]]; then
   Max=9
   if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
   return 0
   fi || if [[ "$(grep -w "${message_from_id}" $User_Active | grep -wc 'reseller')" != '1' ]]; then
   echo $message_date + $Max | bc >> /etc/.maAsiss/.cache/$message_chat_id
   if [[ "$(grep -wc "$message_date" "/etc/.maAsiss/.cache/$message_chat_id")" = '1' ]];then
         echo "$message_chat_id" >> /etc/.maAsiss/user_flood
         rm -f /etc/.maAsiss/.cache/$message_chat_id
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "Youre flooding im sorry to block you\nThis ur ID: <code>${message_chat_id[$id]}</code>\n\nContact $admin_bot_panel to unblock" \
             --parse_mode html
         ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
         return 0
      fi
    fi
  fi
}

Disable_Order() {
   if [[ "${message_from_id[$id]}" == "$Admin_ID" ]]; then
     ShellBot.deleteMessage	--chat_id ${message_chat_id[$id]} \
              --message_id ${message_message_id[$id]}

     if [[ "$(grep -wc "ssh" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderSSH
         sed -i "/SSH/c\SSH : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled SSH" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "vmess" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderVMESS
         sed -i "/VMESS/c\VMESS : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled VMess" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "vless" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderVLESS
         sed -i "/VLESS/c\VLESS : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled VLess" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "trojan" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderTROJAN
         sed -i "/TROJAN :/c\TROJAN : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled Trojan" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "trgo" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderTROJANGO
         sed -i "/TROJAN-GO/c\TROJAN-GO : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled Trojan-GO" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "wg" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderWG
         sed -i "/WIREGUARD/c\WIREGUARD : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled Wireguard" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "ss" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderSS
         sed -i "/^SHADOWSOCK:/c\SHADOWSOCK: [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled Shadowsocks" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ "$(grep -wc "ssr" "/tmp/order")" = '1' ]]; then
         touch /etc/.maAsiss/.cache/DisableOrderSSR
         sed -i "/SHADOWSOCKS-R/c\SHADOWSOCKS-R : [OFF]" /etc/.maAsiss/.cache/StatusDisable
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "✅ Success Disabled Shadowsocks-R" \
             --parse_mode html
         if [[ -f /tmp/msgid ]]; then
             dx=$(cat /tmp/msgid | tail -1)
             echo $dx + 1 | bc >> /tmp/msgid
         else
         echo ${message_message_id[$id]} + 1 | bc >> /tmp/msgid
         fi
     fi
     if [[ -f /tmp/msgid ]]; then
     while read msg_id; do
         ShellBot.deleteMessage	--chat_id ${message_chat_id[$id]} \
              --message_id $msg_id
     done <<<"$(cat /tmp/msgid)"
     rm -f /tmp/msgid
     fi
     if [[ "$(grep -wc "off" "/tmp/order")" = '1' ]]; then
         rm -f /etc/.maAsiss/.cache/DisableOrderWG
         rm -f /etc/.maAsiss/.cache/DisableOrderSSH
         rm -f /etc/.maAsiss/.cache/DisableOrderVMESS
         rm -f /etc/.maAsiss/.cache/DisableOrderVLESS
         rm -f /etc/.maAsiss/.cache/DisableOrderTROJAN
         rm -f /etc/.maAsiss/.cache/DisableOrderTROJANGO
         rm -f /etc/.maAsiss/.cache/DisableOrderSS
         rm -f /etc/.maAsiss/.cache/DisableOrderTCPXTLS
         sed -i "s/\[OFF\]/\[ON\]/g" /etc/.maAsiss/.cache/StatusDisable
         bdx=$(echo ${message_message_id[$id]} + 1 | bc)
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
             --text "☑️ Successfully Enabled Order ☑️" \
             --parse_mode html
         sleep 1
         ShellBot.deleteMessage	--chat_id ${message_chat_id[$id]} \
              --message_id $bdx
     fi
  fi
}

about_server() {
[[ "$(grep -wc ${message_chat_id[$id]} $User_Flood)" = '1' ]] && return 0 || AUTOBLOCK
ISP=`curl -sS ip-api.com | grep -w "isp" | awk '{print $3,$4,$5,$6,$7,$8,$9}' | cut -d'"' -f2 | cut -d',' -f1 | tee -a /etc/afak.conf`
CITY=`curl -sS ip-api.com | grep -w "city" | awk '{print $3}' | cut -d'"' -f2 | tee -a /etc/afak.conf`
WKT=`curl -sS ip-api.com | grep -w "timezone" | awk '{print $3}' | cut -d'"' -f2 | tee -a /etc/afak.conf`
IPVPS=`curl -sS ip-api.com | grep -w "query" | awk '{print $3}' | cut -d'"' -f2 | tee -a /etc/afak.conf`

    local msg
    msg="─────────────────────\n"
    msg="<b>Server Information</b>\n\n"
    msg+="<code>ISP  : $ISP\n"
    msg+="CITY : $CITY\n"
    msg+="TIME : $WKT\n"
    msg+="IP.  : $IPVPS</code>\n"
    msg+="─────────────────────\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
    return 0
}

msg_welcome() {
	[[ "$(grep -wc ${message_chat_id[$id]} $User_Flood)" = '1' ]] && return 0 || AUTOBLOCK
	if [[ "$(grep -wc ${message_chat_id[$id]} $User_Token)" = '0' ]]; then
	   r1=$(tr -dc A-Za-z </dev/urandom | head -c 4)
	   r2=$(tr -dc A-Za-z </dev/urandom | head -c 2)
	   r3=$(tr -dc A-Za-z </dev/urandom | head -c 3)
	   r4=$(tr -dc A-Za-z </dev/urandom | head -c 1)
	   r5=$(tr -dc A-Za-z </dev/urandom | head -c 5)
	   r6=$(tr -dc A-Za-z </dev/urandom | head -c 2)
	   r7=$(tr -dc A-Za-z </dev/urandom | head -c 4)
	   r8=$(tr -dc A-Za-z </dev/urandom | head -c 2)
	   r9=$(tr -dc A-Za-z </dev/urandom | head -c 4)
	fcm=$(echo ${message_from_id[$id]} | sed 's/\([0-9]\{2,\}\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)/\1'$r1'\2'$r2'\3'$r3'\4'$r4'\5'$r5'\6'$r6'\7'$r7'\8'$r8'/ig' | rev)
	   echo "ID_User : ${message_chat_id[$id]} Token : $fcm" >> /etc/.maAsiss/User_Generate_Token
	else
   	   fcm=$(grep -w ${message_chat_id[$id]} $User_Token | awk '{print $NF}')
	fi

	local msg
	msg="─────────────────────\n"
	msg+="<code>Welcome</code> <b>${message_from_first_name[$id]}</b>\n\n"
	msg+="<code>To access the menu</code> ( /menu )\n"
	msg+="<code>To see server information</code> ( /info )\n"
	msg+="<code>for free account</code>( /free )\n\n"
	msg+="─────────────────────\n"
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	msg+="<b>Access Token :</b>\n"
	msg+="<code>$fcm</code>\n"
	msg+="─────────────────────\n"
	fi
ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
     --text "$(echo -e $msg)" \
     --parse_mode html
     return 0
}

menu_func() {
	[[ "$(grep -wc ${message_chat_id[$id]} $User_Flood)" = '1' ]] && return 0 || AUTOBLOCK
	   hargassh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
	   hargavmess=$(grep -w "Price VMess" /etc/.maAsiss/price | awk '{print $NF}')
	   hargavless=$(grep -w "Price VLess" /etc/.maAsiss/price | awk '{print $NF}')
	   hargatrojan=$(grep -w "Price Trojan :" /etc/.maAsiss/price | awk '{print $NF}')
	   hargatrgo=$(grep -w "Price Trojan-GO" /etc/.maAsiss/price | awk '{print $NF}')
	   hargawg=$(grep -w "Price Wireguard" /etc/.maAsiss/price | awk '{print $NF}')
	   hargass=$(grep -w "Price Shadowsocks :" /etc/.maAsiss/price | awk '{print $NF}')
	   hargassr=$(grep -w "Price Tcpxtls" /etc/.maAsiss/price | awk '{print $NF}')
	   hargaxray=$(grep -w "Price Xray" /etc/.maAsiss/price | awk '{print $NF}')

    if [[ "${message_from_id[$id]}" == "$Admin_ID" ]]; then
        local env_msg
	msg+="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
	msg+="─────────────────────\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
            return 0
    fi
    if [[ "$(grep -w "${message_from_id}" $User_Active | grep -wc 'reseller')" != '0' ]]; then
        _SaldoTotal=$(grep -w 'Saldo_Reseller' /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
        local env_msg
	msg+="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
	msg+="─────────────────────\n"
        env_msg+="💲Price List :💲\n"
        env_msg+="<code>SSH            : $hargassh\n"
        env_msg+="VMess          : $hargavmess\n"
        env_msg+="VLess          : $hargavless\n"
        env_msg+="Trojan         : $hargatrojan\n"
        env_msg+="Trojan-Go      : $hargatrgo\n"
        env_msg+="Wireguard      : $hargawg\n"
        env_msg+="Shadowsocks    : $hargass\n"
        env_msg+="Tcp Xtls       : $hargassr\n"
        env_msg+="XRAY           : $hargaxray</code>\n"
	msg+="─────────────────────\n"
        env_msg+="🤵 Admin Panel : $admin_bot_panel 🤵\n"
        env_msg+="💡 Limit Trial : $_limTotal users 💡\n"
	msg+="─────────────────────\n"
        env_msg+="💰 Current Balance : $_SaldoTotal 💰\n"
	msg+="─────────────────────\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$menu_re_main_updater1" \
            --parse_mode html
            return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "─────────────────────\n⛔ ACCESS DENIED ⛔\n─────────────────────\n\nfor register to be a reseller contact : $admin_bot_panel\n\n─────────────────────\nBot Panel By : @Manternet\n─────────────────────\n"
        return 0
    fi
}

menu_func_cb() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] && {
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu')"
        return 0
    }
    if [[ "$(grep -w "${message_from_id}" $User_Active | grep -wc 'reseller')" != '0' ]]; then
        _SaldoTotal=$(grep -w 'Saldo_Reseller' /etc/.maAsiss/db_reseller/${callback_query_from_id}/${callback_query_from_id} | awk '{print $NF}')       

[[ ! -f "/etc/.maAsiss/update-info" ]] && {
   local env_msg
   env_msg="─────────────────────\n"
   env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
   env_msg+="─────────────────────\n\n"
} || {
   inf=$(cat /etc/.maAsiss/update-info)
   local env_msg
   env_msg="─────────────────────\n"
   env_msg+="🏷 Information for reseller :\n\n"
   env_msg+="$inf\n\n"
   env_msg+="─────────────────────\n"
}
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_re_main')"
        return 0
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

info_port() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        portssh=$(grep -w "OpenSSH" /root/log-install.txt | awk '{print $NF}')
        portsshws=$(grep -w "SSH Websocket" /root/log-install.txt | awk '{print $5,$6}')
        portovpn=$(grep -w " OpenVPN" /root/log-install.txt | awk '{print $4,$5,$6,$7,$8,$9,$10}')
        portssl=$(grep -w "Stunnel4" /root/log-install.txt | awk '{print $4,$5,$6,$7}')
        portdb=$(grep -w "Dropbear" /root/log-install.txt | awk '{print $4,$5,$6,$7}')
        portsqd=$(grep -w "Squid Proxy" /root/log-install.txt | awk '{print $5,$6}')
        portudpgw=$(grep -w "Badvpn" /root/log-install.txt | awk '{print $4}')
        portnginx=$(grep -w "Nginx" /root/log-install.txt | awk '{print $NF}')
        portwstls=$(grep -w "Vmess TLS" /root/log-install.txt | awk '{print $NF}')
        portws=$(grep -w "Vmess None TLS" /root/log-install.txt | awk '{print $NF}')
        portvlesstls=$(grep -w "Vless TLS" /root/log-install.txt | awk '{print $NF}')
        portvless=$(grep -w "Vless None TLS" /root/log-install.txt | awk '{print $NF}')
        porttr=$(grep -w "Trojan " /root/log-install.txt | awk '{print $NF}')
        porttrgo=$(grep -w "Trojan Go" /root/log-install.txt | awk '{print $NF}')
        portwg=$(grep -w "Wireguard" /root/log-install.txt | awk '{print $NF}')
        portsstp=$(grep -w "SSTP VPN" /root/log-install.txt | awk '{print $NF}')
        portl2tp=$(grep -w "L2TP/IPSEC VPN" /root/log-install.txt | awk '{print $NF}')
        portpptp=$(grep -w "PPTP VPN" /root/log-install.txt | awk '{print $NF}')
        portsstls=$(grep -w "SS-OBFS TLS" /root/log-install.txt | awk '{print $NF}')
        portss=$(grep -w "SS-OBFS HTTP" /root/log-install.txt | awk '{print $NF}')
        portssR=$(grep -w "Shadowsocks-R" /root/log-install.txt | awk '{print $NF}')
        OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
        OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
        OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`
        wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`

        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="OpenSSH : $portssh\n"
        env_msg+="SSH-WS : $portsshws\n"
        env_msg+="SSH-WS-SSL : $wsssl\n"
        env_msg+="OpenVPN : $portovpn\n"
        env_msg+="Stunnel5 : $portssl\n"
        env_msg+="Dropbear : $portdb\n"
        env_msg+="Badvpn : $portudpgw\n"
        env_msg+="Nginx : $portnginx\n"
        env_msg+="Vmess TLS : $portwstls\n"
        env_msg+="Vmess NONE : $portws\n"
        env_msg+="Vless TLS : $portvlesstls\n"
        env_msg+="Vless NONE : $portvless\n"
        env_msg+="Trojan TLS : $porttr\n"
	env_msg+="Trojan NONE : $porttr\n"
	env_msg+="Shadowsock TLS : $portssR\n"
	env_msg+="Shadowsock NONE : $portssR\n"
	env_msg+="TCP XTLS : $portssR\n"
	env_msg+="TCP HTTP NONE : $portssR\n"
        env_msg+="Trojan-GO TLS : $porttrgo\n"
        env_msg+="Wireguard : $portwg\n"
        env_msg+="─────────────────────\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'back_menu')"
        return 0
    } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

admin_price_see() {
hargassh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
hargavmess=$(grep -w "Price VMess" /etc/.maAsiss/price | awk '{print $NF}')
hargavless=$(grep -w "Price VLess" /etc/.maAsiss/price | awk '{print $NF}')
hargatrojan=$(grep -w "Price Trojan :" /etc/.maAsiss/price | awk '{print $NF}')
hargatrgo=$(grep -w "Price Trojan-GO" /etc/.maAsiss/price | awk '{print $NF}')
hargawg=$(grep -w "Price Wireguard" /etc/.maAsiss/price | awk '{print $NF}')
hargass=$(grep -w "Price Shadowsocks :" /etc/.maAsiss/price | awk '{print $NF}')
hargassr=$(grep -w "Price Shadowsocks-R" /etc/.maAsiss/price | awk '{print $NF}')
hargasstp=$(grep -w "Price SSTP" /etc/.maAsiss/price | awk '{print $NF}')
hargal2tp=$(grep -w "Price L2TP" /etc/.maAsiss/price | awk '{print $NF}')
hargapptp=$(grep -w "Price PPTP" /etc/.maAsiss/price | awk '{print $NF}')
hargaxray=$(grep -w "Price Xray" /etc/.maAsiss/price | awk '{print $NF}')

[[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        local env_msg
	env_msg="─────────────────────\n"
        env_msg+="💲Price List :💲\n"
        env_msg+="<code>SSH            : $hargassh\n"
        env_msg+="VMess          : $hargavmess\n"
        env_msg+="VLess          : $hargavless\n"
        env_msg+="Trojan         : $hargatrojan\n"
        env_msg+="Trojan-Go      : $hargatrgo\n"
        env_msg+="Wireguard      : $hargawg\n"
        env_msg+="Shadowsocks    : $hargass\n"
        env_msg+="Shadowsocks-R  : $hargassr\n"
        env_msg+="XRAY           : $hargal2tp</code>\n"
	env_msg+="─────────────────────\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'back_menu_admin')"
        return 0
    } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

admin_service_see() {
[[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_adm_ser')"
        return 0
    } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

menu_reserv() {
        stsSSH=$(grep -w "SSH" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsVMESS=$(grep -w "VMESS" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsVLESS=$(grep -w "VLESS" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsTROJAN=$(grep -w "TROJAN :" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsTROJANGO=$(grep -w "TROJAN-GO" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsWG=$(grep -w "WIREGUARD" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsSS=$(grep -w "SHADOWSOCK:" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsSSR=$(grep -w "SHADOWSOCKS-R" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="🟢 Status Order : \n\n"
        env_msg+="<code>SSH            : $stsSSH\n"
        env_msg+="VMess          : $stsVMESS\n"
        env_msg+="VLess          : $stsVLESS\n"
        env_msg+="Trojan         : $stsTROJAN\n"
        env_msg+="Trojan-Go      : $stsTROJANGO\n"
        env_msg+="Wireguard      : $stsWG\n"
        env_msg+="Shadowsocks    : $stsSS\n"
        env_msg+="Shadowsocks-R  : $stsSSR</code>\n"
        env_msg+="─────────────────────\n"

[[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_re_ser')"
        return 0
    } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

status_order() {
        stsSSH=$(grep -w "SSH" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsVMESS=$(grep -w "VMESS" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsVLESS=$(grep -w "VLESS" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsTROJAN=$(grep -w "TROJAN :" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsTROJANGO=$(grep -w "TROJAN-GO" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsWG=$(grep -w "WIREGUARD" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsSS=$(grep -w "SHADOWSOCK:" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        stsSSR=$(grep -w "SHADOWSOCKS-R" /etc/.maAsiss/.cache/StatusDisable | awk '{print $NF}')
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="🟢 Status Order : \n\n"
        env_msg+="<code>SSH            : $stsSSH\n"
        env_msg+="VMess          : $stsVMESS\n"
        env_msg+="VLess          : $stsVLESS\n"
        env_msg+="Trojan         : $stsTROJAN\n"
        env_msg+="Trojan-Go      : $stsTROJANGO\n"
        env_msg+="Wireguard      : $stsWG\n"
        env_msg+="Shadowsocks    : $stsSS\n"
        env_msg+="Shadowsocks-R  : $stsSSR</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'status_disable')" \
        return 0
    } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

how_to_order() {
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="💡 How to use : [code] \n\n"
        env_msg+="<code>SSH            : ssh\n"
        env_msg+="VMess          : vmess\n"
        env_msg+="VLess          : vless\n"
        env_msg+="Trojan         : trojan\n"
        env_msg+="Trojan-Go      : trgo\n"
        env_msg+="Wireguard      : wg\n"
        env_msg+="Shadowsocks    : ss\n"
        env_msg+="Shadowsocks-R  : ssr</code>\n"
        env_msg+="─────────────────────\n"
        env_msg+="usage: /disable[space][code]\n"
        env_msg+="example: <code>/disable ssh</code>\n\n"
        env_msg+="note: you can use multiple args\n"
        env_msg+="example: <code>/disable ssh ssr trojan trgo</code>\n\n"
        env_msg+="usage: /disable[space][off] to turn off\n"
        env_msg+="example: <code>/disable off</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'status_how_to')" \
        return 0
    } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

see_log() {
    beha=$(cat /etc/.maAsiss/log_res)
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<code>$beha</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
    [[ "$(cat /etc/.maAsiss/log_res | wc -l)" = '0' ]] && {
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ No Information Available ⛔"
         return 0
    } || {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'back_menu_admin')" \
        return 0
    }
  } || {
  ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
         return 0
  }
}

res_opener() {
[[ ! -f "/etc/.maAsiss/update-info" ]] && {
   local env_msg
   env_msg="─────────────────────\n"
   env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
   env_msg+="━━━━━━━━━━━━━━━━━━━━━\n\n"
} || {
   inf=$(cat /etc/.maAsiss/update-info)
   local env_msg
   env_msg="─────────────────────\n"
   env_msg+="🏷 Information for reseller :\n\n"
   env_msg+="$inf\n\n"
   env_msg+="─────────────────────\n"
}

    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_re_main')"
        return 0
    } || {
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

res_closer() {
hargassh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
hargavmess=$(grep -w "Price VMess" /etc/.maAsiss/price | awk '{print $NF}')
hargavless=$(grep -w "Price VLess" /etc/.maAsiss/price | awk '{print $NF}')
hargatrojan=$(grep -w "Price Trojan :" /etc/.maAsiss/price | awk '{print $NF}')
hargatrgo=$(grep -w "Price Trojan-GO" /etc/.maAsiss/price | awk '{print $NF}')
hargawg=$(grep -w "Price Wireguard" /etc/.maAsiss/price | awk '{print $NF}')
hargass=$(grep -w "Price Shadowsocks :" /etc/.maAsiss/price | awk '{print $NF}')
hargassr=$(grep -w "Price Shadowsocks-R" /etc/.maAsiss/price | awk '{print $NF}')
hargasstp=$(grep -w "Price SSTP" /etc/.maAsiss/price | awk '{print $NF}')
hargal2tp=$(grep -w "Price L2TP" /etc/.maAsiss/price | awk '{print $NF}')
hargapptp=$(grep -w "Price PPTP" /etc/.maAsiss/price | awk '{print $NF}')
hargaxray=$(grep -w "Price Xray" /etc/.maAsiss/price | awk '{print $NF}')

    if [[ "$(grep -w "${message_from_id}" $User_Active | grep -wc 'reseller')" != '0' ]]; then
        _SaldoTotal=$(grep -w 'Saldo_Reseller' /etc/.maAsiss/db_reseller/${callback_query_from_id}/${callback_query_from_id} | awk '{print $NF}')       
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="💲Price List :💲\n"
        env_msg+="<code>SSH            : $hargassh\n"
        env_msg+="VMess          : $hargavmess\n"
        env_msg+="VLess          : $hargavless\n"
        env_msg+="Trojan         : $hargatrojan\n"
        env_msg+="XRAY           : $hargaxray</code>\n"
        env_msg+="─────────────────────\n"
        env_msg+="🤵 Admin Panel : $admin_bot_panel 🤵\n"
        env_msg+="💡 Limit Trial : $_limTotal users💡\n"
        env_msg+="─────────────────────\n"
        env_msg+="💰 Current Balance : $_SaldoTotal 💰\n"
	env_msg="─────────────────────\n\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_re_main_updater')"
        return 0
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
         --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

user_already_exist() {
    userna=$1
   if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
        datata=$(find /etc/.maAsiss/ -name $userna | sort | uniq | wc -l)
        for accc in "${datata[@]}"
        do
             _resl=$accc
        done  
        _results=$(echo $_resl)
    elif [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
        datata=$(find /etc/.maAsiss/ -name $userna | sort | uniq | wc -l)
        for accc in "${datata[@]}"
        do
             _resl=$accc
        done  
        _results=$(echo $_resl)
      fi
      [[ "$_results" != "0" ]] && {
         ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ User $userna already exist , try other username " \
                --parse_mode html
         ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "Func Error Do Nothing" \
                --reply_markup "$(ShellBot.ForceReply)"
         return 0
      }   
}

adduser_ssh() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE USER 👤\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

cret_user() {
[[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
    [[ -f /etc/.maAsiss/.cache/DisableOrderSSH ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Disable Order SSH" \
                --parse_mode html
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
               --text "Func Error Do Nothing" \
               --reply_markup "$(ShellBot.ForceReply)"
        return 0
    }
}
    file_user=$1
    userna=$(sed -n '1 p' $file_user | cut -d' ' -f2)
    passw=$(sed -n '2 p' $file_user | cut -d' ' -f2)
    data=$(sed -n '3 p' $file_user | cut -d' ' -f2)
    exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

    if /usr/sbin/useradd -M -N -s /bin/false $userna -e $exp; then
        (echo "${passw}";echo "${passw}") | passwd "${userna}"
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ ERROR CREATING USER" \
                --parse_mode html
        return 0
    fi
    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
        pricessh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
        saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
        if [ "$saldores" -lt "$pricessh" ]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Your Balance Not Enough" \
                --parse_mode html
            return 0
        else
            echo "$userna:$passw:$info_data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna
            echo "$userna:$passw:$info_data" >/etc/.maAsiss/info-users/$userna
            _CurrSal=$(echo $saldores - $pricessh | bc)
            sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
            sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active
            echo "$userna:$passw 30Days SSH | ${message_from_username}" >> /etc/.maAsiss/log_res
        fi
    }
}

2month_user() {
[[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
    [[ -f /etc/.maAsiss/.cache/DisableOrderSSH ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Disable Order SSH" \
                --parse_mode html
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
               --text "Func Error Do Nothing" \
               --reply_markup "$(ShellBot.ForceReply)"
        return 0
    }
}
    file_user=$1
    userna=$(sed -n '1 p' $file_user | cut -d' ' -f2)
    passw=$(sed -n '2 p' $file_user | cut -d' ' -f2)
    data=$(sed -n '3 p' $file_user | cut -d' ' -f2)
    exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

     if /usr/sbin/useradd -M -N -s /bin/false $userna -e $exp; then
        (echo "${passw}";echo "${passw}") | passwd "${userna}"
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "⛔ ERROR CREATING USER")" \
                --parse_mode html
        return 0
    fi

    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
        pricessh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
        saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
        urday=$(echo $pricessh * 2 | bc)
        if [ "$saldores" -lt "$urday" ]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Your Balance Not Enough " \
                --parse_mode html
            return 0
        else
            echo "$userna:$passw:$info_data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna
            echo "$userna:$passw:$info_data" >/etc/.maAsiss/info-users/$userna
            _CurrSal=$(echo $saldores - $urday | bc)
            sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
            sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active
            echo "$userna:$passw 60Days SSH | ${message_from_username}" >> /etc/.maAsiss/log_res
        fi
    }
}

del_ssh() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVE USER 🗑\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_del_ssh() {
    userna=$1
    [[ "${message_from_id[$id]}" = "$Admin_ID" ]] && {
        userdel --force "$userna" 2>/dev/null
        kill-by-user $userna
rm /root/login-db.txt > /dev/null 2>&1
rm /root/login-db-pid.txt > /dev/null 2>&1
    } || {
        [[ ! -e /etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "⛔ THE USER DOES NOT EXIST ⛔")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        userdel --force "$userna" 2>/dev/null
        rm /etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna
        rm /etc/.maAsiss/info-users/$userna
        kill-by-user $userna
        
rm /root/login-db.txt > /dev/null 2>&1
rm /root/login-db-pid.txt > /dev/null 2>&1
    }
}

info_users_ssh() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        arq_info=/tmp/$(echo $RANDOM)
        fun_infu() {
            local info
            for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
                info='━━━━━━━━━━━━━━━━━━━━━\n'
                datauser=$(chage -l $user | grep -i co | awk -F : '{print $2}')
                [[ $datauser = ' never' ]] && {
                    data="Never"
                } || {
                    databr="$(date -d "$datauser" +"%Y%m%d")"
                    hoje="$(date -d today +"%Y%m%d")"
                    [[ $hoje -ge $databr ]] && {
                        data="Expired"
                    } || {
                        dat="$(date -d"$datauser" '+%Y-%m-%d')"
                        data=$(echo -e "$((($(date -ud $dat +%s) - $(date -ud $(date +%Y-%m-%d) +%s)) / 86400)) Days")
                    }
                }
                info+="$user • $data"
                echo -e "$info"
            done
        }
        fun_infu >$arq_info
        while :; do
            ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id $Admin_ID \
                --text "$(while read line; do echo $line; done < <(sed '1,30!d' $arq_info))" \
                --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info | wc -l) = '0' ]] && rm $arq_info && break
        done
    elif [[ "$(grep -wc "${callback_query_from_id}" $User_Active)" != '0' ]]; then
        [[ $(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_by_res | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "YOU HAVE NOT CREATED A USER YET!"
            return 0
        }
        arq_info=/tmp/$(echo $RANDOM)
        fun_infu() {
            local info
            for user in $(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_by_res); do
                info='━━━━━━━━━━━━━━━━━━━━━\n'
                datauser=$(chage -l $user | grep -i co | awk -F : '{print $2}')
                [[ $datauser = ' never' ]] && {
                    data="Never"
                } || {
                    databr="$(date -d "$datauser" +"%Y%m%d")"
                    hoje="$(date -d today +"%Y%m%d")"
                    [[ $hoje -ge $databr ]] && {
                        data="Expired"
                    } || {
                        dat="$(date -d"$datauser" '+%Y-%m-%d')"
                        data=$(echo -e "$((($(date -ud $dat +%s) - $(date -ud $(date +%Y-%m-%d) +%s)) / 86400)) Days")
                    }
                }
                info+="$user • $data"
                echo -e "$info"
            done
        }
        fun_infu >$arq_info
        while :; do
            ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(while read line; do echo $line; done < <(sed '1,30!d' $arq_info))" \
                --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info | wc -l) = '0' ]] && rm $arq_info && break
        done
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

renew_ssh() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "⏳ Renew SSH ⏳\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_renew_ssh() {
    userna=$1
    inputdate=$2
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        [[ "$(echo -e "$inputdate" | sed -e 's/[^/]//ig')" != '//' ]] && {
            udata=$(date "+%d/%m/%Y" -d "+$inputdate days")
            sysdate="$(echo "$udata" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
        } || {
            udata=$(echo -e "$inputdate")
            sysdate="$(echo -e "$inputdate" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
            today="$(date -d today +"%Y%m%d")"
            timemachine="$(date -d "$sysdate" +"%Y%m%d")"
            [ $today -ge $timemachine ] && {
                verify='1'
                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Date Invalid" \
                    --parse_mode html
                _erro='1'
                return 0
            }
        }
        chage -E $sysdate $userna
        [[ -e /etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna ]] && {
            data2=$(cat /etc/.maAsiss/info-users/$userna | awk -F : {'print $3'})
            sed -i "s;$data2;$udata;" /etc/.maAsiss/info-users/$userna
            echo $userna $udata ${message_from_id}
            sed -i "s;$data2;$udata;" /etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna
        }
    elif [[ "$(grep -wc "${callback_query_from_id}" $User_Active)" != '0' ]]; then
        [[ "$(echo -e "$inputdate" | sed -e 's/[^/]//ig')" != '//' ]] && {
            udata=$(date "+%d/%m/%Y" -d "+$inputdate days")
            sysdate="$(echo "$udata" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
         } || {
            udata=$(echo -e "$inputdate")
            sysdate="$(echo -e "$inputdate" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
            today="$(date -d today +"%Y%m%d")"
            timemachine="$(date -d "$sysdate" +"%Y%m%d")"
            [ $today -ge $timemachine ] && {
                verify='1'
                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Date Invalid" \
                    --parse_mode html
                _erro='1'
                return 0
            }
         }
         chage -E $sysdate $userna
         [[ -e /etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna ]] && {
            pricessh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
            saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
            if [ "$saldores" -lt "$pricessh" ]; then
                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Your Balance Not Enough ⛔" \
                    --parse_mode html
                return 0
            else
                data2=$(cat /etc/bot/info-users/$userna | awk -F : {'print $3'})
                sed -i "s;$data2;$udata;" /etc/.maAsiss/info-users/$userna
                echo $userna $udata ${message_from_id}
                sed -i "s;$data2;$udata;" /etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna
                _CurrSal=$(echo $saldores - $pricessh | bc)
                sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
                sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active
            fi
         }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

add_ssh_trial() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE TRIAL SSH 👤\n\nHow many hours should it last ? EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]]; then
            ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CREATE TRIAL SSH 👤\n\nHow many hours should it last ? EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"       
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

func_add_ssh_trial() {
    mkdir -p /etc/.maAsiss/info-users
[[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
    [[ -f /etc/.maAsiss/.cache/DisableOrderSSH ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Disable Order SSH" \
                --parse_mode html
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
               --text "Func Error Do Nothing" \
               --reply_markup "$(ShellBot.ForceReply)"
        return 0
    }
}
    userna=$(echo Trial`</dev/urandom tr -dc A-Z0-9 | head -c4`)
    password='1'
    t_time=$1
    ex_date=$(date '+%d/%m/%C%y' -d " +2 days")
    tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
    mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold
    }
    [[ -z $t_time ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⛔ error try again")" \
            --parse_mode html
        return 0
        _erro='1'
    }
    /usr/sbin/useradd -M -N -s /bin/false $userna -e $tuserdate >/dev/null 2>&1
    (
        echo "$password"
        echo "$password"
    ) | passwd $userna >/dev/null 2>&1
    echo "$password" >/etc/.maAsiss/$userna
    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
        echo "$userna:$password:$ex_date" >/etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna
        echo "$userna:$password:$ex_date" >/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$userna
    }
dir_teste="/etc/.maAsiss/db_reseller/${message_from_id}/user_by_res/$userna"
dir_teste2="/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$userna"
dates=`date`
cat <<-EOF >/etc/.maAsiss/$userna.sh
#!/bin/bash
# USER TRIAL SSH by ${message_from_id} $dates
kill-by-user $userna
userdel --force $userna
[[ -e $dir_teste ]] && rm $dir_teste
[[ -e $dir_teste2 ]] && rm $dir_teste2

rm /root/login-db.txt > /dev/null 2>&1
rm /root/login-db-pid.txt > /dev/null 2>&1
rm -f /etc/.maAsiss/$userna
rm -f /etc/.maAsiss/$userna.sh
EOF
    chmod +x /etc/.maAsiss/$userna.sh
    echo "/etc/.maAsiss/$userna.sh" | at now + $t_time hour >/dev/null 2>&1
    [[ "$t_time" == '1' ]] && hrs="hour" || hrs="hours"
    ssl=`cat ~/log-install.txt | grep -w "STUNNEL5" | cut -d: -f2`
    ssh=`cat ~/log-install.txt | grep -w "OPENSSH" | cut -d: -f2|sed 's/ //g' | cut -f1`
    drop=`cat ~/log-install.txt | grep -w "DROPBEAR" | cut -d: -f2|sed 's/ //g' | cut -f1`
    wsnone=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET NONE" | cut -d: -f2|sed 's/ //g' | cut -f1`
    wstls=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET TLS" | cut -d: -f2|sed 's/ //g' | cut -f1`
    ovpn=`netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2`
    ovpn1=`netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2`
    ovpn2=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2|sed 's/  //g' | cut -f1 | awk '{print $6}'`
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);

    useradd -e $(date -d "$masaaktif days" +"%Y-%m-%d") -s /bin/false -M $Login
    exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
    echo -e "$Pass\n$Pass\n" | passwd $Login &>/dev/null
    source /usr/sbin/bot-style;

    local env_msg
    env_msg=$( ssh_cfg ) | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$env_msg" \
            --parse_mode html
        return 0
}

fun_drop() {
    port_dropbear=$(ps aux | grep dropbear | awk NR==1 | awk '{print $17;}')
    log=/var/log/auth.log
    loginsukses='Password auth succeeded'
    pids=$(ps ax | grep dropbear | grep " $port_dropbear" | awk -F" " '{print $1}')
    for pid in $pids; do
        pidlogs=$(grep $pid $log | grep "$loginsukses" | awk -F" " '{print $3}')
        i=0
        for pidend in $pidlogs; do
            let i=i+1
        done
        if [ $pidend ]; then
            login=$(grep $pid $log | grep "$pidend" | grep "$loginsukses")
            PID=$pid
            user=$(echo $login | awk -F" " '{print $10}' | sed -r "s/'/ /g")
            waktu=$(echo $login | awk -F" " '{print $2"-"$1,$3}')
            while [ ${#waktu} -lt 13 ]; do
                waktu=$waktu" "
            done
            while [ ${#user} -lt 16 ]; do
                user=$user" "
            done
            while [ ${#PID} -lt 8 ]; do
                PID=$PID" "
            done
            echo "$user $PID $waktu"
        fi
    done
}

user_online_ssh() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        cad_onli=/tmp/$(echo $RANDOM)
        fun_online() {
            local info2
            for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
                [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                _cont=$(($drop + $ovp))
                conex=$(($_cont + $sqd))
                [[ $conex -gt '0' ]] && {
                    timerr="$(ps -o etime $(ps -u $user | grep sshd | awk 'NR==1 {print $1}') | awk 'NR==2 {print $1}')"
                    info2+="━━━━━━━━━━━━━━━━━━━━━\n"
                    info2+="<code>🟢 $user      ⃣ $conex      ⏳ $timerr</code>\n"
                }
            done
            echo -e "$info2"
        }
        fun_online >$cad_onli
        [[ $(cat $cad_onli | wc -w) != '0' ]] && {
            while :; do
                ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
                     --message_id ${callback_query_message_message_id[$id]}
                ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --text "$(while read line; do echo $line; done < <(sed '1,30!d' $cad_onli))" \
                    --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli | wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "No users online" \
                --parse_mode html
            return 0
        }
    elif [[ "$(grep -wc "${callback_query_from_id}" $User_Active)" != '0' ]]; then
        [[ $(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_by_res | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "YOU HAVE NOT CREATED A USER YET!"
            return 0
        }
        cad_onli=/tmp/$(echo $RANDOM)
        fun_online() {
            local info2
            for user in $(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_by_res); do
                [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                conex=$(($sqd + $ovp + $drop))
                [[ $conex -gt '0' ]] && {
                    timerr="$(ps -o etime $(ps -u $user | grep sshd | awk 'NR==1 {print $1}') | awk 'NR==2 {print $1}')"
                    info2+="━━━━━━━━━━━━━━━━━━━━━\n"
                    info2+="<code>👤 $user      ⃣ $conex      ⏳ $timerr</code>\n"
                }
            done
            echo -e "$info2"
        }
        fun_online >$cad_onli
        [[ $(cat $cad_onli | wc -w) != '0' ]] && {
            while :; do
                ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --message_id ${callback_query_message_message_id[$id]}
                ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --text "<code>$(while read line; do echo $line; done < <(sed '1,30!d' $cad_onli))</code>" \
                    --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli | wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "No users online" \
                --parse_mode html
            return 0
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

Saldo_CheckerSSH() {
    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
        pricessh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
        saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
        if [ "$saldores" -lt "$pricessh" ]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Your Balance Not Enough ⛔" \
                --parse_mode html
            _erro="1"
            return 0
        else
            echo
        fi
    }
}

Saldo_CheckerSSH2Month() {
    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
        pricessh=$(grep -w "Price SSH" /etc/.maAsiss/price | awk '{print $NF}')
        saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
        urday=$(echo $pricessh * 2 | bc)
        if [ "$saldores" -lt "$urday" ]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Your Balance Not Enough ⛔" \
                --parse_mode html
            _erro="1"
            return 0
        else
            echo
        fi
    }
}

verifica_acesso() {
    [[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
        [[ "$(grep -wc ${message_from_id} $User_Active)" == '0' ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "WTF !! Whooo Are You ???")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
            return 0
        }
    }
}

ssh_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu1')"
        return 0
    }
}

add_res(){
        gg=$(cat $Res_Token | awk '{print $2}')
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> List name reseller</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="<code>$gg</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
                --message_id ${callback_query_message_message_id[$id]} \
                --text "$env_msg" \
                --parse_mode html 
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👥 ADD Reseller 👥\n\nEnter the name:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

cret_res() {
    file_res=$1
    [[ -z "$file_res" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e Error)"
        _erro='1'
        break
    }
    name_res=$(sed -n '1 p' $file_res | cut -d' ' -f2)
    uname_res=$(sed -n '2 p' $file_res | cut -d' ' -f2)
    saldo_res=$(sed -n '3 p' $file_res | cut -d' ' -f2)
    [[ "${message_from_id[$id]}" = "$Admin_ID" ]] && {
        t_res='reseller'
    }
    Token=$(cat /tmp/scvpsss)
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_by_res
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/trial-fold
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_ray
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_vless
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_trojan
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_wg
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_ss
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_ssr
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_sstp
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_l2tp
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_pptp
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_trgo
    mkdir -p /etc/.maAsiss/db_reseller/"$uname_res"/user_xray
    touch /etc/.maAsiss/db_reseller/"$uname_res"/$uname_res
    echo -e "USER: $uname_res SALDO: $saldo_res TYPE: $t_res" >>$User_Active
    echo -e "Name: $name_res TOKEN: $Token" >> $Res_Token
    echo -e "=========================\nSaldo_Reseller: $saldo_res\n=========================\n" >/etc/.maAsiss/db_reseller/"$uname_res"/$uname_res
    sed -i '$d' $file_res
    
    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
           --text "✅ Successfully Added Reseller. ✅\n\n<b>Name </b>: $name_res\n<b>Token </b>: $Token\n<b>Saldo </b>: $saldo_res\n\n<b>BOT </b>: @${message_reply_to_message_from_username}" \
           --parse_mode html
    return 0
}

del_res() {
    gg=$(cat $Res_Token | awk '{print $2}')
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> List name reseller</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="<code>$gg</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
                --message_id ${callback_query_message_message_id[$id]} \
                --text "$env_msg" \
                --parse_mode html 
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVE Reseller 🗑\n\nInput Name of Reseller:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_del_res() {
    _cli_rev=$1
    [[ -z "$_cli_rev" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Error")"
        return 0
    }
    cek_res_token=$(grep -w "$_cli_rev" "$Res_Token" | awk '{print $NF}' | sed -e 's/[^0-9]//ig'| rev)
    [[ "${message_from_id[$id]}" == "$Admin_ID" ]] && {
        [[ "$(grep -wc "$cek_res_token" $User_Active)" != '0' ]] && {
            [[ -e "/etc/.maAsiss/db_reseller/$cek_res_token/$cek_res_token" ]] && _dirsts='db_reseller' || _dirsts='suspensos'
            [[ "$(ls /etc/.maAsiss/$_dirsts/$cek_res_token/user_by_res | wc -l)" != '0' ]] && {
                for _user in $(ls /etc/.maAsiss/$_dirsts/$cek_res_token/user_by_res); do
                    userdel --force "$_user" 2>/dev/null
                    kill-by-user $_user
                done
            }
            
            rm /root/login-db.txt > /dev/null 2>&1
            rm /root/login-db-pid.txt > /dev/null 2>&1
            sed -i "/\b$_cli_rev\b/d" $Res_Token
            [[ -d /etc/.maAsiss/$_dirsts/$cek_res_token ]] && rm -rf /etc/.maAsiss/$_dirsts/$cek_res_token >/dev/null 2>&1
            sed -i "/\b$cek_res_token\b/d" $User_Active
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "✅ SUCCESSFULLY REMOVED ✅")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ⛔ Reseller DOES NOT EXIST ⛔)"
            return 0
        }
    }
}

reset_saldo_res() {
    gg=$(cat $Res_Token | awk '{print $2}')
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> List </b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="<code>$gg</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
                --message_id ${callback_query_message_message_id[$id]} \
                --text "$env_msg" \
                --parse_mode html 
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🌀 Reset Saldo Reseller 🌀\n\nInput Name of Reseller:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_reset_saldo_res() {
    _cli_rev=$(cat /tmp/resSaldo | awk '{print $NF}' | sed -e 's/[^0-9]//ig'| rev)
    [[ -z "$_cli_rev" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Error")"
        return 0
    }
    cek_res_token=$(grep -ow "$_cli_rev" "$User_Active")
    [[ "${message_from_id[$id]}" == "$Admin_ID" ]] && {
       [[ "$(grep -wc "$cek_res_token" $User_Active)" != '0' ]] && {
            sed -i "/Saldo_Reseller/c\Saldo_Reseller: 0" /etc/.maAsiss/db_reseller/"$cek_res_token"/$cek_res_token
            sed -i "/$cek_res_token/c\USER: $cek_res_token SALDO: 0 TYPE: reseller" $User_Active
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "✅ Succesfully Reset Saldo 0 ✅")" \
                --parse_mode html
            rm -f /tmp/resSaldo
            return 0
    
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e ⛔ Reseller DOES NOT EXIST ⛔)"
        return 0
    }
  }
}

# {name0}](tg://user?id={uid})
func_list_res() {
    if [[ "${callback_query_from_id[$id]}" = "$Admin_ID" ]]; then
        local msg1
        msg1="━━━━━━━━━━━━━━━━━━━━━\n📃 List Reseller !\n━━━━━━━━━━━━━━━━━━━━━\n"
        cek_res_token=$(cat $Res_Token | awk '{print $NF}' | sed -e 's/[^0-9]//ig'| rev)
        gg=$(cat $Res_Token | awk '{print $NF}')
        [[ "$(cat /etc/.maAsiss/res_token | wc -l)" != '0' ]] && {
            while read _atvs; do
                _uativ="$(echo $_atvs | awk '{print $2}')"
                _cursald="$(echo $_atvs | awk '{print $4}')"
                msg1+="• [Reseller](tg://user?id=$_uativ) | • $_cursald \n"
            done <<<"$(grep -w "$cek_res_token" "$User_Active")"
            ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
                --message_id ${callback_query_message_message_id[$id]} \
                --text "$(echo -e "$msg1")" \
                --parse_mode markdown \
                --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'list_bck_adm')" \
            return 0
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "YOU DO NOT HAVE RESELLERS"
            return 0
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

topup_res() {
        gg=$(cat $Res_Token | awk '{print $2}')
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> List name reseller</b>\n"
        env_msg+="─────────────────────\n"
        env_msg+="<code>$gg</code>\n"
        env_msg+="─────────────────────\n"
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
                --message_id ${callback_query_message_message_id[$id]} \
                --text "$env_msg" \
                --parse_mode html 
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "💸 Topup Saldo 💸\n\nName reseller:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_topup_res() {
    userna=$1
    saldo=$2
    _SaldoTotal=$(grep -w 'Saldo_Reseller' /etc/.maAsiss/db_reseller/$userna/$userna | awk '{print $NF}')
    _TopUpSal=$(echo $_SaldoTotal + $saldo | bc)
    sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_TopUpSal" /etc/.maAsiss/db_reseller/$userna/$userna
    sed -i "/$userna/c\USER: $userna SALDO: $_TopUpSal TYPE: reseller" $User_Active
}

func_verif_limite_res() {
    userna=$1
    [[ "$(grep -w "$userna" $User_Active | awk '{print $NF}')" == 'reseller' ]] && {
        echo $_userrev
        _result=$(ls /etc/.maAsiss/db_reseller/$userna/trial-fold | wc -l)       
    }
}

func_limit_publik() {
   getMes=$1
   getLimits=$(grep -w "MAX_USERS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
   _result=$(ls /etc/.maAsiss/public_mode/$getMes | wc -l)
   [[ ! -d /etc/.maAsiss/public_mode ]] && {
       ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
                    --text "⛔ Public mode is off" \
                    --parse_mode html
                ShellBot.sendMessage --chat_id
                return 0
   }
   _result2=$(ls /etc/.maAsiss/public_mode --ignore='settings' | wc -l)
   [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]] && {
       [[ "$_result2" -ge "$getLimits" ]] && {
            ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
                    --text "⛔ Max $getLimits Users" \
                    --parse_mode html
                ShellBot.sendMessage --chat_id
                return 0
       }
       [[ "$_result" -ge "1" ]] && {
            ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
                    --text "⛔ Max Limit Create only 1 Users" \
                    --parse_mode html
                ShellBot.sendMessage --chat_id
                return 0
       }
   }
}

res_ssh_menu() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_re')"
        return 0
    }
}

unset menu_re
menu_re=''
ShellBot.InlineKeyboardButton --button 'menu_re' --line 1 --text '➕ Add SSH ➕' --callback_data '_add_res_ssh'
ShellBot.InlineKeyboardButton --button 'menu_re' --line 2 --text '🟢 List Member SSH 🟢' --callback_data '_member_res_ssh'
ShellBot.InlineKeyboardButton --button 'menu_re' --line 3 --text '⏳ Create Trial SSH ⏳' --callback_data '_trial_res_ssh'
ShellBot.InlineKeyboardButton --button 'menu_re' --line 4 --text '🔙 Back 🔙' --callback_data '_goback'
ShellBot.regHandleFunction --function adduser_ssh --callback_data _add_res_ssh
ShellBot.regHandleFunction --function info_users_ssh --callback_data _member_res_ssh
ShellBot.regHandleFunction --function add_ssh_trial --callback_data _trial_res_ssh
ShellBot.regHandleFunction --function menu_reserv --callback_data _goback
unset menu_re1
menu_re1="$(ShellBot.InlineKeyboardMarkup -b 'menu_re')"

unset menu1
menu1=''
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text 'Create SSH' --callback_data '_add_ssh'
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text 'Delete SSH' --callback_data '_del_ssh'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text 'Renew SSH' --callback_data '_renew_ssh'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text 'Member SSH' --callback_data '_member_ssh'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text 'User Online' --callback_data '_online_ssh'
ShellBot.InlineKeyboardButton --button 'menu1' --line 4 --text 'Create Trial SSH' --callback_data '_trial_ssh'
ShellBot.InlineKeyboardButton --button 'menu1' --line 5 --text '🔙 Back 🔙' --callback_data '_goback1'
ShellBot.regHandleFunction --function adduser_ssh --callback_data _add_ssh
ShellBot.regHandleFunction --function del_ssh --callback_data _del_ssh
ShellBot.regHandleFunction --function renew_ssh --callback_data _renew_ssh
ShellBot.regHandleFunction --function info_users_ssh --callback_data _member_ssh
ShellBot.regHandleFunction --function user_online_ssh --callback_data _online_ssh
ShellBot.regHandleFunction --function add_ssh_trial --callback_data _trial_ssh
ShellBot.regHandleFunction --function admin_service_see --callback_data _goback1
unset keyboard2
keyboard2="$(ShellBot.InlineKeyboardMarkup -b 'menu1')"


#====== ALL ABOUT V2RAY =======#

res_v2ray_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'res_menu_vray')"
        return 0
    }
}
v2ray_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_vray')"
        return 0
    }
}

add_ray() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE USER VMess 👤\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_add_ray() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	   if [[ -f /etc/.maAsiss/.cache/DisableOrderVMESS ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order VMESS" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi

	file_user=$1
	user=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
        export domain=$(cat /usr/local/etc/xray/domain);
        export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
        export pub_key=$(cat /etc/slowdns/server.pub);
        export uuid=$(xray uuid);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-v2ray
	echo "$userna:$data" >/etc/.maAsiss/info-user-v2ray/$userna

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Vmess Account
	cat /usr/local/etc/xray/vmess/03_vmess.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vmess.txt && mv -f /tmp/vmess.txt /usr/local/etc/xray/vmess/03_vmess.json && rm -rf /tmp/vmess.txt;
	echo -e "VM $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	# // String Vmess Json
        export VMESSTLS=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" } " | base64 -w 0 );
        export VMESSNON=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
        export VMESSGRPC=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"grpc\",\"path\": \"vmess-grpc\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
        export VMESSH2=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"h2\",\"path\": \"/vmess-h2\",\"type\": \"none\",\"host\": \"\",\"sni\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );

	# // Getting Link Client Xray Vmess
	export vmesslink1="vmess://${VMESSTLS}";
        export vmesslink2="vmess://${VMESSNON}";
        export vmesslink3="vmess://${VMESSH2}";
        export vmesslink4="vmess://${VMESSGRPC}";

	# // Success create vmess
        systemctl restart xray@vmess.service
        source /usr/sbin/bot-style;
	vmess_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vmess_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	pricevmess=$(grep -w "Price VMess" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	if [ "$saldores" -lt "$pricevmess" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-v2ray
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_ray
	echo "$userna:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna
	echo "$userna:$data" >/etc/.maAsiss/info-user-v2ray/$userna
	_CurrSal=$(echo $saldores - $pricevmess | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Vmess Account
	cat /usr/local/etc/xray/vmess/03_vmess.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vmess.txt && mv -f /tmp/vmess.txt /usr/local/etc/xray/vmess/03_vmess.json && rm -rf /tmp/vmess.txt;
	echo -e "VM $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	# // String Vmess Json
        export VMESSTLS=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" } " | base64 -w 0 );
        export VMESSNON=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
        export VMESSGRPC=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"grpc\",\"path\": \"vmess-grpc\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
        export VMESSH2=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"h2\",\"path\": \"/vmess-h2\",\"type\": \"none\",\"host\": \"\",\"sni\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );

	# // Getting Link Client Xray Vmess
	export vmesslink1="vmess://${VMESSTLS}";
        export vmesslink2="vmess://${VMESSNON}";
        export vmesslink3="vmess://${VMESSH2}";
        export vmesslink4="vmess://${VMESSGRPC}";

	# // Success create vmess
        systemctl restart xray@vmess.service
        source /usr/sbin/bot-style;
	vmess_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vmess_cfg )
	echo "$userna 30Days VMESS | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

func_add_ray2() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderVMESS ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order VMESS" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi
	file_user=$1
	user=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
        export domain=$(cat /usr/local/etc/xray/domain);
        export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
        export pub_key=$(cat /etc/slowdns/server.pub);
        export uuid=$(xray uuid);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-v2ray
	echo "$userna:$data" >/etc/.maAsiss/info-user-v2ray/$userna

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Vmess Account
	cat /usr/local/etc/xray/vmess/03_vmess.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vmess.txt && mv -f /tmp/vmess.txt /usr/local/etc/xray/vmess/03_vmess.json && rm -rf /tmp/vmess.txt;
	echo -e "VM $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	# // String Vmess Json
        export VMESSTLS=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" } " | base64 -w 0 );
        export VMESSNON=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
        export VMESSGRPC=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"grpc\",\"path\": \"vmess-grpc\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
        export VMESSH2=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"h2\",\"path\": \"/vmess-h2\",\"type\": \"none\",\"host\": \"\",\"sni\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );

	# // Getting Link Client Xray Vmess
	export vmesslink1="vmess://${VMESSTLS}";
        export vmesslink2="vmess://${VMESSNON}";
        export vmesslink3="vmess://${VMESSH2}";
        export vmesslink4="vmess://${VMESSGRPC}";

	# // Success create vmess
        systemctl restart xray@vmess.service
        source /usr/sbin/bot-style;
	vmess_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vmess_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	pricevmess=$(grep -w "Price VMess" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	urday=$(echo $pricevmess * 2 | bc)
	if [ "$saldores" -lt "$urday" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-v2ray
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_ray
	echo "$userna:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna
	echo "$userna:$data" >/etc/.maAsiss/info-user-v2ray/$userna
	_CurrSal=$(echo $saldores - $urday | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Vmess Account
	cat /usr/local/etc/xray/vmess/03_vmess.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vmess.txt && mv -f /tmp/vmess.txt /usr/local/etc/xray/vmess/03_vmess.json && rm -rf /tmp/vmess.txt;
	echo -e "VM $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	# // String Vmess Json
        export VMESSTLS=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" } " | base64 -w 0 );
        export VMESSNON=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
        export VMESSGRPC=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"grpc\",\"path\": \"vmess-grpc\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
        export VMESSH2=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"h2\",\"path\": \"/vmess-h2\",\"type\": \"none\",\"host\": \"\",\"sni\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );

	# // Getting Link Client Xray Vmess
	export vmesslink1="vmess://${VMESSTLS}";
        export vmesslink2="vmess://${VMESSNON}";
        export vmesslink3="vmess://${VMESSH2}";
        export vmesslink4="vmess://${VMESSGRPC}";

	# // Success create vmess
        systemctl restart xray@vmess.service
        source /usr/sbin/bot-style;
	vmess_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vmess_cfg )
	echo "$userna 60Days VMESS | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

del_ray() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVE USER V2RAY 🗑\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_del_ray() {
    user=$1
    [[ "${message_from_id[$id]}" = "$Admin_ID" ]] && {
        exp=$(grep -wE "^VM $user" "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 3 | sort | uniq)
	
        sed -i "/^### $userna $exp/,/^},{/d" /etc/$raycheck/config.json
        datata=$(find /etc/.maAsiss/ -name $userna)
        for accc in "${datata[@]}"
        do
        rm $accc
        done
        systemctl restart $raycheck > /dev/null 2>&1
    } || {
        [[ ! -e /etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "⛔ THE USER DOES NOT EXIST ⛔")" \
                --parse_mode html
            _erro='1'      
            ShellBot.sendMessage --chat_id ${callack_query_message_chat_id[$id]} \
                 --text "Func Error Do Nothing" \
                 --reply_markup "$(ShellBot.ForceReply)"
            return 0
        }
        exp=$(grep -wE "^### $userna" "/etc/$raycheck/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^### $userna $exp/,/^},{/d" /etc/$raycheck/config.json
        rm /etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna
        rm /etc/.maAsiss/info-user-v2ray/$userna
        systemctl restart $raycheck > /dev/null 2>&1
    }
}

add_ray_trial() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE TRIAL VMess 👤\n\nHow many hours should it last ? EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]]; then
            ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CREATE TRIAL VMess 👤\n\nHow many hours should it last ? EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"       
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

func_add_ray_trial() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderVMESS ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order VMESS" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi
        mkdir -p /etc/.maAsiss/info-user-v2ray
        userna=$(echo Trial`</dev/urandom tr -dc A-Z0-9 | head -c4`)
        t_time=$1

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

        exp=`date -d "2 days" +"%Y-%m-%d"`
        tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")

        if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
           mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold
        fi
        if [[ -z $t_time ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⛔ error try again")" \
            --parse_mode html
        return 0
        _erro='1'
        fi

	echo "$userna:$exp" >/etc/.maAsiss/info-user-v2ray/$userna
	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Vmess Account
	cat /usr/local/etc/xray/vmess/03_vmess.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vmess.txt && mv -f /tmp/vmess.txt /usr/local/etc/xray/vmess/03_vmess.json && rm -rf /tmp/vmess.txt;
	echo -e "VM $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    echo "$userna:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna
	    echo "$userna:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$userna
	fi
	dir_teste="/etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna"
	dir_teste2="/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$userna"
	dates=`date`

cat <<-EOF >/etc/.maAsiss/$userna.sh
#!/bin/bash
# USER TRIAL VMESS by ${message_from_id} $dates
exp=\$(grep -wE "^VM $user" "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^VM $user $exp/,/^},{/d" /etc/$raycheck/config.json
systemctl restart $raycheck > /dev/null 2>&1
rm /etc/.maAsiss/db_reseller/${message_from_id}/user_ray/$userna
rm /etc/.maAsiss/info-user-v2ray/$userna
[[ -e $dir_teste ]] && rm $dir_teste
[[ -e $dir_teste2 ]] && rm $dir_teste2
rm -f /etc/.maAsiss/$userna
rm -f /etc/.maAsiss/$userna.sh
EOF

	chmod +x /etc/.maAsiss/$userna.sh
	echo "/etc/.maAsiss/$userna.sh" | at now + $t_time hour >/dev/null 2>&1

	[[ "$t_time" == '1' ]] && hrs="hour" || hrs="hours"
	# // String Vmess Json
        export VMESSTLS=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" } " | base64 -w 0 );
        export VMESSNON=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
        export VMESSGRPC=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"grpc\",\"path\": \"vmess-grpc\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
        export VMESSH2=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"h2\",\"path\": \"/vmess-h2\",\"type\": \"none\",\"host\": \"\",\"sni\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );

	# // Getting Link Client Xray Vmess
	export vmesslink1="vmess://${VMESSTLS}";
        export vmesslink2="vmess://${VMESSNON}";
        export vmesslink3="vmess://${VMESSH2}";
        export vmesslink4="vmess://${VMESSGRPC}";

	# // Success create vmess
        systemctl restart xray@vmess.service
        source /usr/sbin/bot-style;
	vmess_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vmess_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

list_member_ray() {
   if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
      _result=$(grep -E "^VM " "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 2 | column -t | sort | uniq | wc -l)
      _results=$(grep -E "^VM " "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 2 | column -t | sort | uniq )
   elif [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
      _result=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_ray | wc -l)
      _results=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_ray )
   else
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCESS DENIED ⛔" \
                --parse_mode html
      return 0
   fi
   if [ "$_result" = "0" ]; then
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
      return 0
   else
      ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
      ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "━━━━━━━━━━━━━━━━━━━━━\n 🏁 VMESS MEMBER LIST 🏁 \n━━━━━━━━━━━━━━━━━━━━━\n\n$_results\n\n━━━━━━━━━━━━━━━━━━━━━\n" \
         --parse_mode html
      return 0
   fi
}

check_login_ray(){
	if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
	echo -n > /tmp/other.txt
	data=( `cat /usr/local/etc/xray/user.txt | grep 'VM' | cut -d ' ' -f 2 | sort | uniq`);
	min0="$(date -d '0 days' +"%H:%M")";
	min1="$(date -d '-1minute' +"%H:%M")";
	echo -e "━━━━━━━━━━━━━━━━━━━━━" > /tmp/vmess-login
	echo -e "         🟢 Vmess User Login 🟢  " >> /tmp/vmess-login
	echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vmess-login
	for akun in "${data[@]}"
	do
	echo -n > /tmp/ipvmess.txt;
	data2=( `cat /var/log/xray/access.log | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
	for ip in "${data2[@]}"
	do
	jum=$(cat /var/log/xray/access.log | grep -w "$min0\|$min1" | grep -w $akun | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq);
	if [[ "$jum" = "$ip" ]]; then
     	    echo "$jum" >> /tmp/ipvmess.txt;
	else
            echo "$ip" >> /tmp/other.txt;
	fi
	    jum2=$(cat /tmp/ipvmess.txt);
  	    sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
	done
	jum=$(cat /tmp/ipvmess.txt);
	if [[ -z "$jum" ]]; then
 	    echo > /dev/null
	else
	    jum2=$(cat /tmp/ipvmess.txt | nl -s ' 鈥� ');
	    echo -e "  User = $akun" >> /tmp/vmess-login;
	    echo -e "$jum2" >> /tmp/vmess-login;
	    echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vmess-login
	fi
        rm -rf /tmp/ipvmess.txt;
        done
	rm -rf /tmp/other.txt
	rm -rf /tmp/ipvmess.txt
	msg=$(cat /tmp/vmess-login)
	cekk=$(cat /tmp/vmess-login | wc -l)
	if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ NO USERS ONLINE ⛔" \
                --parse_mode html
	rm /tmp/vmess-login
	return 0
	else
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
	         --text "$msg" \
	         --parse_mode html
	rm /tmp/vmess-login
	return 0
	fi
	else
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCESS DENIED ⛔" \
                --parse_mode html
	return 0
	fi
}

unset menu_vray
menu_vray=''
ShellBot.InlineKeyboardButton --button 'menu_vray' --line 1 --text 'Create VMess' --callback_data '_add_ray'
ShellBot.InlineKeyboardButton --button 'menu_vray' --line 2 --text 'Delete VMess' --callback_data '_del_ray'
ShellBot.InlineKeyboardButton --button 'menu_vray' --line 3 --text 'Create Trial VMess' --callback_data '_trial_ray'
ShellBot.InlineKeyboardButton --button 'menu_vray' --line 4 --text 'List Member VMess' --callback_data '_list_ray'
ShellBot.InlineKeyboardButton --button 'menu_vray' --line 5 --text 'Check User Login VMess' --callback_data '_login_ray'
ShellBot.InlineKeyboardButton --button 'menu_vray' --line 6 --text '🔙 Back 🔙' --callback_data '_gobackray'
ShellBot.regHandleFunction --function add_ray --callback_data _add_ray
ShellBot.regHandleFunction --function del_ray --callback_data _del_ray
ShellBot.regHandleFunction --function add_ray_trial --callback_data _trial_ray
ShellBot.regHandleFunction --function list_member_ray --callback_data _list_ray
ShellBot.regHandleFunction --function check_login_ray --callback_data _login_ray
ShellBot.regHandleFunction --function admin_service_see --callback_data _gobackray
unset keyboardray
keyboardray="$(ShellBot.InlineKeyboardMarkup -b 'menu_vray')"

unset res_menu_vray
res_menu_vray=''
ShellBot.InlineKeyboardButton --button 'res_menu_vray' --line 1 --text '➕ Add VMess ➕' --callback_data '_res_add_ray'
ShellBot.InlineKeyboardButton --button 'res_menu_vray' --line 2 --text '⏳ Create Trial VMess ⏳' --callback_data '_res_trial_ray'
ShellBot.InlineKeyboardButton --button 'res_menu_vray' --line 3 --text '🟢 List Member VMess 🟢' --callback_data '_res_list_ray'
ShellBot.InlineKeyboardButton --button 'res_menu_vray' --line 4 --text '🔙 Back 🔙' --callback_data '_res_gobackray'
ShellBot.regHandleFunction --function add_ray --callback_data _res_add_ray
ShellBot.regHandleFunction --function add_ray_trial --callback_data _res_trial_ray
ShellBot.regHandleFunction --function list_member_ray --callback_data _res_list_ray
ShellBot.regHandleFunction --function menu_reserv --callback_data _res_gobackray
unset keyboardrayres
keyboardrayres="$(ShellBot.InlineKeyboardMarkup -b 'res_menu_vray')"

#======= TROJAN MENU =========

res_trojan_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'res_menu_trojan')"
        return 0
    }
}
trojan_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_trojan')"
        return 0
    }
}

add_trojan() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE USER Trojan 👤\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_add_trojan() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderTROJAN ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Disable Order TROJAN" \
                --parse_mode html
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
               --text "Func Error Do Nothing" \
               --reply_markup "$(ShellBot.ForceReply)"
        return 0
	    fi
	fi

	file_user=$1
	user=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-trojan
	echo "$user:$data" >/etc/.maAsiss/info-user-trojan/$user

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Trojan Account
	cat /usr/local/etc/xray/trojan/03_trojan.json | jq '.inbounds[1,2,3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/trojan.txt && mv -f /tmp/trojan.txt /usr/local/etc/xray/trojan/03_trojan.json && rm -rf /tmp/trojan.txt;
	echo -e "TR $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Trojan
        export trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
        export trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan#${user}";
        export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
        export trojanlink4="trojan://${uuid}@${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";

	# // Success create trojan
        systemctl restart xray@trojan.service
        source /usr/sbin/bot-style;
	trojan_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojan_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	#======= RESELLER CREATE ACCOUNT =========
	pricetrojan=$(grep -w "Price Trojan :" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	if [ "$saldores" -lt "$pricetrojan" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-trojan
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_trojan
	echo "$user:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$user
	echo "$user:$data" >/etc/.maAsiss/info-user-trojan/$user
	_CurrSal=$(echo $saldores - $pricetrojan | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Trojan Account
	cat /usr/local/etc/xray/trojan/03_trojan.json | jq '.inbounds[1,2,3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/trojan.txt && mv -f /tmp/trojan.txt /usr/local/etc/xray/trojan/03_trojan.json && rm -rf /tmp/trojan.txt;
	echo -e "TR $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Trojan
        export trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
        export trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan#${user}";
        export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
        export trojanlink4="trojan://${uuid}@${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";

	# // Success create trojan
        systemctl restart xray@trojan.service
        source /usr/sbin/bot-style;
        trojan_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojan_cfg )
	echo "$user 30Days TROJAN | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

func_add_trojan2() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderTROJAN ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Disable Order TROJAN" \
                --parse_mode html
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
               --text "Func Error Do Nothing" \
               --reply_markup "$(ShellBot.ForceReply)"
        return 0
	    fi
	fi

	file_user=$1
	user=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-trojan
	echo "$user:$data" >/etc/.maAsiss/info-user-trojan/$user

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Trojan Account
	cat /usr/local/etc/xray/trojan/03_trojan.json | jq '.inbounds[1,2,3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/trojan.txt && mv -f /tmp/trojan.txt /usr/local/etc/xray/trojan/03_trojan.json && rm -rf /tmp/trojan.txt;
	echo -e "TR $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Trojan
        export trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
        export trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan#${user}";
        export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
        export trojanlink4="trojan://${uuid}@${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";

	# // Success create trojan
        systemctl restart xray@trojan.service
        source /usr/sbin/bot-style;
        trojan_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojan_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	#======= RESELLER CREATE ACCOUNT TRIAL =========
	pricetrojan=$(grep -w "Price Trojan :" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	urday=$(echo $pricetrojan * 2 | bc)
	if [ "$saldores" -lt "$urday" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-trojan
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_trojan
	echo "$user:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$user
	echo "$user:$data" >/etc/.maAsiss/info-user-trojan/$user
	_CurrSal=$(echo $saldores - $urday | bc)

	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Trojan Account
	cat /usr/local/etc/xray/trojan/03_trojan.json | jq '.inbounds[1,2,3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/trojan.txt && mv -f /tmp/trojan.txt /usr/local/etc/xray/trojan/03_trojan.json && rm -rf /tmp/trojan.txt;
	echo -e "TR $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Trojan
        export trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
        export trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan#${user}";
        export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
        export trojanlink4="trojan://${uuid}@${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";

	# // Success create trojan
        systemctl restart xray@trojan.service
        source /usr/sbin/bot-style;
        trojan_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojan_cfg )
	echo "$user 60Days TROJAN | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

del_trojan() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVE USER TROJAN 🗑\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

func_del_trojan() {
    userna=$1
    if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
        exp=$(grep -wE "^TR $user" "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^TR $user $exp/,/^},{/d" /etc/$raycheck/config.json
        datata=$(find /etc/.maAsiss/ -name $userna)
        for accc in "${datata[@]}"
        do
        rm $accc
        done
        systemctl restart xray@trojan.service > /dev/null 2>%261
    else
        if [[ ! -e /etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$userna ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "⛔ THE USER DOES NOT EXIST ⛔")" \
                --parse_mode html
            _erro='1'
            ShellBot.sendMessage --chat_id ${callack_query_message_chat_id[$id]} \
                 --text "Func Error Do Nothing" \
                 --reply_markup "$(ShellBot.ForceReply)"
            return 0
        fi
        exp=$(grep -wE "^#! $userna" "/etc/$raycheck/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#! $userna $exp/,/^},{/d" /etc/$raycheck/config.json
        rm /etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$userna
        rm /etc/.maAsiss/info-user-trojan/$userna
        systemctl restart $raycheck > /dev/null 2>&1
    fi
}

add_trojan_trial() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE TRIAL Trojan 👤\n\nHow many hours should it last ? EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]]; then
            ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CREATE TRIAL Trojan 👤\n\nHow many hours should it last ? EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

func_add_trojan_trial() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderTROJAN ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "⛔ Disable Order TROJAN" \
                --parse_mode html
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
               --text "Func Error Do Nothing" \
               --reply_markup "$(ShellBot.ForceReply)"
        return 0
	    fi
	fi

        mkdir -p /etc/.maAsiss/info-user-trojan
        user=$(echo Trial`</dev/urandom tr -dc A-Z0-9 | head -c4`)
        t_time=$1
	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

        exp=`date -d "2 days" +"%Y-%m-%d"`
        tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
        if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
           mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold
        fi
        if [[ -z $t_time ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⛔ error try again")" \
            --parse_mode html
        return 0
        _erro='1'
        fi

	echo "$user:$exp" >/etc/.maAsiss/info-user-trojan/$user
        # // Create Xray Trojan Account
	cat /usr/local/etc/xray/trojan/03_trojan.json | jq '.inbounds[1,2,3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/trojan.txt && mv -f /tmp/trojan.txt /usr/local/etc/xray/trojan/03_trojan.json && rm -rf /tmp/trojan.txt;
	echo -e "TR $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    echo "$user:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$user
	    echo "$user:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$user
	fi
	dir_teste="/etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$user"
	dir_teste2="/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$user"
	dates=`date`

cat <<-EOF >/etc/.maAsiss/$user.sh
#!/bin/bash
# USER TRIAL TROJAN by ${message_from_id} $dates
exp=\$(grep -wE "^#! $user" "/etc/$raycheck/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#! $user $exp/,/^},{/d" /etc/$raycheck/config.json
systemctl restart $raycheck > /dev/null 2>&1
rm /etc/.maAsiss/db_reseller/${message_from_id}/user_trojan/$user
rm /etc/.maAsiss/info-user-trojan/$user
[[ -e $dir_teste ]] && rm $dir_teste
[[ -e $dir_teste2 ]] && rm $dir_teste2
rm -f /etc/.maAsiss/$user
rm -f /etc/.maAsiss/$user.sh
EOF

	chmod +x /etc/.maAsiss/$user.sh
	echo "/etc/.maAsiss/$user.sh" | at now + $t_time hour >/dev/null 2>&1
	[[ "$t_time" == '1' ]] && hrs="hour" || hrs="hours"
        # // Getting Link Client Xray Trojan
        export trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
        export trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan#${user}";
        export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
        export trojanlink4="trojan://${uuid}@${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";

	# // Success create trojan
        systemctl restart xray@trojan.service
        source /usr/sbin/bot-style;
        trojan_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojan_cfg )
        echo "$user 60Days TROJAN | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0

}

list_member_trojan() {
   if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
      _result=$(grep -E "^TR " "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 2 | column -t | sort | uniq | wc -l)
      _results=$(grep -E "^TR " "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 2 | column -t | sort | uniq )
   elif [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
      _result=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_trojan | wc -l)
      _results=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_trojan )
   else
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCESS DENIED ⛔" \
                --parse_mode html
      return 0
   fi
   if [ "$_result" = "0" ]; then
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
      return 0
   else
      ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
      ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "━━━━━━━━━━━━━━━━━━━━━\n 🟢 TROJAN MEMBER LIST 🟢 \n━━━━━━━━━━━━━━━━━━━━━\n\n$_results\n\n━━━━━━━━━━━━━━━━━━━━━\n" \
         --parse_mode html
      return 0
   fi
}

check_login_trojan(){
	if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
	# // Start Checkking Trojan
	echo -n > /tmp/other.txt;
	data=( `cat /usr/local/etc/xray/user.txt | grep "^TR " | cut -d ' ' -f 2 | sort | uniq`);
	min0="$(date -d '0 days' +"%H:%M")";
	min1="$(date -d '-1minute' +"%H:%M")";
	echo -e "━━━━━━━━━━━━━━━━━━━━━" > /tmp/trojan-login
	echo -e "         🟢 Trojan User Login 🟢  " >> /tmp/trojan-login
	echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/trojan-login
	for akun in "${data[@]}"
	do
	echo -n > /tmp/iptrojan.txt;
	data2=( `cat /var/log/xray/access.log | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
	for ip in "${data2[@]}"
	do
	jum=$(cat /var/log/xray/access.log | grep -w "$min0\|$min1" | grep -w $akun | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq);
	if [[ "$jum" = "$ip" ]]; then
     	    echo "$jum" >> /tmp/iptrojan.txt;
	else
            echo "$ip" >> /tmp/other.txt;
	fi
	    jum2=$(cat /tmp/iptrojan.txt);
  	    sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
	done
	jum=$(cat /tmp/iptrojan.txt);
	if [[ -z "$jum" ]]; then
 	    echo > /dev/null
	else
	    jum2=$(cat /tmp/iptrojan.txt | nl -s ' • ');
	    echo -e "  User = $akun" >> /tmp/trojan-login;
	    echo -e "$jum2" >> /tmp/trojan-login;
	    echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/trojan-login;
	fi
        rm -rf /tmp/iptrojan.txt;
        done
        msg=$(cat /tmp/trojan-login);
        cekk=$(cat /tmp/trojan-login | wc -l)
	if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ NO USERS ONLINE ⛔" \
                --parse_mode html
	rm /tmp/trojan-login;
	return 0
	else
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "$msg" \
         --parse_mode html
	rm /tmp/trojan-login;
	return 0
	fi
	else
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCES DENIED ⛔" \
                --parse_mode html
	return 0
	fi
}

unset menu_trojan
menu_trojan=''
ShellBot.InlineKeyboardButton --button 'menu_trojan' --line 1 --text 'Create Trojan' --callback_data '_add_trojan'
ShellBot.InlineKeyboardButton --button 'menu_trojan' --line 2 --text 'Delete Trojan' --callback_data '_delete_trojan'
ShellBot.InlineKeyboardButton --button 'menu_trojan' --line 3 --text 'Create Trial Trojan' --callback_data '_trial_trojan'
ShellBot.InlineKeyboardButton --button 'menu_trojan' --line 4 --text 'List Member Trojan' --callback_data '_member_trojan'
ShellBot.InlineKeyboardButton --button 'menu_trojan' --line 5 --text 'Check User Login Trojan' --callback_data '_login_trojan'
ShellBot.InlineKeyboardButton --button 'menu_trojan' --line 6 --text '🔙 Back 🔙' --callback_data '_gobacktro'
ShellBot.regHandleFunction --function add_trojan --callback_data _add_trojan
ShellBot.regHandleFunction --function del_trojan --callback_data _delete_trojan
ShellBot.regHandleFunction --function add_trojan_trial --callback_data _trial_trojan
ShellBot.regHandleFunction --function list_member_trojan --callback_data _member_trojan
ShellBot.regHandleFunction --function check_login_trojan --callback_data _login_trojan
ShellBot.regHandleFunction --function admin_service_see --callback_data _gobacktro
unset keyboardtro
keyboardtro="$(ShellBot.InlineKeyboardMarkup -b 'menu_trojan')"

unset res_menu_trojan
res_menu_trojan=''
ShellBot.InlineKeyboardButton --button 'res_menu_trojan' --line 1 --text '➕ Add Trojan ➕' --callback_data '_res_add_trojan'
ShellBot.InlineKeyboardButton --button 'res_menu_trojan' --line 3 --text '⏳ Create Trial Trojan ⏳' --callback_data '_res_trial_trojan'
ShellBot.InlineKeyboardButton --button 'res_menu_trojan' --line 4 --text '🟢 List Member Trojan 🟢' --callback_data '_res_member_trojan'
ShellBot.InlineKeyboardButton --button 'res_menu_trojan' --line 5 --text '🔙 Back 🔙' --callback_data '_res_gobacktro'
ShellBot.regHandleFunction --function add_trojan --callback_data _res_add_trojan
ShellBot.regHandleFunction --function add_trojan_trial --callback_data _res_trial_trojan
ShellBot.regHandleFunction --function list_member_trojan --callback_data _res_member_trojan
ShellBot.regHandleFunction --function menu_reserv --callback_data _res_gobacktro
unset keyboardtrores
keyboardtrores="$(ShellBot.InlineKeyboardMarkup -b 'res_menu_trojan')"

#======= VLESS MENU =========
res_vless_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'res_menu_vless')"
        return 0
    }
}

vless_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_vless')"
        return 0
    }
}

add_vless() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE USER VLess 👤\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_add_vless() {
if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
    if [[ -f /etc/.maAsiss/.cache/DisableOrderVLESS ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order VLESS" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi

	file_user=$1
	user=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-vless
	echo "$user:$data" >/etc/.maAsiss/info-user-vless/$user

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray vless Account
	cat /usr/local/etc/xray/vless/03_vless.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vless.txt && mv -f /tmp/vless.txt /usr/local/etc/xray/vless/03_vless.json && rm -rf /tmp/vless.txt;
	echo -e "VL $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray vless
	export vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}";
        export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%2Fvless-h2%26sni=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@vless.service
        source /usr/sbin/bot-style;
	vless_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vless_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	pricevless=$(grep -w "Price VLess" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	if [ "$saldores" -lt "$pricevless" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-vless
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_vless
	echo "$user:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$user
	echo "$user:$data" >/etc/.maAsiss/info-user-vless/$user
	_CurrSal=$(echo $saldores - $pricevless | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray vless Account
	cat /usr/local/etc/xray/vless/03_vless.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vless.txt && mv -f /tmp/vless.txt /usr/local/etc/xray/vless/03_vless.json && rm -rf /tmp/vless.txt;
	echo -e "VL $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray vless
	export vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}";
        export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%2Fvless-h2%26sni=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@vless.service
        source /usr/sbin/bot-style;
        vless_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vless_cfg )
	echo "$user 30Days VLESS | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

func_add_vless2() {
if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
    if [[ -f /etc/.maAsiss/.cache/DisableOrderVLESS ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order VLESS" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi
	file_user=$1
	user=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-vless
	echo "$user:$data" >/etc/.maAsiss/info-user-vless/$user

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray vless Account
	cat /usr/local/etc/xray/vless/03_vless.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vless.txt && mv -f /tmp/vless.txt /usr/local/etc/xray/vless/03_vless.json && rm -rf /tmp/vless.txt;
	echo -e "VL $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray vless
	export vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}";
        export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%2Fvless-h2%26sni=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@vless.service
        source /usr/sbin/bot-style;
        vless_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vless_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	pricevless=$(grep -w "Price VLess" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	urday=$(echo $pricevless * 2 | bc)
	if [ "$saldores" -lt "$urday" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-vless
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_vless
	echo "$user:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$user
	echo "$user:$data" >/etc/.maAsiss/info-user-vless/$user
	_CurrSal=$(echo $saldores - $urday | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray vless Account
	cat /usr/local/etc/xray/vless/03_vless.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vless.txt && mv -f /tmp/vless.txt /usr/local/etc/xray/vless/03_vless.json && rm -rf /tmp/vless.txt;
	echo -e "VL $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray vless
	export vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}";
        export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%2Fvless-h2%26sni=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@vless.service
        source /usr/sbin/bot-style;
        vless_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vless_cfg )
	echo "$user 60Days VLESS | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

add_vless_trial() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE TRIAL VLess 👤\n\nHow many hours should it last ? EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]]; then
            ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CREATE TRIAL VLess 👤\n\nHow many hours should it last ? EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

func_add_vless_trial() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderVLESS ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order VLESS" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi

	mkdir -p /etc/.maAsiss/info-user-vless
        user=$(echo Trial`</dev/urandom tr -dc A-Z0-9 | head -c4`)
        t_time=$1

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

        exp=`date -d "2 days" +"%Y-%m-%d"`
        tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
        if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
          mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold
        fi
        if [[ -z $t_time ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⛔ error try again")" \
            --parse_mode html
        return 0
        _erro='1'
        fi
	echo "$user:$exp" >/etc/.maAsiss/info-user-vless/$user
        # // Create Xray vless Account
	cat /usr/local/etc/xray/vless/03_vless.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vless.txt && mv -f /tmp/vless.txt /usr/local/etc/xray/vless/03_vless.json && rm -rf /tmp/vless.txt;
	echo -e "VL $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    echo "$user:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$user
	    echo "$user:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$user
	fi
	dir_teste="/etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$user"
	dir_teste2="/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$user"
	dates=`date`

cat <<-EOF >/etc/.maAsiss/$user.sh
#!/bin/bash
# USER TRIAL VLESS by ${message_from_id} $dates
exp=\$(grep -wE "^#& $user" "/etc/$raycheck/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $user $exp/,/^},{/d" /etc/$raycheck/config.json
systemctl restart $raycheck > /dev/null 2>&1
rm /etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$user
rm /etc/.maAsiss/info-user-vless/$user
[[ -e $dir_teste ]] && rm $dir_teste
[[ -e $dir_teste2 ]] && rm $dir_teste2
rm -f /etc/.maAsiss/$user
rm -f /etc/.maAsiss/$user.sh
EOF

	chmod +x /etc/.maAsiss/$user.sh
	echo "/etc/.maAsiss/$user.sh" | at now + $t_time hour >/dev/null 2>&1
	[[ "$t_time" == '1' ]] && hrs="hour" || hrs="hours"
        # // Getting Link Client Xray vless
	export vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless%26encryption=none%26type=ws%26sni=bug.com#${user}";
        export vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}";
        export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%2Fvless-h2%26sni=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@vless.service
        source /usr/sbin/bot-style;
        vless_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vless_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

list_member_vless() {
   if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
      _result=$(grep -E "^VL " "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 2 | column -t | sort | uniq | wc -l)
      _results=$(grep -E "^VL " "/usr/local/etc/xray/user.txt" | cut -d ' ' -f 2 | column -t | sort | uniq )
   elif [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
      _result=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_vless | wc -l)
      _results=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_vless )
   else
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCESS DENIED ⛔" \
                --parse_mode html
      return 0
   fi
   if [ "$_result" = "0" ]; then
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
      return 0
   else
      ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
      ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "━━━━━━━━━━━━━━━━━━━━━\n 🟢 VLESS MEMBER LIST 🟢 \n━━━━━━━━━━━━━━━━━━━━━\n\n$_results\n\n━━━━━━━━━━━━━━━━━━━━━\n" \
         --parse_mode html
      return 0
   fi
}

del_vless() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVE USER VLess 🗑\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_del_vless() {
    userna=$1
    [[ "${message_from_id[$id]}" = "$Admin_ID" ]] && {
        exp=$(grep -wE "^#& $userna" "/etc/$raycheck/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#& $userna $exp/,/^},{/d" /etc/$raycheck/config.json
        datata=$(find /etc/.maAsiss/ -name $userna)
        for accc in "${datata[@]}"
        do
        rm $accc
        done
        systemctl restart $raycheck > /dev/null 2>&1
    } || {
        [[ ! -e /etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$userna ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "⛔ THE USER DOES NOT EXIST ⛔")" \
                --parse_mode html
            _erro='1'
            ShellBot.sendMessage --chat_id ${callack_query_message_chat_id[$id]} \
                 --text "Func Error Do Nothing" \
                 --reply_markup "$(ShellBot.ForceReply)"
            return 0
        }
        exp=$(grep -wE "^#& $userna" "/etc/$raycheck/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#& $userna $exp/,/^},{/d" /etc/$raycheck/config.json
        rm /etc/.maAsiss/db_reseller/${message_from_id}/user_vless/$userna
        rm /etc/.maAsiss/info-user-vless/$userna
        systemctl restart $raycheck > /dev/null 2>&1
    }
}

check_login_vless(){
if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
	# // Start Checkking Vless
	echo -n > /tmp/other.txt;
	data=( `cat /usr/local/etc/xray/user.txt | grep "^VL " | cut -d ' ' -f 2 | sort | uniq`);
	min0="$(date -d '0 days' +"%H:%M")";
	min1="$(date -d '-1minute' +"%H:%M")";
	echo -e "━━━━━━━━━━━━━━━━━━━━━" > /tmp/vless-login
	echo -e "         🟢 VLess User Login 🟢  " >> /tmp/vless-login
	echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vless-login
	for akun in "${data[@]}"
	do
	echo -n > /tmp/ipvless.txt;
	data2=( `cat /var/log/xray/access.log | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
	for ip in "${data2[@]}"
	do
	jum=$(cat /var/log/xray/access.log | grep -w "$min0\|$min1" | grep -w $akun | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq);
	if [[ "$jum" = "$ip" ]]; then
     	    echo "$jum" >> /tmp/ipvless.txt;
	else
            echo "$ip" >> /tmp/other.txt;
	fi
	    jum2=$(cat /tmp/ipvless.txt);
  	    sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
	done
	jum=$(cat /tmp/ipvless.txt);
	if [[ -z "$jum" ]]; then
 	    echo > /dev/null
	else
	    jum2=$(cat /tmp/ipvless.txt | nl -s ' • ');
	    echo -e "  User = $akun" >> /tmp/vless-login;
	    echo -e "$jum2" >> /tmp/vless-login;
	    line >> /tmp/vmess-login;
	fi
        rm -rf /tmp/ipvless.txt;
        done
        msg=$(cat /tmp/vless-login);
        cekk=$(cat /tmp/vless-login | wc -l);
	if [ "$cekk" = "0" ] || [ "$cekk" = "6" ]; then
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ NO USERS ONLINE ⛔" \
                --parse_mode html
	rm /tmp/vless-login
	return 0
	else
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "$msg" \
         --parse_mode html
	rm /tmp/vless-login
	return 0
	fi
	else
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCESS DENIED ⛔" \
                --parse_mode html
	return 0
	fi
}

res_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menuzzz')" \
        return 0
    }
}

unset menu_vless
menu_vless=''
ShellBot.InlineKeyboardButton --button 'menu_vless' --line 1 --text 'Create VLess' --callback_data '_add_vless'
ShellBot.InlineKeyboardButton --button 'menu_vless' --line 2 --text 'Delete VLess' --callback_data '_delete_vless'
ShellBot.InlineKeyboardButton --button 'menu_vless' --line 3 --text 'Create Trial VLess' --callback_data '_trial_vless'
ShellBot.InlineKeyboardButton --button 'menu_vless' --line 4 --text 'List Member VLess' --callback_data '_member_vless'
ShellBot.InlineKeyboardButton --button 'menu_vless' --line 5 --text 'Check User Login VLess' --callback_data '_login_vless'
ShellBot.InlineKeyboardButton --button 'menu_vless' --line 6 --text '🔙 Back 🔙' --callback_data '_gobackvless'
ShellBot.regHandleFunction --function add_vless --callback_data _add_vless
ShellBot.regHandleFunction --function del_vless --callback_data _delete_vless
ShellBot.regHandleFunction --function add_vless_trial --callback_data _trial_vless
ShellBot.regHandleFunction --function list_member_vless --callback_data _member_vless
ShellBot.regHandleFunction --function check_login_vless --callback_data _login_vless
ShellBot.regHandleFunction --function admin_service_see --callback_data _gobackvless
unset keyboardvless
keyboardvless="$(ShellBot.InlineKeyboardMarkup -b 'menu_vless')"

unset res_menu_vless
res_menu_vless=''
ShellBot.InlineKeyboardButton --button 'res_menu_vless' --line 1 --text '➕ Add VLess ➕' --callback_data '_res_add_vless'
ShellBot.InlineKeyboardButton --button 'res_menu_vless' --line 3 --text '⏳ Create Trial VLess ⏳' --callback_data '_res_trial_vless'
ShellBot.InlineKeyboardButton --button 'res_menu_vless' --line 4 --text '🟢 List Member VLess 🟢' --callback_data '_res_member_vless'
ShellBot.InlineKeyboardButton --button 'res_menu_vless' --line 5 --text '🔙 Back 🔙' --callback_data '_res_gobackvless'
ShellBot.regHandleFunction --function add_vless --callback_data _res_add_vless
ShellBot.regHandleFunction --function add_vless_trial --callback_data _res_trial_vless
ShellBot.regHandleFunction --function list_member_vless --callback_data _res_member_vless
ShellBot.regHandleFunction --function menu_reserv --callback_data _res_gobackvless
unset keyboardvlessres
keyboardvlessres="$(ShellBot.InlineKeyboardMarkup -b 'res_menu_vless')"

#====== ALL ABOUT ShadowSocksR =======#

res_ssr_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'res_menu_ssr')"
        return 0
    }
}

ssr_menus() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select an Options Below :" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu_ssr')"
        return 0
    }
}

add_ssr() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE USER Shadowsocks-R 👤\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
	} || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

func_add_ssr() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderSSR ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order Shadowsocks-R" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi

	file_user=$1
	userna=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)        

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
        export pwdr_nya=$(cat /usr/local/etc/xray/passwd);
        export pwd_nya=$(openssl rand -base64 16);
        export base641=$(echo -n "2022-blake3-aes-128-gcm:${pwdr_nya}:${pwd_nya}" | base64 -w0);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-ssr
	echo "$userna:$data" >/etc/.maAsiss/info-user-ssr/$userna

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Shadowsock Account
	cat /usr/local/etc/xray/ss/03_ss.json | jq '.inbounds[1,2].settings.clients += [{"password": "'${pwd_nya}'","email": "'${user}'"}]' >/tmp/shadowsock.txt && mv -f /tmp/shadowsock.txt /usr/local/etc/xray/ss/03_ss.json && rm -rf /tmp/shadowsock.txt;
	cat /usr/local/etc/xray/shadowsock-none.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${none1}',"uot": 'true'}]' >/tmp/shadowsock-none.txt && mv -f /tmp/shadowsock-none.txt /home/vps/public_html/${user}-none && rm -rf /tmp/shadowsock-none.txt;
	cat /usr/local/etc/xray/shadowsock-tls.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-tls.txt && mv -f /tmp/shadowsock-tls.txt /home/vps/public_html/${user}-tls && rm -rf /tmp/shadowsock-tls.txt;
	cat /usr/local/etc/xray/shadowsock-grpc.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-grpc.txt && mv -f /tmp/shadowsock-grpc.txt /home/vps/public_html/${user}-grpc && rm -rf /tmp/shadowsock-grpc.txt;
	echo -e "SS $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Shadowsock
	export link="http://${IP_NYA}:85/${user}-tls";
        export link0="http://${IP_NYA}:85/${user}-none";
        export link1="http://${IP_NYA}:85/${user}-grpc";
	export sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26type=ws%26sni=bug.com#${user}";
        export sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}";
        export sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock%26security=none%26type=ws%26host=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@ss.service
        source /usr/sbin/bot-style;
	shadowsock_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( shadowsock_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	pricessr=$(grep -w "Price Shadowsocks-R" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	if [ "$saldores" -lt "$pricessr" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-ssr
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_ssr
	echo "$userna:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna
	echo "$userna:$data" >/etc/.maAsiss/info-user-ssr/$userna
	_CurrSal=$(echo $saldores - $pricessr | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
        export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Shadowsock Account
	cat /usr/local/etc/xray/ss/03_ss.json | jq '.inbounds[1,2].settings.clients += [{"password": "'${pwd_nya}'","email": "'${user}'"}]' >/tmp/shadowsock.txt && mv -f /tmp/shadowsock.txt /usr/local/etc/xray/ss/03_ss.json && rm -rf /tmp/shadowsock.txt;
	cat /usr/local/etc/xray/shadowsock-none.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${none1}',"uot": 'true'}]' >/tmp/shadowsock-none.txt && mv -f /tmp/shadowsock-none.txt /home/vps/public_html/${user}-none && rm -rf /tmp/shadowsock-none.txt;
	cat /usr/local/etc/xray/shadowsock-tls.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-tls.txt && mv -f /tmp/shadowsock-tls.txt /home/vps/public_html/${user}-tls && rm -rf /tmp/shadowsock-tls.txt;
	cat /usr/local/etc/xray/shadowsock-grpc.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-grpc.txt && mv -f /tmp/shadowsock-grpc.txt /home/vps/public_html/${user}-grpc && rm -rf /tmp/shadowsock-grpc.txt;
	echo -e "SS $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Shadowsock
	export link="http://${IP_NYA}:85/${user}-tls";
        export link0="http://${IP_NYA}:85/${user}-none";
        export link1="http://${IP_NYA}:85/${user}-grpc";
	export sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26type=ws%26sni=bug.com#${user}";
        export sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}";
        export sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock%26security=none%26type=ws%26host=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@ss.service
        source /usr/sbin/bot-style;
       shadowsock_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( shadowsock_cfg )
	echo "$userna 30Days SHADOWSOCKS-R | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	/etc/init.d/ssrmu restart
	return 0
	fi
}

func_add_ssr2() {
if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
    if [[ -f /etc/.maAsiss/.cache/DisableOrderSSR ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order Shadowsocks-R" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi
	file_user=$1
	userna=$(sed -n '1 p' $file_user | cut -d' ' -f2)
	data=$(sed -n '2 p' $file_user | cut -d' ' -f2)
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)        

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
        export pwdr_nya=$(cat /usr/local/etc/xray/passwd);
        export pwd_nya=$(openssl rand -base64 16);
        export base641=$(echo -n "2022-blake3-aes-128-gcm:${pwdr_nya}:${pwd_nya}" | base64 -w0);

	if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
	mkdir -p /etc/.maAsiss/info-user-ssr
	echo "$userna:$data" >/etc/.maAsiss/info-user-ssr/$userna

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Shadowsock Account
	cat /usr/local/etc/xray/ss/03_ss.json | jq '.inbounds[1,2].settings.clients += [{"password": "'${pwd_nya}'","email": "'${user}'"}]' >/tmp/shadowsock.txt && mv -f /tmp/shadowsock.txt /usr/local/etc/xray/ss/03_ss.json && rm -rf /tmp/shadowsock.txt;
	cat /usr/local/etc/xray/shadowsock-none.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${none1}',"uot": 'true'}]' >/tmp/shadowsock-none.txt && mv -f /tmp/shadowsock-none.txt /home/vps/public_html/${user}-none && rm -rf /tmp/shadowsock-none.txt;
	cat /usr/local/etc/xray/shadowsock-tls.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-tls.txt && mv -f /tmp/shadowsock-tls.txt /home/vps/public_html/${user}-tls && rm -rf /tmp/shadowsock-tls.txt;
	cat /usr/local/etc/xray/shadowsock-grpc.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-grpc.txt && mv -f /tmp/shadowsock-grpc.txt /home/vps/public_html/${user}-grpc && rm -rf /tmp/shadowsock-grpc.txt;
	echo -e "SS $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Shadowsock
	export link="http://${IP_NYA}:85/${user}-tls";
        export link0="http://${IP_NYA}:85/${user}-none";
        export link1="http://${IP_NYA}:85/${user}-grpc";
	export sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26type=ws%26sni=bug.com#${user}";
        export sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}";
        export sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock%26security=none%26type=ws%26host=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@ss.service
        source /usr/sbin/bot-style;
        shadowsock_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( shadowsock_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi

	pricessr=$(grep -w "Price Shadowsocks-R" /etc/.maAsiss/price | awk '{print $NF}')
	saldores=$(grep -w "Saldo_Reseller" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id} | awk '{print $NF}')
	urday=$(echo $pricessr * 2 | bc)
	if [ "$saldores" -lt "$urday" ]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "⛔ Your Balance Not Enough ⛔" \
	    --parse_mode html
	return 0
	else
	mkdir -p /etc/.maAsiss/info-user-ssr
	mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/user_ssr
	echo "$userna:$data" >/etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna
	echo "$userna:$data" >/etc/.maAsiss/info-user-ssr/$userna
	_CurrSal=$(echo $saldores - $urday | bc)
	sed -i "/Saldo_Reseller/c\Saldo_Reseller: $_CurrSal" /etc/.maAsiss/db_reseller/${message_from_id}/${message_from_id}
	sed -i "/${message_from_id}/c\USER: ${message_from_id} SALDO: $_CurrSal TYPE: reseller" $User_Active

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Shadowsock Account
	cat /usr/local/etc/xray/ss/03_ss.json | jq '.inbounds[1,2].settings.clients += [{"password": "'${pwd_nya}'","email": "'${user}'"}]' >/tmp/shadowsock.txt && mv -f /tmp/shadowsock.txt /usr/local/etc/xray/ss/03_ss.json && rm -rf /tmp/shadowsock.txt;
	cat /usr/local/etc/xray/shadowsock-none.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${none1}',"uot": 'true'}]' >/tmp/shadowsock-none.txt && mv -f /tmp/shadowsock-none.txt /home/vps/public_html/${user}-none && rm -rf /tmp/shadowsock-none.txt;
	cat /usr/local/etc/xray/shadowsock-tls.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-tls.txt && mv -f /tmp/shadowsock-tls.txt /home/vps/public_html/${user}-tls && rm -rf /tmp/shadowsock-tls.txt;
	cat /usr/local/etc/xray/shadowsock-grpc.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-grpc.txt && mv -f /tmp/shadowsock-grpc.txt /home/vps/public_html/${user}-grpc && rm -rf /tmp/shadowsock-grpc.txt;
	echo -e "SS $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Shadowsock
	export link="http://${IP_NYA}:85/${user}-tls";
        export link0="http://${IP_NYA}:85/${user}-none";
        export link1="http://${IP_NYA}:85/${user}-grpc";
	export sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26type=ws%26sni=bug.com#${user}";
        export sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}";
        export sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock%26security=none%26type=ws%26host=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@ss.service
        source /usr/sbin/bot-style;
        shadowsock_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( shadowsock_cfg )
	echo "$userna 60Days SHADOWSOCKS-R | ${message_from_username}" >> /etc/.maAsiss/log_res

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
	fi
}

del_ssr() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVE USER Shadowsocks-R 🗑\n\nUsername:" \
            --reply_markup "$(ShellBot.ForceReply)"
	} || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
	}
}

func_del_ssr() {
    userna=$1
    if [[ "${message_from_id[$id]}" = "$Admin_ID" ]]; then
        exp=$(grep -wE "^###" "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 3)
        sed -i "/^### $userna/d" "/usr/local/shadowsocksr/akun.conf"
        cd /usr/local/shadowsocksr
        match_del=$(python mujson_mgr.py -d -u "${userna}"|grep -w "delete user")
        cd
        datata=$(find /etc/.maAsiss/ -name $userna)
        for accc in "${datata[@]}"
        do
        rm $accc
        done
        /etc/init.d/ssrmu restart
    elif [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
        if [[ ! -e /etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "⛔ THE USER DOES NOT EXIST ⛔")" \
                --parse_mode html
            _erro='1'
            ShellBot.sendMessage --chat_id ${callack_query_message_chat_id[$id]} \
                 --text "Func Error Do Nothing" \
                 --reply_markup "$(ShellBot.ForceReply)"
            return 0
        fi
        exp=$(grep -wE "^###" "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 3)
        sed -i "/^### $userna/d" "/usr/local/shadowsocksr/akun.conf"
        cd /usr/local/shadowsocksr
        match_del=$(python mujson_mgr.py -d -u "${userna}"|grep -w "delete user")
        cd
        rm -f /etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna
        rm -f /etc/.maAsiss/info-user-ssr/$userna
        /etc/init.d/ssrmu restart
    fi
}

add_ssr_trial() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CREATE TRIAL Shadowsocks-R 👤\n\nHow many hours should it last ? EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]]; then
            ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CREATE TRIAL Shadowsocks-R 👤\n\nHow many hours should it last ? EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    fi
}

func_add_ssr_trial() {
	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    if [[ -f /etc/.maAsiss/.cache/DisableOrderSSR ]]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                    --text "⛔ Disable Order Shadowsocks-R" \
                    --parse_mode html
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                   --text "Func Error Do Nothing" \
                   --reply_markup "$(ShellBot.ForceReply)"
            return 0
	    fi
	fi
	mkdir -p /etc/.maAsiss/info-user-ssr
        userna=$(echo Trial`</dev/urandom tr -dc A-Z0-9 | head -c4`)
        t_time=$1

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
        export pwdr_nya=$(cat /usr/local/etc/xray/passwd);
        export pwd_nya=$(openssl rand -base64 16);
        export base641=$(echo -n "2022-blake3-aes-128-gcm:${pwdr_nya}:${pwd_nya}" | base64 -w0);

        exp=`date -d "2 days" +"%Y-%m-%d"`
        tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
        if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
         mkdir -p /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold
        fi
        if [[ -z $t_time ]]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⛔ error try again")" \
            --parse_mode html
        return 0
        _erro='1'
        fi

        # // Create Xray Shadowsock Account
	cat /usr/local/etc/xray/ss/03_ss.json | jq '.inbounds[1,2].settings.clients += [{"password": "'${pwd_nya}'","email": "'${user}'"}]' >/tmp/shadowsock.txt && mv -f /tmp/shadowsock.txt /usr/local/etc/xray/ss/03_ss.json && rm -rf /tmp/shadowsock.txt;
	cat /usr/local/etc/xray/shadowsock-none.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${none1}',"uot": 'true'}]' >/tmp/shadowsock-none.txt && mv -f /tmp/shadowsock-none.txt /home/vps/public_html/${user}-none && rm -rf /tmp/shadowsock-none.txt;
	cat /usr/local/etc/xray/shadowsock-tls.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-tls.txt && mv -f /tmp/shadowsock-tls.txt /home/vps/public_html/${user}-tls && rm -rf /tmp/shadowsock-tls.txt;
	cat /usr/local/etc/xray/shadowsock-grpc.txt | jq '.outbounds[0].settings.servers += [{"address": "'${domain}'","level": '8',"method": "'2022-blake3-aes-128-gcm'","password": "'${pwdr_nya}:${pwd_nya}'","port": '${xtls1}'}]' >/tmp/shadowsock-grpc.txt && mv -f /tmp/shadowsock-grpc.txt /home/vps/public_html/${user}-grpc && rm -rf /tmp/shadowsock-grpc.txt;
	echo -e "SS $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
	    echo "$userna:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna
	    echo "$userna:$exp" >/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$userna
	fi
	dir_teste="/etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna"
	dir_teste2="/etc/.maAsiss/db_reseller/${message_from_id}/trial-fold/$userna"
	dates=`date`

cat <<-EOF >/etc/.maAsiss/$userna.sh
#!/bin/bash
# USER TRIAL SSR by ${message_from_id} $dates
exp=\$(grep -wE "^###" "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 3)
sed -i "/^### $userna/d" "/usr/local/shadowsocksr/akun.conf"
cd /usr/local/shadowsocksr
match_del=$(python mujson_mgr.py -d -u "${userna}"|grep -w "delete user")
cd
rm -f /etc/.maAsiss/db_reseller/${message_from_id}/user_ssr/$userna
rm -f /etc/.maAsiss/info-user-ssr/$userna
/etc/init.d/ssrmu restart
[[ -e $dir_teste ]] && rm $dir_teste
[[ -e $dir_teste2 ]] && rm $dir_teste2
rm -f /etc/.maAsiss/$userna
rm -f /etc/.maAsiss/$userna.sh
EOF

	chmod +x /etc/.maAsiss/$userna.sh
	echo "/etc/.maAsiss/$userna.sh" | at now + $t_time hour >/dev/null 2>&1
	[[ "$t_time" == '1' ]] && hrs="hour" || hrs="hours"
        # // Getting Link Client Xray Shadowsock
	export link="http://${IP_NYA}:85/${user}-tls";
        export link0="http://${IP_NYA}:85/${user}-none";
        export link1="http://${IP_NYA}:85/${user}-grpc";
	export sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26type=ws%26sni=bug.com#${user}";
        export sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}";
        export sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock%26security=none%26type=ws%26host=bug.com#${user}";

	# // Success create vmess
        systemctl restart xray@ss.service
        source /usr/sbin/bot-style;
        shadowsock_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( shadowsock_cfg )

	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

list_member_ssr() {
   if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
      _result=$(grep -wE "^SS" "/usr/local/etc/xray/user.txt" | cut -d ' ' -f2 | column -t | sort | uniq | wc -l)
      _results=$(grep -wE "^SS" "/usr/local/etc/xray/user.txt" | cut -d ' ' -f2 | column -t | sort | uniq )
   elif [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
      _result=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_ssr | wc -l)
      _results=$(ls /etc/.maAsiss/db_reseller/${callback_query_from_id}/user_ssr )
   else
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ ACCESS DENIED ⛔" \
                --parse_mode html
      return 0
   fi
   if [ "$_result" = "0" ]; then
      ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
      return 0
   else
      ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
      ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "━━━━━━━━━━━━━━━━━━━━━\n🟢 ShadowsocksR Member List 🟢\n━━━━━━━━━━━━━━━━━━━━━\n\n$_results\n\n━━━━━━━━━━━━━━━━━━━━━\n" \
         --parse_mode html
      return 0
   fi
}

unset menu_ssr
menu_ssr=''
ShellBot.InlineKeyboardButton --button 'menu_ssr' --line 1 --text 'Create Shadowsock22' --callback_data '_add_ssr'
ShellBot.InlineKeyboardButton --button 'menu_ssr' --line 2 --text 'Delete Shadowsock22' --callback_data '_delete_ssr'
ShellBot.InlineKeyboardButton --button 'menu_ssr' --line 3 --text 'Create Trial SS22' --callback_data '_trial_ssr'
ShellBot.InlineKeyboardButton --button 'menu_ssr' --line 4 --text 'List Member SS22' --callback_data '_member_ssr'
ShellBot.InlineKeyboardButton --button 'menu_ssr' --line 6 --text '🔙 Back 🔙' --callback_data '_gobackssr'
ShellBot.regHandleFunction --function add_ssr --callback_data _add_ssr
ShellBot.regHandleFunction --function del_ssr --callback_data _delete_ssr
ShellBot.regHandleFunction --function add_ssr_trial --callback_data _trial_ssr
ShellBot.regHandleFunction --function list_member_ssr --callback_data _member_ssr
ShellBot.regHandleFunction --function admin_service_see --callback_data _gobackssr
unset keyboardssr
keyboardssr="$(ShellBot.InlineKeyboardMarkup -b 'menu_ssr')"

unset res_menu_ssr
res_menu_ssr=''
ShellBot.InlineKeyboardButton --button 'res_menu_ssr' --line 1 --text '➕ Create Shadowsock22 ➕' --callback_data '_res_add_ssr'
ShellBot.InlineKeyboardButton --button 'res_menu_ssr' --line 3 --text '⏳ Create Trial SS22 ⏳' --callback_data '_res_trial_ssr'
ShellBot.InlineKeyboardButton --button 'res_menu_ssr' --line 4 --text '🟢 List Member SS22 🟢' --callback_data '_res_member_ssr'
ShellBot.InlineKeyboardButton --button 'res_menu_ssr' --line 5 --text '🔙 Back 🔙' --callback_data '_res_gobackssr'
ShellBot.regHandleFunction --function add_ssr --callback_data _res_add_ssr
ShellBot.regHandleFunction --function add_ssr_trial --callback_data _res_trial_ssr
ShellBot.regHandleFunction --function list_member_ssr --callback_data _res_member_ssr
ShellBot.regHandleFunction --function menu_reserv --callback_data _res_gobackssr
unset keyboardssrres
keyboardssrres="$(ShellBot.InlineKeyboardMarkup -b 'res_menu_ssr')"

#====== SETTINGS DATABASE =======#

Ganti_Harga() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "💰 Change Price 💰\n\nPrice SSH:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

public_mod() {
	if [[ -f /etc/.maAsiss/public_mode/settings ]]; then
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
	     --text "✅ Public mode is already on ✅"
	return 0
	fi
        [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        [[ ! -d /etc/.maAsiss/public_mode ]] && mkdir /etc/.maAsiss/public_mode
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🌐 Enable Public Mode 🌐\n\nExpired Days [ex:3]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

public_mod_off() {
	if [[ ! -f /etc/.maAsiss/public_mode/settings ]]; then
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
	     --text "⛔ Public mode is currently off ⛔"
	return 0
	else
	rm -rf /etc/.maAsiss/public_mode
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
	   --text "✅ Success disable public mode ✅"
	return 0
	fi
}

Add_Info_Reseller() {
    [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "📢 Info for reseller 📢\n\ntype your information:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
    }
}

unblock_usr() {
    if [[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]]; then
        ShellBot.deleteMessage	--chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "😤 Unblock user 😤\n\nInput user ID to unblock:" \
            --reply_markup "$(ShellBot.ForceReply)"
        else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔"
        return 0
        fi
}

Del_Info_Reseller() {
	if [[ ! -f /etc/.maAsiss/update-info ]]; then
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
	     --text "⛔ No Information Available ⛔"
	return 0
	else
	rm -f /etc/.maAsiss/update-info
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
	     --text "✅ Success Delete Information ✅"
	return 0
	fi
}

admin_server() {
	[[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "Select Option Below:" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'back_menu_admin')"
        return 0
    }
}


#======= MAIN MENU =========
see_sys() {
        systemctl is-active --quiet stunnel5 && stsstn="Running 🟢" || stsstn="Not Running 🔴"
        systemctl is-active --quiet dropbear && stsdb="Running 🟢" || stsdb="Not Running 🔴"
        systemctl is-active --quiet cron && stscron="Running 🟢" || stscron="Not Running 🔴"
        systemctl is-active --quiet ssh && stsssh="Running 🟢" || stssah="Not Running 🔴"
        systemctl is-active --quiet openvpn && stsovpn="Running 🟢" || stsovpn="Not Running 🔴"
        systemctl is-active --quiet vnstat && stsvnstat="Running 🟢" || stsvnstat="Not Running 🔴"
        systemctl is-active --quiet fail2ban && stsban="Running 🟢" || stsban="Not Running 🔴"
        systemctl is-active --quiet nginx && stsnginx="Running 🟢" || stsnginx="Not Running 🔴"
        systemctl is-active --quiet client-sldns && stscdns="Running 🟢" || stscdns="Not Running 🔴"
    	systemctl is-active --quiet server-sldns && stssdns="Running 🟢" || stssdns="Not Running 🔴"
        systemctl is-active --quiet ws-epro && stsepro="Running 🟢" || stsepro="Not Running 🔴"

	systemctl is-active --quiet xray@tcp && stsray="Running 🟢" || stsray="Not Running 🔴"
        systemctl is-active --quiet xray@none && stsnone="Running 🟢" || stsnone="Not Running 🔴"
        systemctl is-active --quiet xray@vless && stsvless="Running 🟢" || stsvless="Not Running 🔴"
        systemctl is-active --quiet xray@vmess && stsvmess="Running 🟢" || stsvmess="Not Running 🔴"
        systemctl is-active --quiet xray@trojan && ststrojan="Running 🟢" || ststrojan="Not Running 🔴"
        systemctl is-active --quiet xray@ss && stsss="Running 🟢" || stsss="Not Running 🔴"

    	systemctl is-active --quiet trojan-go && ststrgo="Running 🟢" || ststrgo="Not Running 🔴"
	systemctl is-active --quiet wg-quick@wg0 && stswg="Running 🟢" || ststrgo="Not Running 🔴"

        local env_msg
	env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT </b>\n"
	env_msg+="─────────────────────\n"
        env_msg+="Status Service = 🟢\n\n"
        env_msg+="<code>Dropbear            = $stsdb\n"
     	env_msg+="Openssh             = $stsssh\n"
        env_msg+="Stunnel5            = $stsstn\n"
     	env_msg+="Openvpn             = $stsovpn\n"
        env_msg+="Crons               = $stscron\n"
        env_msg+="Vnstat              = $stsvnstat\n"
        env_msg+="Fail²ban            = $stsban\n"
        env_msg+="Nginx               = $stsnginx\n"
        env_msg+="Client DNS          = $stscdns\n"
    	env_msg+="Server DNS          = $stssdns\n"
	env_msg+="WS-ePro SSH/OPENVPN = $stsepro\n"
        env_msg+="Xray Tcp Xtls       = $stsray\n"
    	env_msg+="Xray None Tls       = $stsnone\n"
        env_msg+="Xray Vless          = $stsvless\n"
    	env_msg+="Xray Vmess          = $stsvmess\n"
    	env_msg+="Xray Shadowsock22   = $stsss\n"
        env_msg+="Xray Trojan         = $ststrojan\n"
        env_msg+="Trojan-go           = $ststrgo\n"
	env_msg+="Wireguard           = $stswg\n</code>"
	env_msg+="─────────────────────\n"
	[[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'back_menu_admin')"
        return 0
    }
}

sets_menu() {
        local env_msg
        env_msg="─────────────────────\n"
        env_msg+="<b> WELCOME TO BOT $nameStore</b>\n"
        env_msg+="─────────────────────\n"
	[[ "${callback_query_from_id[$id]}" == "$Admin_ID" ]] || [[ "$(grep -wc ${callback_query_from_id} $User_Active)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$env_msg" \
            --parse_mode html \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'sett_menus')"
        return 0
    }
}


unset menuzzz
menuzzz=''
ShellBot.InlineKeyboardButton --button 'menuzzz' --line 1 --text '👨‍🦱 Add Reseller 👨‍🦱' --callback_data '_add_res'
ShellBot.InlineKeyboardButton --button 'menuzzz' --line 2 --text '💰 Top Up Balance 💰' --callback_data '_top_up_res'
ShellBot.InlineKeyboardButton --button 'menuzzz' --line 3 --text '📃 List %26 Info Reseller 📃' --callback_data '_list_res'
ShellBot.InlineKeyboardButton --button 'menuzzz' --line 4 --text '🗑 Remove Reseller 🗑' --callback_data '_del_res'
ShellBot.InlineKeyboardButton --button 'menuzzz' --line 5 --text '🌀 Reset Saldo Reseller 🌀' --callback_data '_reset_res'
ShellBot.InlineKeyboardButton --button 'menuzzz' --line 10 --text '🔙 Back 🔙' --callback_data '_gobakcuy'
ShellBot.regHandleFunction --function add_res --callback_data _add_res
ShellBot.regHandleFunction --function topup_res --callback_data _top_up_res
ShellBot.regHandleFunction --function func_list_res --callback_data _list_res
ShellBot.regHandleFunction --function del_res --callback_data _del_res
ShellBot.regHandleFunction --function reset_saldo_res --callback_data _reset_res
ShellBot.regHandleFunction --function menu_func_cb --callback_data _gobakcuy
unset keyboardzz
keyboardzz="$(ShellBot.InlineKeyboardMarkup -b 'menuzzz')"


unset menu_adm_ser
menu_adm_ser=''
ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 1 --text '• Menu SSH •' --callback_data '_menussh'
ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 2 --text '• Menu VMess •' --callback_data '_menuv2ray'
ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 1 --text '• Menu Trojan •' --callback_data '_menutrojan'
ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 2 --text '• Menu VLess •' --callback_data '_menuvless'
#ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 4 --text '• Menu Tcp Xtls •' --callback_data '_menutcp'
ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 4 --text '• Menu ShadowSock22 •' --callback_data '_menussr'
#ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 5 --text '• Menu Trojan Go •' --callback_data '_menutrgo'
#ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 5 --text '• Menu Wireguard •' --callback_data '_menuwg'
ShellBot.InlineKeyboardButton --button 'menu_adm_ser' --line 7 --text '🔙 Back 🔙' --callback_data '_mebck'
ShellBot.regHandleFunction --function ssh_menus --callback_data _menussh
ShellBot.regHandleFunction --function v2ray_menus --callback_data _menuv2ray
ShellBot.regHandleFunction --function trojan_menus --callback_data _menutrojan
ShellBot.regHandleFunction --function vless_menus --callback_data _menuvless
#ShellBot.regHandleFunction --function ssr_menus --callback_data _menutcp
#ShellBot.regHandleFunction --function ssr_menus --callback_data _menuwg
#ShellBot.regHandleFunction --function ssr_menus --callback_data _menutrgo
ShellBot.regHandleFunction --function ssr_menus --callback_data _menussr
ShellBot.regHandleFunction --function menu_func_cb --callback_data _mebck
unset menu_adm_ser1
menu_adm_ser1="$(ShellBot.InlineKeyboardMarkup -b 'menu_adm_ser')"


unset list_bck_adm
list_bck_adm=''
ShellBot.InlineKeyboardButton --button 'list_bck_adm' --line 1 --text '🔙 Back 🔙' --callback_data 'list_bck_'
ShellBot.regHandleFunction --function res_menus --callback_data list_bck_
unset list_bck_adm1
list_bck_adm1="$(ShellBot.InlineKeyboardMarkup -b 'list_bck_adm')"


unset status_disable
status_disable=''
ShellBot.InlineKeyboardButton --button 'status_disable' --line 1 --text '💡 How To Use 💡' --callback_data '_how_to'
ShellBot.InlineKeyboardButton --button 'status_disable' --line 2 --text '🔙 Back 🔙' --callback_data '_stsbck'
ShellBot.regHandleFunction --function how_to_order --callback_data _how_to
ShellBot.regHandleFunction --function menu_func_cb --callback_data _stsbck
unset status_disable1
status_disable1="$(ShellBot.InlineKeyboardMarkup -b 'status_disable')"

unset status_how_to
status_how_to=''
ShellBot.InlineKeyboardButton --button 'status_how_to' --line 1 --text '🔙 Back 🔙' --callback_data '_howbck'
ShellBot.regHandleFunction --function status_order --callback_data _howbck
unset status_how_to1
status_how_to1="$(ShellBot.InlineKeyboardMarkup -b 'status_how_to')"

unset sett_menus
sett_menus=''
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 1 --text '🔒 Status Order 🔒' --callback_data '_orderfo'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 1 --text '💰 Change Price 💰' --callback_data '_price'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 2 --text '🤵 Reseller 🤵' --callback_data '_ressssseller'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 2 --text '✍️ See Log Reseller ✍️' --callback_data '_seelog'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 3 --text '🌐 OpenPublic 🌐' --callback_data '_publicmode'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 3 --text '📛 DisablePublic 📛' --callback_data '_publicmodeoff'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 4 --text '🔔 Add Info 🔔' --callback_data '_addinfo'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 4 --text '🔕 Del Info 🔕' --callback_data '_delinfo'
ShellBot.InlineKeyboardButton --button 'sett_menus' --line 10 --text '🔙 Back 🔙' --callback_data '_setssbck'
ShellBot.regHandleFunction --function status_order --callback_data _orderfo
ShellBot.regHandleFunction --function Add_Info_Reseller --callback_data _addinfo
ShellBot.regHandleFunction --function Del_Info_Reseller --callback_data _delinfo
ShellBot.regHandleFunction --function Ganti_Harga --callback_data _price
ShellBot.regHandleFunction --function res_menus --callback_data _ressssseller
ShellBot.regHandleFunction --function see_log --callback_data _seelog
ShellBot.regHandleFunction --function public_mod --callback_data _publicmode
ShellBot.regHandleFunction --function public_mod_off --callback_data _publicmodeoff
ShellBot.regHandleFunction --function menu_func_cb --callback_data _setssbck
unset sett_menus1
sett_menus1="$(ShellBot.InlineKeyboardMarkup -b 'sett_menus')"

unset menu
menu=''
ShellBot.InlineKeyboardButton --button 'menu' --line 1 --text '❇️ Open Service ❇️️' --callback_data '_openserv'
ShellBot.InlineKeyboardButton --button 'menu' --line 1 --text '🟢 Status Service 🟢️️' --callback_data '_stsserv'
ShellBot.InlineKeyboardButton --button 'menu' --line 2 --text '📋 Current Price 📋' --callback_data '_priceinfo'
ShellBot.InlineKeyboardButton --button 'menu' --line 2 --text '⚙️ Settings Menu ⚙️' --callback_data '_menusettss'
ShellBot.InlineKeyboardButton --button 'menu' --line 10 --text '⚠️ Unblock User ⚠️' --callback_data '_unblck'
ShellBot.regHandleFunction --function admin_service_see --callback_data _openserv
ShellBot.regHandleFunction --function see_sys --callback_data _stsserv
ShellBot.regHandleFunction --function admin_price_see --callback_data _priceinfo
ShellBot.regHandleFunction --function sets_menu --callback_data _menusettss
ShellBot.regHandleFunction --function unblock_usr --callback_data _unblck
unset keyboard1
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'menu')"

unset menu_re_ser
menu_re_ser=''
ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 1 --text '• SSH •' --callback_data '_res_ssh_menu'
ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 2 --text '• VMess •' --callback_data '_res_v2ray_menus'
ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 1 --text '• Trojan •' --callback_data '_res_trojan_menus'
ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 2 --text '• VLess •' --callback_data '_res_vless_menus'
#ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 6 --text '• Tcp Xtls •' --callback_data '_res_ssr_menus'
ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 6 --text '• ShadowSock22 •' --callback_data '_res_ssr_menus'
#ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 6 --text '• Trojan Go •' --callback_data '_res_ssr_menus'
#ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 6 --text '• Wireguard •' --callback_data '_res_ssr_menus'
ShellBot.InlineKeyboardButton --button 'menu_re_ser' --line 10 --text '🔙 Back 🔙' --callback_data 'clses_ser_res'
ShellBot.regHandleFunction --function res_ssh_menu --callback_data _res_ssh_menu
ShellBot.regHandleFunction --function res_v2ray_menus --callback_data _res_v2ray_menus
ShellBot.regHandleFunction --function res_trojan_menus --callback_data _res_trojan_menus
ShellBot.regHandleFunction --function res_vless_menus --callback_data _res_vless_menus
#ShellBot.regHandleFunction --function res_ssr_menus --callback_data _res_ssr_menus
#ShellBot.regHandleFunction --function res_ssr_menus --callback_data _res_ssr_menus
#ShellBot.regHandleFunction --function res_ssr_menus --callback_data _res_ssr_menus
ShellBot.regHandleFunction --function res_ssr_menus --callback_data _res_ssr_menus
ShellBot.regHandleFunction --function res_opener --callback_data clses_ser_res
unset menu_re_ser1
menu_re_ser1="$(ShellBot.InlineKeyboardMarkup -b 'menu_re_ser')"


unset menu_re_main
menu_re_main=''
ShellBot.InlineKeyboardButton --button 'menu_re_main' --line 1 --text '⚖️ Open Service ⚖️️' --callback_data '_pps_serv'
ShellBot.InlineKeyboardButton --button 'menu_re_main' --line 2 --text '🟢 Status Service 🟢️' --callback_data '_sts_serv'
ShellBot.InlineKeyboardButton --button 'menu_re_main' --line 3 --text '📚 Info Port 📚' --callback_data '_pports'
ShellBot.InlineKeyboardButton --button 'menu_re_main' --line 4 --text '📁 Close Menu 📁' --callback_data 'closesss'
ShellBot.regHandleFunction --function menu_reserv --callback_data _pps_serv
ShellBot.regHandleFunction --function see_sys --callback_data _sts_serv
ShellBot.regHandleFunction --function info_port --callback_data _pports
ShellBot.regHandleFunction --function res_closer --callback_data closesss
unset menu_re_main1
menu_re_main1="$(ShellBot.InlineKeyboardMarkup -b 'menu_re_main')"

unset back_menu
back_menu=''
ShellBot.InlineKeyboardButton --button 'back_menu' --line 1 --text '🔙 Back 🔙' --callback_data '_res_back_opn'
ShellBot.regHandleFunction --function res_opener --callback_data _res_back_opn
unset back_menu1
back_menu1="$(ShellBot.InlineKeyboardMarkup -b 'back_menu')"

unset back_menu_admin
back_menu_admin=''
ShellBot.InlineKeyboardButton --button 'back_menu_admin' --line 1 --text '🔙 Back 🔙' --callback_data '_res_backadm_opn'
ShellBot.regHandleFunction --function menu_func_cb --callback_data _res_backadm_opn
unset back_menu_admin1
back_menu_admin1="$(ShellBot.InlineKeyboardMarkup -b 'back_menu_admin')"

unset menu_re_main_updater
menu_re_main_updater=''
ShellBot.InlineKeyboardButton --button 'menu_re_main_updater' --line 1 --text '📂 Open Menu 📂' --callback_data '_res_main_opn'
ShellBot.regHandleFunction --function res_opener --callback_data _res_main_opn
unset menu_re_main_updater1
menu_re_main_updater1="$(ShellBot.InlineKeyboardMarkup -b 'menu_re_main_updater')"

hantuu() {
    ShellBot.deleteMessage --chat_id ${message_chat_id[$id]} \
             --message_id ${message_message_id[$id]}
    [[ "${message_from_id[$id]}" = "$Admin_ID" ]] && {
        while read _atvs; do
              msg1+="• [ 👻Anonymous](tg://user?id=$_atvs) \n"
        done <<<"$(cat /etc/.maAsiss/User_Generate_Token |  awk '{print $3}' )"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
              --text "$msg1" \
              --parse_mode markdown
        return 0
    }
}
#================================| PUBLIC MODE |=====================================
_if_public() {
[[ "$(grep -wc ${message_chat_id[$id]} $User_Flood)" = '1' ]] && return 0 || AUTOBLOCK
[[ "${message_from_id[$id]}" != "$Admin_ID" ]] && {
   [[ ! -f /etc/.maAsiss/public_mode/settings ]] && {
       ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "<b>Public Mode Has Been Closed by Admin</b>" \
            --parse_mode html
       return 0
   }
}
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`
xray="$(cat /root/log-install.txt | grep -w "VLess TCP XTLS" | cut -d: -f2|sed 's/ //g')"

getLimits=$(grep -w "MAX_USERS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
dx=$(ls /etc/.maAsiss/public_mode --ignore='settings' | wc -l)
   local env_msg
   env_msg="─────────────────────\n"
   env_msg+="<b>  WELCOME TO $nameStore</b>\n"
   env_msg+="─────────────────────\n"
   env_msg+="•> <b>1 ID Tele = 1 Server VPN</b>\n"
   env_msg+="─────────────────────\n"
   env_msg+="•OpenSSH : $opensh\n"
   env_msg+="•Dropbear : $db\n"
   env_msg+="•OpenVPN : 443\n"
   env_msg+="•SSH WS : 80\n"
   env_msg+="•SSH-WS-SSL : 443\n"
   env_msg+="•SSL/TLS : $ssl\n"
   env_msg+="•UDPGW : 7100-7300\n"
   env_msg+="•Slow DNS : 443\n"
   env_msg+="•Vless : $tr\n"
   env_msg+="•VMess  : 443\n"
   env_msg+="•Trojan : 80\n"
   env_msg+="•Shadowsock : 443\n"
   env_msg+="•Tcp Xtls : 443\n"
   env_msg+="•Trojan Go : 443\n"
   env_msg+="•Wireguard : 443\n"
   env_msg+="─────────────────────\n"
   env_msg+="•> Status = 👤 $dx / $getLimits Max \n"
   env_msg+="━━━━━━━━━━━━━━━━━━━━━\n\n"

   ShellBot.deleteMessage --chat_id ${message_chat_id[$id]} \
      --message_id ${message_message_id[$id]}
   ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
     --text "$env_msg" \
     --reply_markup "$pub_menu1" \
     --parse_mode html
}

ssh_publik(){
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} --message_id ${callback_query_message_message_id[$id]}
	func_limit_publik ${callback_query_from_id}
	r0=$(tr -dc a-zA-Z </dev/urandom | head -c5)
	r1=$(tr -dc 0-9 </dev/urandom | head -c3)
	userna=$(echo $r0$r1)
	passw=$r1
	getDays=$(grep -w "MAX_DAYS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
	data=$(date '+%d/%m/%C%y' -d " +$getDays days")
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Information port
	export ssl=`cat ~/log-install.txt | grep -w "STUNNEL5" | cut -d: -f2`;
	export ssh=`cat ~/log-install.txt | grep -w "OPENSSH" | cut -d: -f2 | cut -f1`;
	export drop=`cat ~/log-install.txt | grep -w "DROPBEAR" | cut -d: -f2 | cut -f1`;
	export wsnone=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET NONE" | cut -d: -f2  | cut -f1`;
	export wstls=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET TLS" | cut -d: -f2 | cut -f1`;
	export vpntcp=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $2,$3}'`;
	export vpnudp=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $5,$6}'`;
	export vpnssl=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $8,$9}'`;
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Dom && Date && Exp
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export exp2=`date -d "$masaaktif days" +"%d-%m-%Y"`;

	if /usr/sbin/useradd -M -N -s /bin/false $userna -e $exp; then
	    (echo "${passw}";echo "${passw}") | passwd "${userna}"
	else
	    ShellBot.sendMessage --chat_id ${callback_query_chat_id[$id]} \
	            --text "⛔ ERROR CREATING USER" \
	            --parse_mode html
	    return 0
	fi

	if [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
	        mkdir -p /etc/.maAsiss/public_mode/${callback_query_from_id}
	        echo "$userna:$passw:$data" >/etc/.maAsiss/public_mode/${callback_query_from_id}/$userna
	        echo "$userna:$passw $getDays Days SSH | ${callback_query_from_first_name}" >> /root/log-public
	fi

	# // Success create ssh
	source /usr/sbin/bot-style;
	ssh_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( ssh_cfg )

	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
}

vmess_publik() {
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} --message_id ${callback_query_message_message_id[$id]}
	func_limit_publik ${callback_query_from_id}
	r0=$(tr -dc a-zA-Z </dev/urandom | head -c5)
	r1=$(tr -dc 0-9 </dev/urandom | head -c3)
	userna=$(echo $r0$r1)
	passw=$r1
	getDays=$(grep -w "MAX_DAYS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
	data=$(date '+%d/%m/%C%y' -d " +$getDays days")
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Vmess Account
	cat /usr/local/etc/xray/vmess/03_vmess.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vmess.txt && mv -f /tmp/vmess.txt /usr/local/etc/xray/vmess/03_vmess.json && rm -rf /tmp/vmess.txt;
	echo -e "VM $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

	# // String Vmess Json
        export VMESSTLS=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" } " | base64 -w 0 );
        export VMESSNON=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"ws\",\"path\": \"/vmess\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
        export VMESSGRPC=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"grpc\",\"path\": \"vmess-grpc\",\"type\": \"none\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
        export VMESSH2=$( echo -n "{ \"v\": \"2\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"h2\",\"path\": \"/vmess-h2\",\"type\": \"none\",\"host\": \"\",\"sni\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );

	# // Getting Link Client Xray Vmess
	export vmesslink1="vmess://${VMESSTLS}";
        export vmesslink2="vmess://${VMESSNON}";
        export vmesslink3="vmess://${VMESSH2}";
        export vmesslink4="vmess://${VMESSGRPC}";

	# // Success create vmess
        systemctl restart xray@vmess.service
        source /usr/sbin/bot-style;
	vmess_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vmess_cfg )

	if [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
	        mkdir -p /etc/.maAsiss/public_mode/${callback_query_from_id}
	        echo "$userna:$uuid:$data" >/etc/.maAsiss/public_mode/${callback_query_from_id}/$userna
	        echo "$userna:$uuid $getDays Days VMESS | ${callback_query_from_first_name}" >> /root/log-public
	fi

	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

vless_publik() {
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} --message_id ${callback_query_message_message_id[$id]}
	func_limit_publik ${callback_query_from_id}
	r0=$(tr -dc a-zA-Z </dev/urandom | head -c5)
	r1=$(tr -dc 0-9 </dev/urandom | head -c3)
	userna=$(echo $r0$r1)
	passw=$r1
	getDy
	ays=$(grep -w "MAX_DAYS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
	data=$(date '+%d/%m/%C%y' -d " +$getDays days")
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray vless Account
	cat /usr/local/etc/xray/vless/03_vless.json | jq '.inbounds[1,2,3].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/vless.txt && mv -f /tmp/vless.txt /usr/local/etc/xray/vless/03_vless.json && rm -rf /tmp/vless.txt;
	echo -e "VL $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray vless
	export vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless&security=tls&encryption=none&type=ws&sni=bug.com#${user}";
        export vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless&encryption=none&type=ws&sni=bug.com#${user}";
        export vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}";
        export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls&encryption=none&type=h2&headerType=none&path=%2Fvless-h2&sni=bug.com#${user}";

	# // Success create vless
        systemctl restart xray@vless.service
        source /usr/sbin/bot-style;
	vless_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( vless_cfg )

	if [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
	        mkdir -p /etc/.maAsiss/public_mode/${callback_query_from_id}
	        echo "$userna:$uuid:$data" >/etc/.maAsiss/public_mode/${callback_query_from_id}/$userna
	        echo "$userna:$uuid $getDays Days VLESS | ${callback_query_from_first_name}" >> /root/log-public
	fi

	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

trojan_publik() {
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} --message_id ${callback_query_message_message_id[$id]}
	func_limit_publik ${callback_query_from_id}
	r0=$(tr -dc a-zA-Z </dev/urandom | head -c5)
	r1=$(tr -dc 0-9 </dev/urandom | head -c3)
	userna=$(echo $r0$r1)
	passw=$r1
	getDays=$(grep -w "MAX_DAYS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
	data=$(date '+%d/%m/%C%y' -d " +$getDays days")
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls And None Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Trojan Account
	cat /usr/local/etc/xray/trojan/03_trojan.json | jq '.inbounds[1,2,3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/trojan.txt && mv -f /tmp/trojan.txt /usr/local/etc/xray/trojan/03_trojan.json && rm -rf /tmp/trojan.txt;
	echo -e "TR $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Trojan
        export trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws&security=tls&path=%2Ftrojan&sni=bug.com#${user}";
        export trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com&security=none&type=ws&path=%2Ftrojan#${user}";
        export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}";
        export trojanlink4="trojan://${uuid}@${domain}:${xtls1}?security=tls&type=h2&headerType=none&path=%2Ftrojan-h2&sni=bug.com#${user}";

	# // Success create vless
        systemctl restart xray@trojan.service
        source /usr/sbin/bot-style;
        trojan_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojan_cfg )

	if [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
	        mkdir -p /etc/.maAsiss/public_mode/${callback_query_from_id}
	        echo "$userna:$uuid:$data" >/etc/.maAsiss/public_mode/${callback_query_from_id}/$userna
	        echo "$userna:$uuid $getDays Days TROJAN | ${callback_query_from_first_name}" >> /root/log-public
	fi

	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

trgo_publik() {
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} --message_id ${callback_query_message_message_id[$id]}
	func_limit_publik ${callback_query_from_id}
	r0=$(tr -dc a-zA-Z </dev/urandom | head -c5)
	r1=$(tr -dc 0-9 </dev/urandom | head -c3)
	userna=$(echo $r0$r1)
	passw=$r1
	getDays=$(grep -w "MAX_DAYS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
	data=$(date '+%d/%m/%C%y' -d " +$getDays days")
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

        # // Getting Trojan-go Tls
	export xtls="$(cat ~/log-install.txt | grep -w "TROJAN-GO WS TLS" | cut -d: -f2)";
	export xtls1="$(cat ~/log-install.txt | grep -w "TROJAN-GO WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

        # // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
        export uuid=$(cat /usr/local/etc/trojan-go/uuid.txt);

        # // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

	# // Create Trojan-go Account
	cat /usr/local/etc/trojan-go/config.json | jq '.password += ["'${user}'"]' >/tmp/trojango.txt && mv -f /tmp/trojango.txt /usr/local/etc/trojan-go/config.json && rm -rf /tmp/trojango.txt;
	echo -e "GO $user $exp" >> /usr/local/etc/xray/user.txt;

        # // Generate Link Trojan-go
        export trojanlink1="trojan-go://${user}@${domain}:${xtls1}?sni=bug.com&type=ws&host=${domain}&path=%2Ftrojan-go&encryption=none#${user}";

	# // Success create vless
        systemctl restart trojan-go.service
        source /usr/sbin/bot-style;
        trojango_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( trojango_cfg )

	if [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
	        mkdir -p /etc/.maAsiss/public_mode/${callback_query_from_id}
	        echo "$userna:$uuid:$data" >/etc/.maAsiss/public_mode/${callback_query_from_id}/$userna
	        echo "$userna:$uuid $getDays Days TRJ-GO | ${callback_query_from_first_name}" >> /root/log-public
	fi

	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

xray_publik() {
	ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} --message_id ${callback_query_message_message_id[$id]}
	func_limit_publik ${callback_query_from_id}
	r0=$(tr -dc a-zA-Z </dev/urandom | head -c5)
	r1=$(tr -dc 0-9 </dev/urandom | head -c3)
	userna=$(echo $r0$r1)
	passw=$r1
	getDays=$(grep -w "MAX_DAYS" "/etc/.maAsiss/public_mode/settings" | awk '{print $NF}')
	data=$(date '+%d/%m/%C%y' -d " +$getDays days")
	exp=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y-%m-%d)

	# // Getting Xray Tls Port
	export none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2)";
	export xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2)";
	export none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
	export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

	# // Getting Domain Pubkey Dan Uuid Xray
	export domain=$(cat /usr/local/etc/xray/domain);
	export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
	export pub_key=$(cat /etc/slowdns/server.pub);
	export uuid=$(xray uuid);

	# // Date && Expired
	export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`;
	export exp1=`date -d "$masaaktif days" +"%d-%m-%Y"`;

        # // Create Xray Xtls Account
	cat /usr/local/etc/xray/tcp/03_tcp.json | jq '.inbounds[0].settings.clients += [{"id": "'${uuid}'","flow": "xtls-rprx-vision","email": "'${user}'"}]' >/tmp/xtls.txt && mv -f /tmp/xtls.txt /usr/local/etc/xray/tcp/03_tcp.json && rm -rf /tmp/xtls.txt;
        cat /usr/local/etc/xray/tcp/03_tcp.json | jq '.inbounds[1,2].settings.clients += [{"id": "'${uuid}'","email": "'${user}'"}]' >/tmp/xtls.txt && mv -f /tmp/xtls.txt /usr/local/etc/xray/tcp/03_tcp.json && rm -rf /tmp/xtls.txt;
	cat /usr/local/etc/xray/tcp/03_tcp.json | jq '.inbounds[3].settings.clients += [{"password": "'${uuid}'","email": "'${user}'"}]' >/tmp/xtls.txt && mv -f /tmp/xtls.txt /usr/local/etc/xray/tcp/03_tcp.json && rm -rf /tmp/xtls.txt;
	echo -e "XTLS $user $exp $uuid" >> /usr/local/etc/xray/user.txt;

        # // Getting Link Client Xray Xtls
	export VMESSTCPTLS=$( echo -n "{ \"v\": \"0\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${xtls1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"tcp\",\"path\": \"/vmesstcp\",\"type\": \"http\",\"host\": \"bug.com\",\"tls\": \"tls\" }" | base64 -w 0 );
	export VMESSTCPNON=$( echo -n "{ \"v\": \"0\",\"ps\": \"${user}\",\"add\": \"${domain}\",\"port\": \"${none1}\",\"id\": \"${uuid}\",\"aid\": \"0\",\"net\": \"tcp\",\"path\": \"/vmesstcp\",\"type\": \"http\",\"host\": \"bug.com\",\"tls\": \"none\" }" | base64 -w 0 );
	export vmesslink1="vmess://${VMESSTCPTLS}";
	export vmesslinks1="vmess://${VMESSTCPNON}";
	export vlesslink2="vless://${uuid}@${domain}:${xtls1}?security=tls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-vision&sni=bug.com#${user}";
	export trojanlink3="trojan://${uuid}@${domain}:${xtls1}?type=tcp&flow=xtls-rprx-direct&sni=bug.com#${user}";
	export vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls&encryption=none&type=tcp&headerType=http&path=%2Fvlesstcp&sni=bug.com&host=bug.com#${user}";
	export vlesslinks4="vless://${uuid}@${domain}:${none1}?path=%2Fvlesstcp&encryption=none&type=tcp&headerType=http&host=bug.com#${user}";

	# // Succeas create account xtls
        systemctl restart xray@tcp.service
        source /usr/sbin/bot-style;
        tcpxtls_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

        local env_msg
        env_msg=$( tcpxtls_cfg )

	if [[ "${callback_query_from_id[$id]}" != "$Admin_ID" ]]; then
	        mkdir -p /etc/.maAsiss/public_mode/${callback_query_from_id}
	        echo "$userna:$uuid:$data" >/etc/.maAsiss/public_mode/${callback_query_from_id}/$userna
	        echo "$userna:$uuid $getDays Days VLESS | ${callback_query_from_first_name}" >> /root/log-public
	fi

	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
	    --text "$env_msg" \
	    --parse_mode html
	return 0
}

unset pub_menu
pub_menu=''
ShellBot.InlineKeyboardButton --button 'pub_menu' --line 1 --text '• VMESS •' --callback_data 'vmess'
ShellBot.InlineKeyboardButton --button 'pub_menu' --line 1 --text '• VLESS •' --callback_data 'vless'
ShellBot.InlineKeyboardButton --button 'pub_menu' --line 2 --text '• TROJAN •' --callback_data 'trojan'
ShellBot.InlineKeyboardButton --button 'pub_menu' --line 2 --text '• TROJANGO •' --callback_data 'trgo'
ShellBot.InlineKeyboardButton --button 'pub_menu' --line 3 --text '• SSH/OPENVPN •' --callback_data 'ssh'
ShellBot.InlineKeyboardButton --button 'pub_menu' --line 3 --text '• TCP XTLS •' --callback_data 'xray'

ShellBot.regHandleFunction --function ssh_publik --callback_data ssh
ShellBot.regHandleFunction --function vmess_publik --callback_data vmess
ShellBot.regHandleFunction --function vless_publik --callback_data vless
ShellBot.regHandleFunction --function trojan_publik --callback_data trojan
ShellBot.regHandleFunction --function trgo_publik --callback_data trgo
ShellBot.regHandleFunction --function xray_publik --callback_data xray


unset pub_menu1
pub_menu1="$(ShellBot.InlineKeyboardMarkup -b 'pub_menu')"
while :; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 35
    for id in $(ShellBot.ListUpdates); do
        (
            ShellBot.watchHandle --callback_data ${callback_query_data[$id]}
            [[ ${message_chat_type[$id]} != 'private' ]] && {
                   ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ only run this command on private chat / pm on bot")" \
                        --parse_mode html
                   >$CAD_ARQ
                   break
                   ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
            }
            CAD_ARQ=/tmp/cad.${message_from_id[$id]}
            echotoprice=/tmp/price
            if [[ ${message_entities_type[$id]} == bot_command ]]; then
                case ${message_text[$id]} in
                *)
                    :
                    comando=(${message_text[$id]})
                    [[ "${comando[0]}" = "/start" ]] && msg_welcome
                    [[ "${comando[0]}" = "/menu" ]] && menu_func
                    [[ "${comando[0]}" = "/info" ]] && about_server
                    [[ "${comando[0]}" = "/anonym" ]] && hantuu
                    [[ "${comando[0]}" = "/free" ]] && _if_public
                    [[ "${comando[0]}" = "/disable" ]] && echo "${message_text[$id]}" > /tmp/order && Disable_Order
                    ;;
                esac
            fi
            if [[ ${message_reply_to_message_message_id[$id]} ]]; then
                case ${message_reply_to_message_text[$id]} in
                '👤 CREATE USER 👤\n\nUsername:')
                    verifica_acesso
                    Saldo_CheckerSSH
                    if [[ "$_erro" != '1' ]]; then
                    if [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd | grep -w ${message_text[$id]} | wc -l)" != '0' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⚠️ User Already Exist..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ7
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Password:' \
                        --reply_markup "$(ShellBot.ForceReply)" # Força a resposta.
                    fi
                    ;;
                'Password:')
                    verifica_acesso
                    Saldo_CheckerSSH
                    if [[ "$_erro" != '1' ]]; then
                    echo "Password: ${message_text[$id]}" >>$CAD_ARQ
                    # Próximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                'Validity in days:')
                    verifica_acesso
                    Saldo_CheckerSSH
                    if [[ "$_erro" != '1' ]]; then
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    cret_user $CAD_ARQ
                    if [[ "(grep -w ${message_text[$id]} /etc/passwd)" = '0' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e ⛔ Error creating user !)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                        fi
			Login="$(awk -F " " '/Name/ {print $2}' $CAD_ARQ)"
			Pass="$(awk -F " " '/Password/ {print $2}' $CAD_ARQ)"
			exp2="$(awk -F " " '/Validity/ {print $2}' $CAD_ARQ)"
			# // Information port
		        export ssl=`cat ~/log-install.txt | grep -w "STUNNEL5" | cut -d: -f2`;
		        export ssh=`cat ~/log-install.txt | grep -w "OPENSSH" | cut -d: -f2 | cut -f1`;
		        export drop=`cat ~/log-install.txt | grep -w "DROPBEAR" | cut -d: -f2 | cut -f1`;
		        export wsnone=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET NONE" | cut -d: -f2  | cut -f1`;
		        export wstls=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET TLS" | cut -d: -f2 | cut -f1`;
		        export vpntcp=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $2,$3}'`;
		        export vpnudp=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $5,$6}'`;
		        export vpnssl=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $8,$9}'`;
		        export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

		        # // Dom && Date && Exp
		        export domain=$(cat /usr/local/etc/xray/domain);
		        export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
		        export pub_key=$(cat /etc/slowdns/server.pub);

		        # // Success create ssh
		        source /usr/sbin/bot-style;
		        ssh_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

		        local env_msg
		        env_msg=$( ssh_cfg )

                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$env_msg" \
                            --parse_mode html
                        break
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    Saldo_CheckerSSH2Month
                    if [[ "$_erro" != '1' ]]; then
                    2month_user $CAD_ARQ
                    if [[ "(grep -w ${message_text[$id]} /etc/passwd)" = '0' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e ⛔ Error creating user !)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                        fi

			Login="$(awk -F " " '/Name/ {print $2}' $CAD_ARQ)"
                        Pass="$(awk -F " " '/Password/ {print $2}' $CAD_ARQ)"
                        exp2="$(awk -F " " '/Validity/ {print $2}' $CAD_ARQ)"
                        # // Information port
                        export ssl=`cat ~/log-install.txt | grep -w "STUNNEL5" | cut -d: -f2`;
                        export ssh=`cat ~/log-install.txt | grep -w "OPENSSH" | cut -d: -f2 | cut -f1`;
                        export drop=`cat ~/log-install.txt | grep -w "DROPBEAR" | cut -d: -f2 | cut -f1`;
                        export wsnone=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET NONE" | cut -d: -f2  | cut -f1`;
                        export wstls=`cat ~/log-install.txt | grep -w "SSH WEBSOCKET TLS" | cut -d: -f2 | cut -f1`;
                        export vpntcp=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $2,$3}'`;
                        export vpnudp=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $5,$6}'`;
                        export vpnssl=`cat ~/log-install.txt | grep -w "OPENVPN" | cut -d: -f2 | cut -f1 | awk '{print $8,$9}'`;
			export xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";

                        # // Dom && Date && Exp
                        export domain=$(cat /usr/local/etc/xray/domain);
                        export ns_nya=$(cat /usr/local/etc/xray/nsdomain);
                        export pub_key=$(cat /etc/slowdns/server.pub);

                        # // Success create ssh
                        source /usr/sbin/bot-style;
                        ssh_cfg | sed 's/<code>//g' | sed 's/<\/code>//g' | tee -a /etc/manternet/log/account-${user}.txt;

			local env_msg
                        env_msg=$( ssh_cfg )

                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "$env_msg" \
                            --parse_mode html
                        break
                        fi
	                else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
	                fi
                    fi
                    ;;
                '⏳ Renew SSH ⏳\n\nUsername:')
                    verifica_acesso
                    Saldo_CheckerSSH
                    if [[ "$_erro" != '1' ]]; then
                    echo "${message_text[$id]}" >/tmp/name-d
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Input the days or date:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                'Input the days or date:')
                    verifica_acesso
                    Saldo_CheckerSSH
                    if [[ "$_erro" != '1' ]]; then
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9/]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "⛔ Error! Follow the example \nData format [EX: 30]" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    func_renew_ssh $(cat /tmp/name-d) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "━━━━━━━━━━━━━━━━━━━━━\n<b>✅ DATE CHANGED !</b> !\n━━━━━━━━━━━━━━━━━━━━━\n\n<b>Username:</b> $(cat /tmp/name-d)\n<b>New date:</b> $udata")" \
                        --parse_mode html
                    rm /tmp/name-d >/dev/null 2>&1
                else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Can't be more than 30 Days")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                      fi
                fi
                    ;;
                '🗑 REMOVE USER 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_ssh ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👥 ADD Reseller 👥\n\nEnter the name:')
                    verifica_acesso
                    echo "Name: ${message_text[$id]}" > $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'User token by generate:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'User token by generate:')
                    verifica_acesso
                    _VAR1=$(echo ${message_text[$id]} | sed -e 's/[^0-9]//ig'| rev)
                    if [[ ! -z $(grep -w "$_VAR1" "$User_Active" ) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Already Registered")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "${message_text[$id]}" >/tmp/scvpsss
                    echo "User: $_VAR1" >> $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Saldo:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Saldo:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⚠️ Use only numbers [EX: 100000]")" \
                            --parse_mode html
                        break
                    fi
                    echo "Saldo: ${message_text[$id]}" >> $CAD_ARQ
                    sleep 1
                    cret_res $CAD_ARQ
                    ;;
                '🗑 REMOVE Reseller 🗑\n\nInput Name of Reseller:')
                    echo -e "${message_text[$id]}" >$CAD_ARQ
                    _VAR12=$(grep -w "${message_text[$id]}" "$Res_Token")
                    if [[ -z $_VAR12 ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Token invalid")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    func_del_res $_VAR12
                    sed -i "/\b${message_text[$id]}\b/d" $Res_Token
                    break
                    ;;
                '💸 Topup Saldo 💸\n\nName reseller:')
                    verifica_acesso
                    cek_res_token=$(grep -w "${message_text[$id]}" "$Res_Token" | awk '{print $NF}' | sed -e 's/[^0-9]//ig'| rev)
                    echo $cek_res_token > /tmp/ruii
                    echo ${message_text[$id]} > /tmp/ruiix
                    if [[ -z $cek_res_token ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ No user found")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                 #   _VARSaldo=$(echo ${message_text[$id]} | sed -e 's/[^0-9]//ig'| rev)
                 #   echo -e "${message_text[$id]}" > /tmp/name-l
                 #   sed -i 's/^@//' /tmp/name-l
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Topup Saldo:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Topup Saldo:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⚠️ Use only numbers [EX: 100000]")" \
                            --parse_mode html
                        break
                    fi
                    func_topup_res $(cat /tmp/ruii) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "━━━━━━━━━━━━━━━━━\n  ✅ <b>Succesfully Topup !</b> ✅ !\n━━━━━━━━━━━━━━━━━\n<b>Name:</b> $(cat /tmp/ruiix) \n<b>Topup Saldo:</b> ${message_text[$id]}\n<b>Total Saldo Now:</b> $_TopUpSal \n━━━━━━━━━━━━━━━━━")" \
                        --parse_mode html
                    rm /tmp/ruii >/dev/null 2>&1 && rm /tmp/ruiix >/dev/null 2>&1
                    ;;
                '👤 CREATE TRIAL SSH 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_ssh_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER VMess 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'VMess Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'VMess Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_ray $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_ray2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '👤 CREATE TRIAL VMess 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_ray_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '🗑 REMOVE USER V2RAY 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_ray ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE USER Trojan 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Trojan Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Trojan Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_trojan $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_trojan2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER TROJAN 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_trojan ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE TRIAL Trojan 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_trojan_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER VLess 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'VLess Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'VLess Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_vless $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_vless2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER VLess 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_vless ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE TRIAL VLess 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_vless_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER WireGuard 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'WG Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'WG Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_wg $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_wg2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER WireGuard 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_wg ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE TRIAL WireGuard 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_wg_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER ShadowSocks 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'SS Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'SS Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_ss $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_ss2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER ShadowSocks 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_ss ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE TRIAL ShadowSocks 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_ss_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER Shadowsocks-R 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'SSR Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'SSR Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_ssr $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_ssr2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER Shadowsocks-R 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_ssr ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE TRIAL Shadowsocks-R 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_ssr_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER Trojan-GO 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'TRGo Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'TRGo Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_trgo $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 60)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_trgo2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 60 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER Trojan-GO 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_trgo ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '👤 CREATE TRIAL Trojan-GO 👤\n\nHow many hours should it last ? EX: 1:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    if [[ "${message_from_id[$id]}" != "$Admin_ID" ]]; then
                        user_on=$(ls /etc/.maAsiss/db_reseller/${message_from_id}/trial-fold)
                        func_verif_limite_res ${message_from_id}
                        if [[ "$_result" -ge "$_limTotal" ]]; then
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "⛔ Max Limit Create Trial only $_limTotal Users\n\nYou Still Have User Active : $user_on" \
                                --parse_mode html
                            break
                            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                 --text "Func Error Do Nothing" \
                                 --reply_markup "$(ShellBot.ForceReply)"
                        fi
                    fi
                    if ((${message_text[$id]} == 1 || ${message_text[$id]} == 2)); then
                        func_add_trgo_trial ${message_text[$id]}
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Trial Max Hours only 1-2")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    ;;
                '👤 CREATE USER Xray 👤\n\nUsername:')
                    verifica_acesso
                    if [ "${message_text[$id]}" == 'root' ]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ INVALID USER")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sizemax=$(echo -e ${#message_text[$id]})
                    if [[ "$sizemax" -gt '10' ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use no maximum 10 characters [EX: KennXV]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    fi
                    user_already_exist ${message_text[$id]}
                    echo "Name: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Xray Validity in days: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Xray Validity in days:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                if ((${message_text[$id]} >= 1 && ${message_text[$id]} <= 30)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_xray $CAD_ARQ
                elif ((${message_text[$id]} >= 30 && ${message_text[$id]} <= 1000)); then
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validity: $info_data" >>$CAD_ARQ
                    func_add_xray2 $CAD_ARQ
                else
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$(echo -e "⛔ Can't be more than 1000 Days")" \
                        --parse_mode html
                    >$CAD_ARQ
                    break
                    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                        --text "Func Error Do Nothing" \
                        --reply_markup "$(ShellBot.ForceReply)"
                fi
                    ;;
                '🗑 REMOVE USER Xray 🗑\n\nUsername:')
                    verifica_acesso
                    func_del_xray ${message_text[$id]}
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully removed.* 🚮" \
                        --parse_mode markdown
                    ;;
                '💰 Change Price 💰\n\nPrice SSH:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        >$echotoprice
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price SSH : ${message_text[$id]}" >$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price VMess:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price VMess:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price VMess : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price VLess:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price VLess:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price VLess : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price Trojan:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price Trojan:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price Trojan : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price TrojanGO:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price TrojanGO:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price Trojan-GO : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price Wireguard:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price Wireguard:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price Wireguard : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price Shadowsocks:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price Shadowsocks-R:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price Shadowsocks-R : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Price SSTP:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Price Xray:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "Price Xray : ${message_text[$id]}" >>$echotoprice
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully Updated Price List* ✅" \
                        --parse_mode markdown
                    mv /tmp/price /etc/.maAsiss/
                    ;;
                '📢 Info for reseller 📢\n\ntype your information:')
                    verifica_acesso
                    echo "${message_text[$id]}" > /etc/.maAsiss/update-info
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Successfully Added Information* ✅" \
                        --parse_mode markdown
                    ;;
                '🌀 Reset Saldo Reseller 🌀\n\nInput Name of Reseller:')
                    verifica_acesso
                    _VAR14=$(grep -w "${message_text[$id]}" "$Res_Token")
                    if [[ -z $_VAR14 ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "No username found 🔴")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo $_VAR14 > /tmp/resSaldo
                    func_reset_saldo_res
                    ;;
                '🌐 Enable Public Mode 🌐\n\nExpired Days [ex:3]:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        >$echotoprice
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "MAX_DAYS : ${message_text[$id]}" > /etc/.maAsiss/public_mode/settings
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Max User [ex:10]:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Max User [ex:10]:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 1000]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    echo "MAX_USERS : ${message_text[$id]}" >> /etc/.maAsiss/public_mode/settings
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                          --text "Succesfully enable public mode√\n\nShare your bot and tell everyones to type /free" \
                          --parse_mode html
                    ;;
                '😤 Unblock user 😤\n\nInput user ID to unblock:')
                    verifica_acesso
                    if [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "⛔ Use only numbers [EX: 100938380]")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    _VA4=$(grep -w "${message_text[$id]}" "/etc/.maAsiss/user_flood")
                    if [[ -z $_VA4 ]]; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "ID not found 🔴")" \
                            --parse_mode html
                        break
                        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                            --text "Func Error Do Nothing" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    fi
                    sed -i "/^${message_text[$id]}/d" "/etc/.maAsiss/user_flood"
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                          --text "Succesfully unblock user id <b>${message_text[$id]}</b>" \
                          --parse_mode html
                    ;;
                esac
            fi
        ) &
    done
done
