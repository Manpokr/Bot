#!/bin/bash
# // Exporting maklumat rangkaian
source /root/ip-detail.txt;
export ip_nya="$IP";
export isp_nya="$ISP";
export region_nya="$REGIONAME";
export region_nya="$REGION";
export country_nya="$COUNTRY";

source /etc/os-release;
export tipe_nya=$NAME

source /etc/.maAsiss/.Shellbtsss
get_Token=$(sed -n '1 p' /root/ResBotAuth | cut -d' ' -f2)
get_AdminID=$(sed -n '2 p' /root/ResBotAuth | cut -d' ' -f2)
get_botName=$(sed -n '1 p' /root/multi/bot.conf | cut -d' ' -f2)
get_limituser=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
nameStore=$(grep -w "store_name" /root/multi/bot.conf | awk '{print $NF}')
res_price=5

ShellBot.init --token $get_Token --monitor --return map --flush --log_file /root/log_bot

function line() {
        case $1 in
        "line1")
        msg="━━━━━━━━━━━━━━━━━━━━━━━\n"
        ;;
        "line2")
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
        ;;
	"line3")
        msg="──────────────────────────────\n"
        ;;
        "line4")
        msg+="──────────────────────────────\n"
       ;;
       esac
}

function logo() {
        case $1 in
       "logo1")
       line line1
       msg+="<b>      🌀 PANEL MENU ADMIN 🌀</b>\n"
       line line2
       ;;
       "logo2")
       line line1
       msg+="<b>      🌀 PANEL MENU RESELLER 🌀</b>\n"
       line line2
       ;;
       "logo3")
       line line3
       msg+="<b>  ⚡ SSHVPN ACCOUNT ⚡</b>\n"
       line line4
       ;;
       esac
}

msg_welcome() {
    if [ "${message_from_id[$id]}" == "$get_AdminID" ]; then
    oribal=$(grep ${message_from_id} /root/multi/reseller | awk '{print $2}')
    source /root/ip-detail.txt;
    source /etc/os-release;
    ip_nya="$IP";
    isp_nya="$ISP";
    country_nya="$COUNTRY";
    tipe_nya=$NAME;
    dom_nya=$(cat /usr/local/etc/xray/domain);
    # // Getting User Information
    vl_nya=$(cat /usr/local/etc/xray/user.txt | grep "^VL " | wc -l);
    vm_nya=$(cat /usr/local/etc/xray/user.txt | grep "^VM " | wc -l);
    xt_nya=$(cat /usr/local/etc/xray/user.txt | grep "^XTLS " | wc -l);
    tr_nya=$(cat /usr/local/etc/xray/user.txt | grep "^TR " | wc -l);
    ss_nya=$(cat /usr/local/etc/xray/user.txt | grep "^SS " | wc -l);
    trgo_nya=$(cat /usr/local/etc/xray/user.txt | grep "^GO " | wc -l);
    wg_nya=$(cat /etc/wireguard/wg0.conf | grep "^### Client" | wc -l);
    ssh_nya="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)";
    # // Getting Ram Information
    total_ram="$( free -m | awk 'NR==2 {print $2}' )";
    uram_nya="$( free -m | awk 'NR==2 {print $3}' )";
    uram_nya+=" Mb";
    total_ram+=" Mb";
    # // Getting CPU Information
    cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
    cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
    cpu_usage+=" %"
        local msg
	logo logo1
	msg+="<code>⚡ OS        = $tipe_nya\n"
        msg+="⚡ ISP       = $isp_nya\n"
        msg+="⚡ CITY      = $country_nya\n"
	msg+="⚡ USE RAM   = $uram_nya\n"
        msg+="⚡ TOTAL RAM = $total_ram\n"
	msg+="⚡ CPU USE   = $cpu_usage\n"
        msg+="⚡ IP VPS    = $ip_nya\n"
	msg+="⚡ DOMAIN    = $dom_nya</code>\n\n"
        msg+="<code>Total Created : account\n\n"
        msg+="⚡ SSH-VPN      = $ssh_nya account\n"
	msg+="⚡ XRAY XTLS    = $xt_nya account\n"
	msg+="⚡ VLESS        = $vl_nya account\n"
        msg+="⚡ VMESS        = $vm_nya account\n"
	msg+="⚡ TROJAN       = $tr_nya account\n"
        msg+="⚡ SHADOWSOCK22 = $ss_nya account\n"
	msg+="⚡ TROJAN-GO    = $trgo_nya account\n"
        msg+="⚡ WIREGUARD    = $wg_nya account</code>\n"
        line line2
        msg+="     ✨ WELCOME $nameStore ✨\n"
	line line2

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
	    
    elif [ "$(grep -wc ${message_from_id} /root/multi/reseller)" != '0' ]; then
        local msg
	logo logo2
	msg+="<code>⚡ OS        = $tipe_nya\n"
        msg+="⚡ ISP       = $isp_nya\n"
        msg+="⚡ CITY      = $country_nya\n"
	msg+="⚡ USE RAM   = $uram_nya MB\n"
        msg+="⚡ TOTAL RAM = $total_ram MB\n"
	msg+="⚡ CPU USE   = $cpu_usage\n"
        msg+="⚡ IP VPS    = $ip_nya\n"
	msg+="⚡ DOMAIN    = $dom_nya</code>\n\n"
        msg+="<code>Total Created : account\n\n"
        msg+="⚡ SSH-VPN      = $ssh_nya account\n"
	msg+="⚡ XRAY XTLS    = $xt_nya account\n"
	msg+="⚡ VLESS        = $vl_nya account\n"
        msg+="⚡ VMESS        = $vm_nya account\n"
	msg+="⚡ TROJAN       = $tr_nya account\n"
        msg+="⚡ SHADOWSOCK22 = $ss_nya account\n"
	msg+="⚡ TROJAN-GO    = $trgo_nya account\n"
        msg+="⚡ WIREGUARD    = $wg_nya account</code>\n"
        line line2
        msg+="⚡ YOUR NAME STORE = $nameStore\n"
        msg+="⚡ YOUR ID         = <code>${message_from_id}</code>\n"
        msg+="⚡ YOUR BALANCE IS = $oribal"
	line line2
 
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard5" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "⛔ ACCESS DENY ⛔\n\nTHIS IS YOUR ID = <code>${message_from_id}</code>\n" \
            --parse_mode html
    fi
}

backReq() {
    oribal=$(grep ${callback_query_from_id} /root/multi/reseller | awk '{print $2}')
    if [ "${callback_query_from_id[$id]}" == "$get_AdminID" ]; then
    source /root/ip-detail.txt;
    source /etc/os-release;
    ip_nya="$IP";
    isp_nya="$ISP";
    country_nya="$COUNTRY";
    tipe_nya=$NAME
    dom_nya=$(cat /usr/local/etc/xray/domain);
    # // Getting User Information
    vl_nya=$(cat /usr/local/etc/xray/user.txt | grep "^VL " | wc -l);
    vm_nya=$(cat /usr/local/etc/xray/user.txt | grep "^VM " | wc -l);
    xt_nya=$(cat /usr/local/etc/xray/user.txt | grep "^XTLS " | wc -l);
    tr_nya=$(cat /usr/local/etc/xray/user.txt | grep "^TR " | wc -l);
    ss_nya=$(cat /usr/local/etc/xray/user.txt | grep "^SS " | wc -l);
    trgo_nya=$(cat /usr/local/etc/xray/user.txt | grep "^GO " | wc -l);
    wg_nya=$(cat /etc/wireguard/wg0.conf | grep "^### Client" | wc -l);
    ssh_nya="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)";
    # // Getting Ram Information    # // Getting Ram Information
    total_ram="$( free -m | awk 'NR==2 {print $2}' )";
    uram_nya="$( free -m | awk 'NR==2 {print $3}' )";
    uram_nya+=" Mb";
    total_ram+=" Mb";
    # // Getting CPU Information
    cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
    cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
    cpu_usage+=" %"
	local msg
        logo logo1
	msg+="<code>⚡ OS        = $tipe_nya\n"
        msg+="⚡ ISP       = $isp_nya\n"
        msg+="⚡ CITY      = $country_nya\n"
	msg+="⚡ USE RAM   = $uram_nya MB\n"
        msg+="⚡ TOTAL RAM = $total_ram MB\n"
	msg+="⚡ CPU USE   = $cpu_usage\n"
        msg+="⚡ IP VPS    = $ip_nya\n"
	msg+="⚡ DOMAIN    = $dom_nya</code>\n\n"
        msg+="<code>Total Created : account\n\n"
        msg+="⚡ SSH-VPN      = $ssh_nya account\n"
	msg+="⚡ XRAY XTLS    = $xt_nya account\n"
	msg+="⚡ VLESS        = $vl_nya account\n"
        msg+="⚡ VMESS        = $vm_nya account\n"
	msg+="⚡ TROJAN       = $tr_nya account\n"
        msg+="⚡ SHADOWSOCK22 = $ss_nya account\n"
	msg+="⚡ TROJAN GO    = $trgo_nya account\n"
	msg+="⚡ WIREGUARD    = $wg_nya account</code>\n"
        line line2
        msg+="     ✨ WELCOME $nameStore ✨\n"
	line line2
	
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
	    
    elif [ "$(grep -wc ${callback_query_from_id} /root/multi/reseller)" != '0' ]; then
        local msg
        logo logo2
	msg+="<code>⚡ OS        = $tipe_nya\n"
        msg+="⚡ ISP       = $isp_nya\n"
        msg+="⚡ CITY      = $country_nya\n"
	msg+="⚡ USE RAM   = $uram_nya MB\n"
        msg+="⚡ TOTAL RAM = $total_ram MB\n"
	msg+="⚡ CPU USE   = $cpu_usage\n"
        msg+="⚡ IP VPS    = $ip_nya\n"
	msg+="⚡ DOMAIN    = $dom_nya</code>\n\n"
        msg+="<code>Total Created : account\n\n"
        msg+="⚡ SSH-VPN      = $ssh_nya account\n"
	msg+="⚡ XRAY XTLS    = $xt_nya account\n"
	msg+="⚡ VLESS        = $vl_nya account\n"
        msg+="⚡ VMESS        = $vm_nya account\n"
	msg+="⚡ TROJAN       = $tr_nya account\n"
        msg+="⚡ SHADOWSOCK22 = $ss_nya account\n"
	msg+="⚡ TROJAN-GO    = $trgo_nya account\n"
        msg+="⚡ WIREGUARD    = $wg_nya account</code>\n"
        line line2
        msg+="⚡ YOUR NAME STORE = $nameStore\n"
        msg+="⚡ YOUR ID         = <code>${message_from_id}</code>\n"
        msg+="⚡ YOUR BALANCE IS = $oribal"
	line line2
 
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard5" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENY ⛔\n\nTHIS IS YOUR ID = <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
    fi
}

back_ser() {
    oribal=$(grep ${callback_query_from_id} /root/multi/reseller | awk '{print $2}')
    if [ "${callback_query_from_id[$id]}" == "$get_AdminID" ]; then
        local msg
        msg="👨‍🔧 Menu Service 👨‍🔧\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboardxr" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENY ⛔\n\nTHIS IS YOUR ID = <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
    fi
}


freeReq() {
    if [ "$(cat /root/multi/public)" == "on" ]; then
        local msg
        msg+="SELECT AN OPTION BELOW =\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard3" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "📴 FREE FUNCTION IS OFFLINE 📴\n" \
            --parse_mode html
    fi
}

claimVoucher() {
    msg="Hi ${message_from_first_name}\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboard7" \
        --parse_mode html
}

menu_ser() {
    local msg
    msg="👨‍🔧 MENU SERVICE 👨‍🔧\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardxr" \
        --parse_mode html
}

menuRes() {
    local msg
    msg="🫂 MENU RESELLER 🫂${callback_query_from_first_name}\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboard6" \
        --parse_mode html
}

publicReq() {
    limituser=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
    if [ "$(cat /root/multi/public)" == "off" ]; then
        echo "on" >/root/multi/public
        echo "" >/root/multi/claimed
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "✅ PUBLIC MODE IS ONLINE ✅\n\n LIMIT IS $limituser ✅"
    else
        echo "off" >/root/multi/public
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ PUBLIC MODE IS OFFLINE ⛔\n\n LIMIT IS $limituser ⛔"
    fi
}

req_voucher() {
    file_user=$1
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        echo "voucher"
    elif [ "${coupon}" == "free" ]; then
        if [ "$(cat /root/multi/public)" != "on" ]; then
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "📴 PUBLIC MODE IS OFFLINE 📴\n" \
                --parse_mode html
            exit 1
        else
            echo "free"
        fi
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "ALREADY CLAIMED ✅\n" \
            --parse_mode html
        exit 1
    fi
}

req_url() {
    ori=$(grep ${callback_query_from_id} /root/multi/reseller | awk '{print $2}')
    if [[ ${callback_query_data[$id]} == _addvmess ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vmess 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _addvless ]]; then
       ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
       ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vless 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _addxtls ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Xtls 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _addtrojan ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Trojan 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _voucherOVPN ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User ssh-vpn 👤\n\n( Username Expired ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
     elif [[ ${callback_query_data[$id]} == _addss ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Shadowaock22 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    fi
}

req_free() {
    if [[ ${callback_query_data[$id]} == _freevmess ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vmess free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _freevless ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vless free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _freextls ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Xtls free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _freetrojan ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Trojan free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
    elif [[ ${callback_query_data[$id]} == _freetrojango ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Trojan-Go free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
	    
     elif [[ ${callback_query_data[$id]} == _freess ]]; then
        ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
	ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Shadowsock22 free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    fi

}

req_limit() {
    limituser=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
    total=$(wc -l /usr/local/etc/xray/user.txt | cut -d' ' -f1)
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    ori=$(grep ${message_from_id} multi/reseller | awk '{print $2}')
    if [ "${message_from_id[$id]}" == "$get_AdminID" ]; then
        echo ""
    elif [ "$(grep -wc ${message_from_id} /root/multi/reseller)" != '0' ]; then
        echo "reseller"
    elif [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        echo "voucher"
    elif [ "$(grep -wc ${message_from_id[$id]} /root/multi/claimed)" != '0' ]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "ALREADY REDEEM" \
            --parse_mode html
        exit 1
    elif (($total >= $limituser)); then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "FULLY REDEEM" \
            --parse_mode html
        exit 1
    else
        echo "${message_from_id[$id]}" >>/root/multi/claimed
    fi
}

freelimitReq() {
    limituser=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "YOUR CURRENT FREE LIMIT IS: $limituser" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📝 Change Limit Config 📝\n\n( example =1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}


generatorReq() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗓️ Voucher Validity 🗓️\n\n( days=1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

voucher_req() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🏷️ Input Your Voucher 🏷️ :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

resellerReq() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🫂 Create Reseller 🫂 :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

balRes() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "💰 Add Balance Reseller 💰 :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

allRes() {
    result=$(cat /root/multi/reseller)
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━\n 🟢 Reseller 🟢 \n━━━━━━━━━━━━━━━━━━━━━\n$result\n━━━━━━━━━━━━━━━━━━━━━\n" \
        --reply_markup "$keyboard6" \
        --parse_mode html
}

delRes() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑️ Delete Reseller 🗑️ :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

reseller_input() {
    file_user=$1
    User=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    Balance=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${User} /root/multi/reseller)" = '0' ]; then
        echo "$User $Balance" >>/root/multi/reseller
        local msg
        msg="Successful Register Reseller\n\n"
        msg+="$User Balance Is $Balance"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
        ShellBot.sendMessage --chat_id ${User} \
            --text "$msg" \
            --reply_markup "$keyboard5" \
            --parse_mode html
    else
        local msg
        msg="Already Registered Reseller\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
    fi
}

balance_reseller() {
    file_user=$1
    User=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    Balance=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    ori=$(grep ${User} /root/multi/reseller | awk '{print $2}')
    topup=$(($ori + $Balance))
    sed -i "/${User}/d" /root/multi/reseller
    echo "${User} $topup" >>/root/multi/reseller
    if [ "$(grep -wc ${User} /root/multi/reseller)" != '0' ]; then
        local msg
        msg="$User NEW BALANCE IS $topup\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard6" \
            --parse_mode html
    else
        msg="$User IS NOT RESELLER\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard6" \
            --parse_mode html
    fi
}

delete_reseller() {
    file_user=$1
    User=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${User} /root/multi/reseller)" != '0' ]; then
        sed -i "/${User}/d" /root/multi/reseller
        msg="$User SUCCESSFUL DELETED ✅\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard6" \
            --parse_mode html
    else
        msg="$User IS NOT RESELLER\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard6" \
            --parse_mode html
    fi
}

reseller_balance() {
    ori=$(grep ${message_from_id} /root/multi/reseller | awk '{print $2}')
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" != '0' ]; then
        if (($ori < $res_price)); then
            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                --text "BAKI TIDAK MENCUKUPI\n\nYOUR BALANCE : RM $ori\n" \
                --reply_markup "$keyboard5" \
                --parse_mode html
            exit 1
        elif (($ori >= $res_price)); then
            topup=$(($ori - $res_price))
            sed -i "/${message_from_id}/d" /root/multi/reseller
            echo "${message_from_id} $topup" >>/root/multi/reseller
        fi
    else
        echo "admin"
    fi
}

speed_test() {
    [[ "${callback_query_from_id[$id]}" != "$get_AdminID" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e ⛔ ACCESS DENIED ⛔)"
        return 0
    }
    rm -rf $HOME/speed >/dev/null 2>&1
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "🚀 PLEASE WAIT IN 10 SEC 🚀"
    speedtest -v >speed
    isp=$(cat speed | sed -n '5 p' | awk -F : {'print $NF'})
    png=$(cat speed | sed -n '6 p' | a-wk -F : {'print $2,$3'})
    down=$(cat speed | sed -n '7 p' | awk -F : {'print $2,$3'})
    upl=$(cat speed | sed -n '8 p' | awk -F : {'print $2,$3'})
    lost=$(cat speed | sed -n '9 p' | awk -F : {'print $2'})
    lnk=$(cat speed | sed -n '10 p' | awk {'print $NF'})
   
    local msg
    line line1;
    msg+="<b>      🚀 SPEEDTEST SERVER 🚀</b>\n"
    line line2;
    msg+="<code>Isp         = $isp\n"
    msg+="Ping/Jitter = $png\n"
    msg+="Download    = $down\n"
    msg+="Upload      = $upl\n"
    msg+="Packet Loss = $lost</code>\n\n"
    line line2;
    
    ShellBot.sendMessage --chat_id $get_AdminID \
        --text "$(echo -e $msg)" \
        --parse_mode html
    ShellBot.sendMessage --chat_id $get_AdminID \
        --text "$(echo -e $lnk)" \
        --parse_mode html
    rm -rf $HOME/speed >/dev/null 2>&1
    return 0
}

###############-SSH-VPN-ALL-############
menu_ssh() {
    local msg
    msg="SELECT AN OPTION BELOW =\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboard4" \
        --parse_mode html
}

add_ssh() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create User ssh-vpn 👤\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

del_ssh() {    
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/ssh/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/ssh/user.txt | grep -E "^SSH " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/ssh/user.txt | grep -E "^SSH " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE SSHVPN ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User ssh-vpn 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

ext_ssh() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/ssh/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/ssh/user.txt | grep -E "^SSH " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/ssh/user.txt | grep -E "^SSH " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW SSHVPN ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User ssh-vpn 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

del_exp() {
    hariini=$(date +%d-%m-%Y)
    cat /etc/shadow | cut -d: -f1,8 | sed /:$/d >/tmp/expirelist.txt
    totalaccounts=$(cat /tmp/expirelist.txt | wc -l)
    for ((i = 1; i <= $totalaccounts; i++)); do
        tuserval=$(head -n $i /tmp/expirelist.txt | tail -n 1)
        username=$(echo $tuserval | cut -f1 -d:)
        userexp=$(echo $tuserval | cut -f2 -d:)
        userexpireinseconds=$(($userexp * 86400))
        tglexp=$(date -d @$userexpireinseconds)
        tgl=$(echo $tglexp | awk -F" " '{print $3}')
        while [ ${#tgl} -lt 2 ]; do
            tgl="0"$tgl
        done
        while [ ${#username} -lt 15 ]; do
            username=$username" "
        done
        bulantahun=$(echo $tglexp | awk -F" " '{print $2,$6}')
        echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >>/usr/local/bin/alluser
        todaystime=$(date +%s)
        if [ $userexpireinseconds -ge $todaystime ]; then
            :
        else
            echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >>/usr/local/bin/deleteduser
            echo "Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini"
	    userdel $username
            sed -i "/\b$username\b/d" /usr/local/etc/ssh/user.txt
        fi
    done
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "SUCCESS REMOVE EXPIRED USER ✅\n" \
        --parse_mode html

}

input_addssh() {
    file_user=$1
    req_limit
    Login=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    Pass=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
        masaaktif=$(sed -n '3 p' $file_user | cut -d' ' -f1)
    else
        masaaktif=30
    fi
    if grep -E "^SSH $Login" /usr/local/etc/ssh/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    masaaktif=$(sed -n '3 p' $file_user | cut -d' ' -f1)
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
    exp1=`date -d "$masaaktif days" +"%Y-%m-%d"`
    exp2=`date -d "$masaaktif days" +"%d-%m-%Y"`
    udp-nya() {
    if [ -r /usr/local/etc/udp/ ]; then
       msg+="<code>Ssh Udp     = 1-65350</code>\n"
       msg+="<code>Openvpn Tcp = ${ovpn}</code>\n"  
       export udp="━━━━━━━━━━━━━━━━━━━━━━━\n<code>SSH UDP-CUSTOM LINK</code>\n<code> ${domain}:1-65350@${Login}:${Pass}</code>\n\n"
    else
       msg+="<code>Openvpn Tcp = ${ovpn}</code>\n"
       msg+="<code>Openvpn Udp = ${ovpn1}</code>\n"  
       export link="<code>Openvpn Udp = http://${ip_nya}:85/client-udp.ovpn</code>\n"
    fi
    }
    
    echo -e "SSH $Login $exp1" >> /usr/local/etc/ssh/user.txt;

    useradd -e $(date -d "$masaaktif days" +"%Y-%m-%d") -s /bin/false -M $Login
    exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
    echo -e "$Pass\n$Pass\n" | passwd $Login &>/dev/null
    
    local msg
    logo logo3
   # msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>  (✷‿✷) SSHVPN ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Myip        = ${ip_nya}\n"
    msg+="Subdomain   = ${domain}\n"
    msg+="Username    = ${Login}\n"
    msg+="Password    = ${Pass}</code>\n"
    line line3
    msg+="<code>Openssh     = ${ssh}\n"
    msg+="Dropbear    = ${drop}\n"
    msg+="Ssl-tls     =${ssl}</code>\n"
    udp-nya
    msg+="<code>Openvpn Ssl = ${ovpn2}\n"
    msg+="Ssh Ws      = ${wsnone}\n"
    msg+="Ssh Ws Tls  = ${wstls}\n"
    msg+="Ovpn Ws     = ${wsnone}\n"
    msg+="Ovpn Ws Tls = ${wstls}</code>\n"
    line line3
    msg+="<code>Openvpn Tcp = http://${ip_nya}:85/client-tcp.ovpn</code>\n"
    msg+="$link"
    msg+="<code>Openvpn Ssl = http://${ip_nya}:85/client-ssl.ovpn</code>\n"
    msg+="<code>Badvpn      = 7100-7900</code>\n"
    line line3
    msg+="<code>Slow Dns Port (PORT) = ${xtls1}\n"
    msg+="Name Server   (NS)   = ${ns_nya}\n"
    msg+="Public Key    (KEY)  = ${pub_key}</code>\n"
    msg+="$udp"
    line line3
    msg+="PAYLOAD WS\n"
    msg+=" <code>GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]</code>\n"
    msg+="\n"
    line line3
    msg+="PAYLOAD WS TLS\n"
    msg+=" <code>GET wss://bug.com [protocol][crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]</code>\n"
    msg+="\n"
    line line3
    msg+="<code>Expired On    = $exp2</code>"
 
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}

input_delssh() {
    file_user=$1
    Pengguna=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^SSH $Pengguna" /usr/local/etc/ssh/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/ssh/user.txt | grep -w "$Pengguna" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/ssh/user.txt | grep -w "$Pengguna" | awk '{print $3}')"
    
    if getent passwd $user >/dev/null 2>&1; then
        userdel $user
	sed -i "/\b$user\b/d" /usr/local/etc/ssh/user.txt
 
	local msg
        msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE USER SSHVPN▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="<code>User ( ${user} ${exp} ) Has Been Removed ! </code>\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
      
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

input_extssh() {
    file_user=$1
    User=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    Days=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^SSH $User" /usr/local/etc/ssh/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/ssh/user.txt | grep -w "$User" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/ssh/user.txt | grep -w "$User" | awk '{print $3}')"
    egrep "^$user" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        Today=$(date +%s)
        Days_Detailed=$(($Days * 86400))
        Expire_On=$(($Today + $Days_Detailed))
        Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
        Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
        now=$(date +%Y-%m-%d);
        d1=$(date -d "$exp" +%s);
        d2=$(date -d "$now" +%s);
        exp2=$(( (d1 - d2) / 86400 ));
        exp3=$(($exp2 + $Days));
        exp4=`date -d "$exp3 days" +"%Y-%m-%d"`

	passwd -u $user
        usermod -e $Expiration $user
        egrep "^$user" /etc/passwd >/dev/null
        echo -e "$Pass\n$Pass\n" | passwd $user &>/dev/null
        sed -i "s/SSH $user $exp/SSH $user $exp4/g" /usr/local/etc/ssh/user.txt

        local msg
        msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW USER SSHVPN▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="User ( ${User} ) Renewed Then Expired On ( $exp4 ) Days Added ( $Days Days )\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
	
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

req_ovpn() {
    file_user=$1
    Login=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    Pass=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c3)
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    masaaktif=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    req_voucher $file_user
    req_limit
    if grep -E "^SSH $Login" /usr/local/etc/ssh/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
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
    exp1=`date -d "$masaaktif days" +"%Y-%m-%d"`
    exp2=`date -d "$masaaktif days" +"%d-%m-%Y"`
    udp-nya() {
    if [ -r /usr/local/etc/udp/ ]; then
       msg+="<code>Ssh Udp     = 1-65350</code>\n"
       msg+="<code>Openvpn Tcp = ${ovpn}</code>\n"  
       export udp="━━━━━━━━━━━━━━━━━━━━━━━\n<code>SSH UDP-CUSTOM LINK</code>\n<code> ${domain}:1-65350@${Login}:${Pass}</code>\n\n"
    else
       msg+="<code>Openvpn Tcp = ${ovpn}</code>\n"
       msg+="<code>Openvpn Udp = ${ovpn1}</code>\n"  
       export link="<code>Openvpn Udp = http://${ip_nya}:85/client-udp.ovpn</code>\n"
    fi
    }
    echo -e "SSH $Login $exp1" >> /usr/local/etc/ssh/user.txt;

    useradd -e $(date -d "$masaaktif days" +"%Y-%m-%d") -s /bin/false -M $Login
    exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
    echo -e "$Pass\n$Pass\n" | passwd $Login &>/dev/null
    
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>  (✷‿✷) SSHVPN ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Myip        = ${ip_nya}\n"
    msg+="Subdomain   = ${domain}\n"
    msg+="Username    = ${Login}\n"
    msg+="Password    = ${Pass}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Openssh     = ${ssh}\n"
    msg+="Dropbear    = ${drop}\n"
    msg+="Ssl-tls     =${ssl}</code>\n"
    udp-nya
    msg+="<code>Openvpn Ssl = ${ovpn2}\n"
    msg+="Ssh Ws      = ${wsnone}\n"
    msg+="Ssh Ws Tls  = ${wstls}\n"
    msg+="Ovpn Ws     = ${wsnone}\n"
    msg+="Ovpn Ws Tls = ${wstls}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Openvpn Tcp = http://${IP_NYA}:85/client-tcp.ovpn</code>\n"
    msg+="$link"
    msg+="<code>Openvpn Ssl = http://${IP_NYA}:85/client-ssl.ovpn</code>\n"
    msg+="<code>Badvpn      = 7100-7900</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slow Dns Port (PORT) = ${xtls1}\n"
    msg+="Name Server   (NS)   = ${ns_nya}\n"
    msg+="Public Key    (KEY)  = ${pub_key}</code>\n"
    msg+="$udp"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="PAYLOAD WS\n"
    msg+="<code>GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="PAYLOAD WS TLS\n"
    msg+="<code>GET wss://bug.com [protocol][crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp2</code>"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menu4
menu4=''
ShellBot.InlineKeyboardButton --button 'menu4' --line 1 --text 'CREATE USER' --callback_data '_addssh'
ShellBot.InlineKeyboardButton --button 'menu4' --line 2 --text 'DELETE USER' --callback_data '_delssh'
ShellBot.InlineKeyboardButton --button 'menu4' --line 2 --text 'DELETE EXPIRED' --callback_data '_delexp'
ShellBot.InlineKeyboardButton --button 'menu4' --line 3 --text 'EXTEND USER' --callback_data '_extssh'
ShellBot.InlineKeyboardButton --button 'menu4' --line 3 --text 'VOUCHER SSH-VPN' --callback_data '_voucherOVPN'
ShellBot.InlineKeyboardButton --button 'menu4' --line 4 --text '🔙 BACK 🔙' --callback_data '_back4'
ShellBot.regHandleFunction --function add_ssh --callback_data _addssh
ShellBot.regHandleFunction --function del_ssh --callback_data _delssh
ShellBot.regHandleFunction --function del_exp --callback_data _delexp
ShellBot.regHandleFunction --function ext_ssh --callback_data _extssh
ShellBot.regHandleFunction --function req_url --callback_data _voucherOVPN
ShellBot.regHandleFunction --function backReq --callback_data _back4
unset keyboard4
keyboard4="$(ShellBot.InlineKeyboardMarkup -b 'menu4')"

##################-VMESS-ALL-MENU-#######

menu_vmess() {
    local msg
    msg="SELECT AN OPTION BELOW =\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardvm" \
        --parse_mode html
}

vmess_del() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VM " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^VM " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE VMESS ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Vmess 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

vmess_ext() {    
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VM " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^VM " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW VMESS ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Vmess 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

trial_vm() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Vmess Trial 👤\n\n( Expired Days=1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_vmess() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"
    req_voucher $file_user
    req_limit
    if grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
    echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vmess/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vmess/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain)
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)

sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json

    cat > /usr/local/etc/xray/$user-tls.json << EOF
            {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF

cat > /usr/local/etc/xray/$user-none.json << EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess-none",
      "type": "none",
      "host": "bug.com",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-grpc.json << EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF

cat > /usr/local/etc/xray/$user-h2.json << EOF
            {
      "v": "2",
      "ps": "${user}",
      "add": "vmh2.${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "h2",
      "path": "/vmess-h2",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF
    echo -e "VM $user $exp" >> /usr/local/etc/xray/user.txt

    vmess_base641=$( base64 -w 0 <<< $vmess_json1);
    vmess_base642=$( base64 -w 0 <<< $vmess_json2);
    vmess_base643=$( base64 -w 0 <<< $vmess_json3);
    vmess_base644=$( base64 -w 0 <<< $vmess_json4);

    vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)";
    vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)";
    vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-grpc.json)";
    vmesslink4="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-h2.json)";
    systemctl restart xray@vmess.service
    
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>  (✷‿✷) VMESS ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = ${ip_nya}\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vmh2.${domain}</code>\n"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Alter Id     = 0\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS TLS LINK\n"
    msg+="<code>$vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS LINK\n"
    msg+="<code>$vmesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS H2 TLS LINK\n"
    msg+="<code>$vmesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS GRPC TLS LINK\n"
    msg+="<code>$vmesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"
    
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

del_vmess() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $3}')"

    sed -i "/\b$user\b/d" /usr/local/etc/xray/user.txt
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/vmess.json
    rm -f /usr/local/etc/xray/$user-tls.json;
    rm -f /usr
    /local/etc/xray/$user-none.json;
    rm -f /usr/local/etc/xray/$user-grpc.json;
    rm -f /usr/local/etc/xray/$user-h2.json;
    rm -f /etc/manternet/limit/vmess/quota/$user
    rm -f /etc/manternet/limit/vmess/ip/$user
    rm -f /etc/manternet/vmess/$user
    rm -f /etc/manternet/cache/vmess/$user
    systemctl restart xray@vmess.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE USER VMESS▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>User ( ${user} ${exp} ) Has Been Removed ! </code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
      
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}


ext_vmess() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
        masaaktif=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    else
        masaaktif=30
    fi
    if ! grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    else
        user=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $2}')
        exp=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $3}')
        now=$(date +%Y-%m-%d)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(((d1 - d2) / 86400))
        exp3=$(($exp2 + $masaaktif))
        exp4=$(date -d "$exp3 days" +"%Y-%m-%d")

        sed -i "s/VM $user $exp/VM $user $exp4/g" /usr/local/etc/xray/user.txt
        sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/vmess.json

        systemctl restart xray@vmess.service
      
        local msg
	msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW USER VMESS▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="User ( ${user} ) Renewed Then Expired On ( $exp4 )\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
	
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

check_vmess(){
if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/user.txt | grep 'VM' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "";
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vmess-login
echo -e "         🟢 Vmess User Login 🟢 " >> /tmp/vmess-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vmess-login

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | grep -w $akun | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl -s " • " )
echo -e "  User = $akun" >> /tmp/vmess-login
echo -e "$jum2" >> /tmp/vmess-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vmess-login
fi
rm -rf /tmp/ipvmess.txt
done 
rm -rf /tmp/other.txt
rm -rf /tmp/ipvmess.txt
msg=$(cat /tmp/vmess-login)
cekk=$(cat /tmp/vmess-login | wc -l)
if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ No Users Online ⛔" \
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
ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ Access Denied ⛔\n\nThis Is Your Id: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
return 0
fi
}

vmess_trial() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    req_voucher $file_user
    req_limit
    if grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
    echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vmess/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vmess/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain)
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)

sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json

    cat > /usr/local/etc/xray/$user-tls.json << EOF
            {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF

cat > /usr/local/etc/xray/$user-none.json << EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess-none",
      "type": "none",
      "host": "bug.com",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-grpc.json << EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF

cat > /usr/local/etc/xray/$user-h2.json << EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "vmh2.${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "h2",
      "path": "/vmess-h2",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF
    echo -e "VM $user $exp" >> /usr/local/etc/xray/user.txt

    vmess_base641=$( base64 -w 0 <<< $vmess_json1);
    vmess_base642=$( base64 -w 0 <<< $vmess_json2);
    vmess_base643=$( base64 -w 0 <<< $vmess_json3);
    vmess_base644=$( base64 -w 0 <<< $vmess_json4);

    vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)";
    vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)";
    vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-grpc.json)";
    vmesslink4="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-h2.json)";

    systemctl restart xray@vmess.service    
    
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>   (✷‿✷) VMESS TRIAL ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = ${ip_nya}\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vmh2.${domain}</code>\n"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Alter Id     = 0\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS TLS LINK\n"
    msg+="<code>$vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS LINK\n"
    msg+="<code>$vmesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS H2 TLS LINK\n"
    msg+="<code>$vmesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS GRPC TLS LINK\n"
    msg+="<code>$vmesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuvm
menuvm=''
ShellBot.InlineKeyboardButton --button 'menuvm' --line 1 --text 'CREATE ACC VMESS' --callback_data '_addvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 2 --text 'DELETE ACC VMESS' --callback_data '_delconfvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 2 --text 'RENEW ACC VMESS' --callback_data '_extconfvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 3 --text 'CHECK ACC VMESS' --callback_data '_cekvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 3 --text 'TRIAL ACC VMESS' --callback_data '_trialvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 4 --text '🔙 BACK 🔙' --callback_data '_backvmess'
ShellBot.regHandleFunction --function req_url --callback_data _addvmess
ShellBot.regHandleFunction --function vmess_del --callback_data _delconfvmess
ShellBot.regHandleFunction --function vmess_ext --callback_data _extconfvmess
ShellBot.regHandleFunction --function check_vmess --callback_data _cekvmess
ShellBot.regHandleFunction --function trial_vm --callback_data _trialvmess
ShellBot.regHandleFunction --function back_ser --callback_data _backvmess
unset keyboardvm
keyboardvm="$(ShellBot.InlineKeyboardMarkup -b 'menuvm')"


###############-XRAY-VLESS-ALL-############

menu_vless() {
    local msg
    msg="SELECT AN OPTION BELOW =\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardvl" \
        --parse_mode html
}

vless_del() {    
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VL " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^VL " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE VLESS ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Vless 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

vless_ext() {    
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VL " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^VL " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW VLESS ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Vless 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

trial_vl() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Vless Trial 👤\n\n( Expired Days=1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_vless() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    req_voucher $file_user
    req_limit
    if grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    warp-nya() {
      if [ -r /usr/local/etc/warp/warp-reg ]; then
         msg+="<code>Vless Warp   = Cloudflare Ip</code>\n"
    else
         SKIP=true
    fi
    }
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vless/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vless/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlesswarp
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlesswarp

    echo -e "VL $user $exp" >> /usr/local/etc/xray/user.txt
    
    vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}"
    vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless-none%26encryption=none%26type=ws%26sni=bug.com#${user}"
    vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}"
    vlesslink4="vless://${uuid}@vlh2.${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%252Fvless-h2%26sni=bug.com#${user}"
    systemctl restart xray@vless.service

    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>   (✷‿✷) VLESS ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vlh2.${domain}</code>\n"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port none    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    warp-nya
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS TLS LINK\n"
    msg+="<code>$vlesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS LINK\n"
    msg+="<code>$vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS H2 TLS LINK\n"
    msg+="<code>$vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS GRPC TLS LINK\n"
    msg+="<code>$vlesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

ext_vless() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
        masaaktif=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    else
        masaaktif=30
    fi
    if ! grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    else
        user=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $2}')
        exp=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $3}')
        now=$(date +%Y-%m-%d)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(((d1 - d2) / 86400))
        exp3=$(($exp2 + $masaaktif))
        exp4=$(date -d "$exp3 days" +"%Y-%m-%d")

        sed -i "s/VL $user $exp/VL $user $exp4/g" /usr/local/etc/xray/user.txt
        sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/vless.json
        sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/vlesswarp

        systemctl restart xray@vless.service
      
        local msg
        msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW USER VLESS▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="User ( ${user} ) Renewed Then Expired On ( $exp4 )\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

del_vless() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $3}')"
    
    sed -i "/\b$user\b/d" /usr/local/etc/xray/user.txt
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/vless.json
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/vlesswarp
    rm -f /etc/manternet/limit/vless/quota/$user
    rm -f /etc/manternet/limit/vless/ip/$user
    rm -f /etc/manternet/vless/$user
    rm -f /etc/manternet/cache/vless/$user
    systemctl restart xray@vless.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE USER VLESS▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>User ( ${user} ${exp} ) Has Been Removed ! </code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}

check_vless(){
if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/user.txt | grep 'VL' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "";
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vless-login
echo -e "         🟢 Vless User Login 🟢 " >> /tmp/vless-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vless-login

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvless.txt
data2=( `cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | grep -w $akun | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvless.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvless.txt | nl -s " • " )
echo -e "  User = $akun" >> /tmp/vless-login
echo -e "$jum2" >> /tmp/vless-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/vless-login
fi
rm -rf /tmp/ipvless.txt
done
rm -rf /tmp/other.txt
rm -rf /tmp/ipvless.txt
msg=$(cat /tmp/vless-login)
cekk=$(cat /tmp/vless-login | wc -l)
if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ No Users Online ⛔" \
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
ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ Access Denied ⛔\n\nThis Is Your Id: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
return 0
fi
}

vless_trial() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    req_voucher $file_user
    req_limit
    if grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    warp-nya() {
      if [ -r /usr/local/etc/warp/warp-reg ]; then
         msg+="<code>Vless Warp   = Cloudflare Ip</code>\n"
    else
         SKIP=true
    fi
    }
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vless/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vless/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    exp=`date -d "$duration days" +"%Y-%m-%d"`
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
      
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlesswarp
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlesswarp

    echo -e "VL $user $exp" >> /usr/local/etc/xray/user.txt
    
    vlesslink1="vless://${uuid}@${domain}:${xtls1}?path=%2Fvless%26security=tls%26encryption=none%26type=ws%26sni=bug.com#${user}"
    vlesslink2="vless://${uuid}@${domain}:${none1}?path=%2Fvless-none%26encryption=none%26type=ws%26sni=bug.com#${user}"
    vlesslink3="vless://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26encryption=none%26type=grpc%26serviceName=vless-grpc%26sni=bug.com#${user}"
    vlesslink4="vless://${uuid}@vlh2.${domain}:${xtls1}?security=tls%26encryption=none%26type=h2%26headerType=none%26path=%252Fvless-h2%26sni=bug.com#${user}"
    systemctl restart xray@vless.service
   
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>   (✷‿✷) VLESS TRIAL ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vlh2.${domain}</code>\n"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port none    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    warp-nya
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS TLS LINK\n"
    msg+="<code>$vlesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS LINK\n"
    msg+="<code>$vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS H2 TLS LINK\n"
    msg+="<code>$vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS GRPC TLS LINK\n"
    msg+="<code>$vlesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuvl
menuvl=''
ShellBot.InlineKeyboardButton --button 'menuvl' --line 1 --text 'CREATE ACC VLESS' --callback_data '_addvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 2 --text 'DELETE ACC VLESS' --callback_data '_delconfvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 2 --text 'RENEW ACC VLESS' --callback_data '_extconfvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 3 --text 'CHECK ACC VLESS' --callback_data '_cekvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 3 --text 'TRIAL ACC VLESS' --callback_data '_trialvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 4 --text '🔙 BACK 🔙' --callback_data '_backvless'
ShellBot.regHandleFunction --function req_url --callback_data _addvless
ShellBot.regHandleFunction --function vless_del --callback_data _delconfvless
ShellBot.regHandleFunction --function vless_ext --callback_data _extconfvless
ShellBot.regHandleFunction --function check_vless --callback_data _cekvless
ShellBot.regHandleFunction --function trial_vl --callback_data _trialvless
ShellBot.regHandleFunction --function back_ser --callback_data _backvless
unset keyboardvl
keyboardvl="$(ShellBot.InlineKeyboardMarkup -b 'menuvl')"


##################-XTLS-ALL-MENU-#######

menu_xtls() {
    local msg
    msg="SELECT AN OPTION BELOW =\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardxt" \
        --parse_mode html
}

xtls_del() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^XTLS " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^XTLS " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE XTLS ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Xtls 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

xtls_ext() {   
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^XTLS " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^XTLS " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW XTLS ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Xtls 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

trial_xt() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Xtls Trial 👤\n\n( Expired Days=1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_xtls() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    req_voucher $file_user
    req_limit
    if grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/xtls/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/xtls/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    
    cat > /usr/local/etc/xray/$user-tcp.json << EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "tcp",
      "path": "/vmesstcp",
      "type": "http",
      "host": "bug.com",
      "tls": "tls"
}
EOF

sed -i '/#xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "'xtls-rprx-vision'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

    echo -e "XTLS $user $exp" >> /usr/local/etc/xray/user.txt;

    # // Link
    vmess_base641=$( base64 -w 0 <<< $vmess_json1);

    vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tcp.json)";
    vlesslink2="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26headerType=none%26type=tcp%26flow=xtls-rprx-vision%26sni=bug.com#${user}"
    trojanlink3="trojan://${uuid}@${domain}:${xtls1}?type=tcp%26flow=xtls-rprx-direct%26sni=bug.com#${user}"
    vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=tcp%26headerType=http%26path=/vlesstcp%26sni=bug.com%26host=bug.com#${user}"

    systemctl restart xray.service    
   
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>    (✷‿✷) XTLS ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks              = $user\n"
    msg+="Myip                 = $ip_nya\n"
    msg+="Subdomain            = ${domain}</code>\n"    
    msg+="<code>Limit Quota          = ${limit_nya}</code>\n"
    msg+="<code>Port Tls             = ${xtls}\n"
    msg+="Password %26 User Id = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP TLS VISION LINK\n"
    msg+="<code>$vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP HTTP TLS LINK\n"
    msg+="<code>$vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS TCP HTTP TLS LINK\n"
    msg+="<code>$vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN TCP TLS LINK\n"
    msg+="<code>$trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher

}

ext_xtls() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
        masaaktif=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    else
        masaaktif=30
    fi
    if ! grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    else
        user=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $2}')
        exp=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $3}')
        now=$(date +%Y-%m-%d)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(((d1 - d2) / 86400))
        exp3=$(($exp2 + $masaaktif))
        exp4=$(date -d "$exp3 days" +"%Y-%m-%d")

        sed -i "s/XTLS $user $exp/XTLS $user $exp4/g" /usr/local/etc/xray/user.txt
        sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/config.json

        systemctl restart xray.service   
	
        local msg
	msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW USER XTLS▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="User ( ${user} ) Renewed Then Expired On ( $exp4 )\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

del_xtls() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $3}')"
    
    sed -i "/\b$user\b/d" /usr/local/etc/xray/user.txt
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
    rm -f /usr/local/etc/xray/$user-tcp.json;
    rm -f /etc/manternet/limit/xtls/quota/$user
    rm -f /etc/manternet/limit/xtls/ip/$user
    rm -f /etc/manternet/xtls/$user
    rm -f /etc/manternet/cache/xtls/$user

    systemctl restart xray.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE USER VLESS▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>User ( ${user} ${exp} ) Has Been Removed !</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}

check_xtls(){
if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/user.txt | grep 'XTLS' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "";
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/xtls-login
echo -e "         🟢 Xtls User Login 🟢 " >> /tmp/xtls-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/xtls-login

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipxtls.txt
data2=( `cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | grep -w $akun | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipxtls.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipxtls.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipxtls.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipxtls.txt | nl -s " • " )
echo -e "  User = $akun" >> /tmp/xtls-login
echo -e "$jum2" >> /tmp/xtls-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/xtls-login
fi
rm -rf /tmp/ipxtls.txt
done
rm -rf /tmp/other.txt
rm -rf /tmp/ipxtls.txt
msg=$(cat /tmp/xtls-login)
cekk=$(cat /tmp/xtls-login | wc -l)
if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ No Users Online ⛔" \
                --parse_mode html
rm /tmp/xtls-login
return 0
else
ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "$msg" \
         --parse_mode html
rm /tmp/xtls-login
return 0
fi
else
ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ Access Denied ⛔\n\nThis Is Your Id: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
return 0
fi
}

xtls_trial() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"; 
    req_voucher $file_user
    req_limit
    if grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
    echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/xtls/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/xtls/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    
    cat > /usr/local/etc/xray/$user-tcp.json << EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${xtls1}",
      "id": "${uuid}",
      "aid": "0",
      "net": "tcp",
      "path": "/vmesstcp",
      "type": "http",
      "host": "bug.com",
      "tls": "tls"
}
EOF

sed -i '/#xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "'xtls-rprx-vision'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

    echo -e "XTLS $user $exp" >> /usr/local/etc/xray/user.txt;

    # // Link
    vmess_base641=$( base64 -w 0 <<< $vmess_json1);

    vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tcp.json)";
    vlesslink2="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26headerType=none%26type=tcp%26flow=xtls-rprx-vision%26sni=bug.com#${user}"
    trojanlink3="trojan://${uuid}@${domain}:${xtls1}?type=tcp%26flow=xtls-rprx-direct%26sni=bug.com#${user}"
    vlesslink4="vless://${uuid}@${domain}:${xtls1}?security=tls%26encryption=none%26type=tcp%26headerType=http%26path=/vlesstcp%26sni=bug.com%26host=bug.com#${user}"

    systemctl restart xray.service    

    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>    (✷‿✷) XTLS TRIAL ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks              = $user\n"
    msg+="Myip                 = $ip_nya\n"
    msg+="Subdomain            = ${domain}</code>\n"    
    msg+="<code>Limit Quota          = ${limit_nya}</code>\n"
    msg+="<code>Port Tls             = ${xtls}\n"
    msg+="Password %26 User Id = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP TLS VISION LINK\n"
    msg+="<code>$vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP HTTP TLS LINK\n"
    msg+="<code>$vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS TCP HTTP TLS LINK\n"
    msg+="<code>$vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN TCP TLS LINK\n"
    msg+="<code>$trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuxt
menuxt=''
ShellBot.InlineKeyboardButton --button 'menuxt' --line 1 --text 'CREATE ACC XTLS' --callback_data '_addxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 2 --text 'DELETE ACC XTLS' --callback_data '_delconfxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 2 --text 'RENEW ACC XTLS' --callback_data '_extconfxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 3 --text 'CHECK ACC XTLS' --callback_data '_cekxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 3 --text 'TRIAL ACC XTLS' --callback_data '_trialxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 4 --text '🔙 BACK 🔙' --callback_data '_backxtls'
ShellBot.regHandleFunction --function req_url --callback_data _addxtls
ShellBot.regHandleFunction --function xtls_del --callback_data _delconfxtls
ShellBot.regHandleFunction --function xtls_ext --callback_data _extconfxtls
ShellBot.regHandleFunction --function check_xtls --callback_data _cekxtls
ShellBot.regHandleFunction --function trial_xt --callback_data _trialxtls
ShellBot.regHandleFunction --function back_ser --callback_data _backxtls
unset keyboardxt
keyboardxt="$(ShellBot.InlineKeyboardMarkup -b 'menuxt')"


##################-TROJAN-ALL-MENU-#######

menu_trojan() {
    local msg
    msg="SELECT AN OPTION BELOW =\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardtr" \
        --parse_mode html
}

trojan_del() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^TR " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^TR " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
              --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE TROJAN ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
              --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
              --text "🗑 Remove User Trojan 🗑\n\n( Username ) :" \
              --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

trojan_ext() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^TR " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^TR " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW TROJAN ACCOUNT▪️🔹▪️ </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Trojan 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
      return 0
      fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
      return 0
      fi
}

trial_tr() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Trojan Trial 👤\n\n( Expired Days=1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_trojan() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"
    req_voucher $file_user
    req_limit
    if grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
        echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/trojan/quota/$user
        export limit_nya=$(printf `echo $(cat /etc/manternet/limit/trojan/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
        export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

    echo -e "TR $user $exp" >> /usr/local/etc/xray/user.txt;

    trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
    trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan-none#${user}";
    trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
    trojanlink4="trojan://${uuid}@trh2.${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";
 
    systemctl restart xray@trojan.service
      
    local msg 
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>  (✷‿✷) TROJAN ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = trh2.${domain}</code>\n"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="Password     = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key  a (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS TLS LINK\n"
    msg+="<code>$trojanlink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS LINK\n"
    msg+="<code>$trojanlink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN H2 TLS LINK\n"
    msg+="<code>$trojanlink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN GRPC TLS LINK\n"
    msg+="<code>$trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

ext_trojan() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
        masaaktif=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    else
        masaaktif=30
    fi
    if ! grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    else
        user=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $2}')
        exp=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $3}')
        now=$(date +%Y-%m-%d)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(((d1 - d2) / 86400))
        exp3=$(($exp2 + $masaaktif))
        exp4=$(date -d "$exp3 days" +"%Y-%m-%d")

        sed -i "s/TR $user $exp/TR $user $exp4/g" /usr/local/etc/xray/user.txt
        sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/trojan.json

        systemctl restart xray@trojan.service
      
        local msg
	msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW USER TROJAN▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="User ( ${user} ) Renewed Then Expired On ( $exp4 )\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

del_trojan() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $3}')"
    
    sed -i "/\b$user\b/d" /usr/local/etc/xray/user.txt
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/trojan.json
    rm -f /etc/manternet/limit/trojan/quota/$user
    rm -f /etc/manternet/limit/trojan/ip/$user
    rm -f /etc/manternet/trojan/$user
    rm -f /etc/manternet/cache/trojan/$user

    systemctl restart xray@trojan.service

    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE USER TROJAN▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="User (<code> ${user} ${exp} </code>) Has Been Removed !\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}


check_trojan(){
if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/user.txt | grep 'TR' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "";
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/trojan-login
echo -e "         🟢 Xtls User Login 🟢 " >> /tmp/trojan-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/trojan-login

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/iptrojan.txt
data2=( `cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | grep -w $akun | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptrojan.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojan.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrojan.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/iptrojan.txt | nl -s " • " )
echo -e "  User = $akun" >> /tmp/trojan-login
echo -e "$jum2" >> /tmp/trojan-login
echo -e "━━━━━━━━━━━━━━━━━━━━━" >> /tmp/trojan-login
fi
rm -rf /tmp/iptrojan.txt
done
rm -rf /tmp/other.txt
rm -rf /tmp/iptrojan.txt
msg=$(cat /tmp/trojan-login)
cekk=$(cat /tmp/trojan-login | wc -l)
if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ No Users Online ⛔" \
                --parse_mode html
rm /tmp/trojan-login
return 0
else
ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "$msg" \
         --parse_mode html
rm /tmp/trojan-login
return 0
fi
else
ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ Access Denied ⛔\n\nThis Is Your Id: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
return 0
fi
}

trojan_trial() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";          
    req_voucher $file_user
    req_limit
    if grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
        echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/trojan/quota/$user
        export limit_nya=$(printf `echo $(cat /etc/manternet/limit/trojan/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
        export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

    echo -e "TR $user $exp" >> /usr/local/etc/xray/user.txt;

    trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
    trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan-none#${user}";
    trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
    trojanlink4="trojan://${uuid}@trh2.${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";
 
    systemctl restart xray@trojan.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>   (✷‿✷) TROJAN TRIAL ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = trh2.${domain}</code>\n"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="Password     = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key  a (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS TLS LINK\n"
    msg+="<code>$trojanlink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS LINK\n"
    msg+="<code>$trojanlink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN H2 TLS LINK\n"
    msg+="<code>$trojanlink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN GRPC TLS LINK\n"
    msg+="<code>$trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"
    
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}


unset menutr
menutr=''
ShellBot.InlineKeyboardButton --button 'menutr' --line 1 --text 'CREATE ACC TROJAN' --callback_data '_addtrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 2 --text 'DELETE ACC TROJAN' --callback_data '_delconftrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 2 --text 'RENEW ACC TROJAN' --callback_data '_extconftrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 3 --text 'CHECK ACC TROJAN' --callback_data '_cektrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 3 --text 'TRIAL ACC TROJAN' --callback_data '_trialtrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 4 --text '🔙 BACK 🔙' --callback_data '_backtrojan'
ShellBot.regHandleFunction --function req_url --callback_data _addtrojan
ShellBot.regHandleFunction --function trojan_del --callback_data _delconftrojan
ShellBot.regHandleFunction --function trojan_ext --callback_data _extconftrojan
ShellBot.regHandleFunction --function check_trojan --callback_data _cektrojan
ShellBot.regHandleFunction --function trial_tr --callback_data _trialtrojan
ShellBot.regHandleFunction --function back_ser --callback_data _backtrojan
unset keyboardtr
keyboardtr="$(ShellBot.InlineKeyboardMarkup -b 'menutr')"

##################-ALL-TROJAN-GO-###############

menu_ss() {
    local msg
    msg="SELECT AN OPTION BELOW =\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardss" \
        --parse_mode html
}

ss_del() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^SS " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^SS " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
              --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE SHADOWSOCK22 ACCOUNT▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
              --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
              --text "🗑 Remove User Shadowsock22 🗑\n\n( Username ) :" \
              --reply_markup "$(ShellBot.ForceReply)"
           return 0
         fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
          return 0
      fi
}

ss_ext() {
    if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^SS " | awk '{print $2,$3}' | sort | uniq)
    cekk=$(cat /usr/local/etc/xray/user.txt | grep -E "^SS " | wc -l)
    if [ "$cekk" = "0" ] || [ "$cekk" = "0" ]; then
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ YOU DONT HAVE ANY USER YET ⛔" \
                --parse_mode html
     return 0
     else	      
     ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW SHADOWSOCK22 ACCOUNT▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$alluser\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
     ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Shadowsock 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
      return 0
      fi
      else
      ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
      return 0
      fi
}

ss_trl() {
    ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]}
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Trojan Shadowsock 👤\n\n( Expired Days=1 ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_ss() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"
    req_voucher $file_user
    req_limit
    if grep -E "^SS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/ss/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/ss/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    pwdr_nya=$(cat /usr/local/etc/xray/passwd)
    pwd_nya=$(openssl rand -base64 16)
    base641=$(echo -n "2022-blake3-aes-128-gcm:${pwdr_nya}:${pwd_nya}" | base64 -w0)
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)

sed -i '/#ssws$/a\### '"$user $exp"'\
},{"password": "'""$pwd_nya""'","email": "'""$user""'"' /usr/local/etc/xray/ss.json
sed -i '/#ssgrpc$/a\### '"$user $exp"'\
},{"password": "'""$pwd_nya""'","email": "'""$user""'"' /usr/local/etc/xray/ss.json

    echo -e "SS $user $exp" >> /usr/local/etc/xray/user.txt;

    link="http://${ip_nya}:85/${user}-tls";
    link0="http://${ip_nya}:85/${user}-none";
    link1="http://${ip_nya}:85/${user}-grpc";
    sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26host=${domain}%26type=ws%26sni=bug.com#${user}"
    sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}"
    sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock-none%26security=none%26host=${domain}%26type=ws%26sni=bug.com#${user}"
    
    systemctl restart xray@ss.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b> (✷‿✷) SHADOWSOCK22 ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n</code>"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${pwdr_nya}:${pwd_nya}\n"
    msg+="Method       = 2022-blake3-aes-128-gcm</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="SHADOWSOCK22 WS TLS LINK\n"
    msg+="<code>${sslink}</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="SHADOWSOCK22 WS LINK\n"
    msg+="<code>${sslink2}</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="SHADOWSOCK22 GRPC TLS LINK\n"
    msg+="<code>${sslink1}</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

ext_ss() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
        masaaktif=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    else
        masaaktif=30
    fi
    if ! grep -E "^SS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    else
        user=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $2}')
        exp=$(grep -wE "$user" "/usr/local/etc/xray/user.txt" | awk '{print $3}')
        now=$(date +%Y-%m-%d)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(((d1 - d2) / 86400))
        exp3=$(($exp2 + $masaaktif))
        exp4=$(date -d "$exp3 days" +"%Y-%m-%d")

        sed -i "s/SS $user $exp/SS $user $exp4/g" /usr/local/etc/xray/user.txt
        sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/etc/xray/ss.json

        systemctl restart xray@ss.service

        local msg
	msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️RENEW USER SHADOWSOCK22▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="User ( ${user} ) Renewed Then Expired On ( $exp4 )\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

del_ss() {
    file_user=$1
    user=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if ! grep -E "^SS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Does Not Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    user="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $2}')"
    exp="$(cat /usr/local/etc/xray/user.txt | grep -w "$user" | awk '{print $3}')"
    
    sed -i "/\b$user\b/d" /usr/local/etc/xray/user.txt
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/ss.json
    rm -f /home/vps/public_html/$user-tls
    rm -f /home/vps/public_html/$user-grpc
    rm -f /home/vps/public_html/$user-none
    rm -f /etc/manternet/limit/ss/quota/$user
    rm -f /etc/manternet/limit/ss/ip/$user
    rm -f /etc/manternet/ss/$user
    rm -f /etc/manternet/cache/ss/$user

    systemctl restart xray@ss.service

    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>▪️🔹▪️DELETE USER SHADOWSOCK22▪️🔹▪️</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="User (<code> ${user} ${exp} </code>) Has Been Removed !\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}

check_ss(){
if [[ "${callback_query_from_id[$id]}" == "$get_AdminID" ]]; then
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/user.txt | grep 'SS' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "";
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━" >> /tmp/ss-login
echo -e "🟢 SHADOWSOCK22 USER LOGIN 🟢" >> /tmp/ss-login
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━" >> /tmp/ss-login

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipss.txt
data2=( `cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep "$(date -d "0 days" +"%H:%M" )" | grep -w $akun | tail -n150 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -F $ip | sed 's/2402//g' | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipss.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipss.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipss.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipss.txt | nl -s " • " )
echo -e "  User = $akun" >> /tmp/ss-login
echo -e "$jum2" >> /tmp/ss-login
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━" >> /tmp/ss-login
fi
rm -rf /tmp/ipss.txt
done
rm -rf /tmp/other.txt
rm -rf /tmp/ipss.txt
msg=$(cat /tmp/ss-login)
cekk=$(cat /tmp/ss-login | wc -l)
if [ "$cekk" = "0" ] || [ "$cekk" = "3" ]; then
ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⛔ NO USERS ONLINE ⛔" \
                --parse_mode html
rm /tmp/ss-login
return 0
else
ShellBot.deleteMessage --chat_id ${callback_query_message_chat_id[$id]} \
              --message_id ${callback_query_message_message_id[$id]}
ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
         --text "$msg" \
         --parse_mode html
rm /tmp/ss-login
return 0
fi
else
ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ ACCESS DENIED ⛔\n\nTHIS IS YOUR ID: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
return 0
fi
}


ss_trial() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    limit=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '4p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')";
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";         
    req_voucher $file_user
    req_limit
    if grep -E "^SS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
    if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
        duration=$expadmin
    else
        duration=1
    fi
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/ss/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/ss/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    pwdr_nya=$(cat /usr/local/etc/xray/passwd)
    pwd_nya=$(openssl rand -base64 16)
    base641=$(echo -n "2022-blake3-aes-128-gcm:${pwdr_nya}:${pwd_nya}" | base64 -w0)
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)

sed -i '/#ssws$/a\### '"$user $exp"'\
},{"password": "'""$pwd_nya""'","email": "'""$user""'"' /usr/local/etc/xray/ss.json
sed -i '/#ssgrpc$/a\### '"$user $exp"'\
},{"password": "'""$pwd_nya""'","email": "'""$user""'"' /usr/local/etc/xray/ss.json

    echo -e "SS $user $exp" >> /usr/local/etc/xray/user.txt;

    link="http://${ip_nya}:85/${user}-tls";
    link0="http://${ip_nya}:85/${user}-none";
    link1="http://${ip_nya}:85/${user}-grpc";
    sslink="ss://${base641}@${domain}:${xtls1}?path=%2Fshadowsock%26security=tls%26host=${domain}%26type=ws%26sni=bug.com#${user}"
    sslink1="ss://${base641}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=shadowsock-grpc%26sni=bug.com#${user}"
    sslink2="ss://${base641}@${domain}:${none1}?path=%2Fshadowsock-none%26security=none%26host=${domain}%26type=ws%26sni=bug.com#${user}"
    
    systemctl restart xray@ss.service
      
    local msg 
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>(✷‿✷) SHADOWSOCK22 TRIAL ACCOUNT (✷‿✷)</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n</code>"
    msg+="<code>Limit Quota  = ${limit_nya}</code>\n"
    msg+="<code>Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${pwdr_nya}:${pwd_nya}\n"
    msg+="Method       = 2022-blake3-aes-128-gcm</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="SHADOWSOCK22 WS TLS LINK\n"
    msg+="<code>${sslink}</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="SHADOWSOCK22 WS LINK\n"
    msg+="<code>${sslink2}</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="SHADOWSOCK22 GRPC TLS LINK\n"
    msg+="<code>${sslink1}</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuss
menuss=''
ShellBot.InlineKeyboardButton --button 'menuss' --line 1 --text 'CREATE ACC SS-22' --callback_data '_addss'
ShellBot.InlineKeyboardButton --button 'menuss' --line 2 --text 'DELETE ACC SS-22' --callback_data '_delconfss'
ShellBot.InlineKeyboardButton --button 'menuss' --line 2 --text 'RENEW ACC SS-22' --callback_data '_extconfss'
ShellBot.InlineKeyboardButton --button 'menuss' --line 3 --text 'CHECK ACC SS-22' --callback_data '_cekss'
ShellBot.InlineKeyboardButton --button 'menuss' --line 3 --text 'TRIAL ACC SS-22' --callback_data '_trialss'
ShellBot.InlineKeyboardButton --button 'menuss' --line 4 --text '🔙 BACK 🔙' --callback_data '_backss'
ShellBot.regHandleFunction --function req_url --callback_data _addss
ShellBot.regHandleFunction --function ss_del --callback_data _delconfss
ShellBot.regHandleFunction --function ss_ext --callback_data _extconfss
ShellBot.regHandleFunction --function check_ss --callback_data _cekss
ShellBot.regHandleFunction --function ss_trl --callback_data _trialss
ShellBot.regHandleFunction --function back_ser --callback_data _backss
unset keyboardss
keyboardss="$(ShellBot.InlineKeyboardMarkup -b 'menuss')"

##################-ALL-TROJAN-GO-###############

#create_ssock() {
#}

#delete_trgo() {
#}

#renew_trgo() {
#}

#check_trgo() {
#}

#trial_trgo() {
#}

#unset menutrgo
#menutrgo=''
#ShellBot.InlineKeyboardButton --button 'menutrgo' --line 1 --text 'CREATE ACC TRGO' --callback_data '_addtrgo'
#ShellBot.InlineKeyboardButton --button 'menutrgo' --line 1 --text 'DELETE ACC TRGO' --callback_data '_delconftrgo'
#ShellBot.InlineKeyboardButton --button 'menutrgo' --line 2 --text 'RENEW ACC TRGO' --callback_data '_extconftrgo'
#ShellBot.InlineKeyboardButton --button 'menutrgo' --line 2 --text 'CHECK ACC TRGO' --callback_data '_cektrgo'
#ShellBot.InlineKeyboardButton --button 'menutrgo' --line 3 --text 'TRIAL ACC TRGO' --callback_data '_trialtrgo'
#ShellBot.InlineKeyboardButton --button 'menutrgo' --line 4 --text '🔙 BACK 🔙' --callback_data '_backtrgo'
#ShellBot.regHandleFunction --function req_url --callback_data _addtrgo
#ShellBot.regHandleFunction --function trgo_del --callback_data _delconftrgo
#ShellBot.regHandleFunction --function trgo_ext --callback_data _extconftrgo
#ShellBot.regHandleFunction --function trgo_cek --callback_data _cektrgo
#ShellBot.regHandleFunction --function trgo_trl --callback_data _trialtrgo
#ShellBot.regHandleFunction --function back_ser --callback_data _backtrgo
#unset keyboardtrgo
#keyboardtrgo="$(ShellBot.InlineKeyboardMarkup -b 'menutrgo')"

start_req() {
    file_user=$1
    config=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '1p')
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    pass=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    
    if [ "${config}" == "vmess" ]; then
        create_vmess $file_user
	
    elif [ "${config}" == "vless" ]; then
        create_vless $file_user
	
    elif [ "${config}" == "xtls" ]; then
        create_xtls $file_user
	
    elif [ "${config}" == "trojan" ]; then
        create_trojan $file_user
	
    elif [ "${config}" == "ss" ]; then
        create_ss $file_user
	
    elif [ "${config}" == "ovpn" ]; then
        req_ovpn $file_user
	
    elif [ "${config}" == "trialvmess" ]; then
        vmess_trial $file_user
	
    elif [ "${config}" == "trialvless" ]; then
        vless_trial $file_user
	
    elif [ "${config}" == "trialxtls" ]; then
        xtls_trial $file_user
	
    elif [ "${config}" == "trialtrojan" ]; then
        trojan_trial $file_user
	
    elif [ "${config}" == "trialss" ]; then
        ss_trial $file_user
	
    elif [ "${config}" == "free" ]; then
        freeReq $file_user
	
    elif [ "${config}" == "voucher" ]; then
        echo "$user" >$file_user
        input_voucher $file_user
	
    else
        msg_welcome
    fi
}

input_voucher() {
    file_user=$1
    voucher=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc $voucher /root/multi/voucher)" != '0' ]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "VALID VOUCHER ✅\n" \
            --reply_markup "$keyboard8" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "NOT A VALID VOUCHER ⛔\n" \
            --parse_mode html
        exit 1
    fi
}

restartReq() {
    if [ "${message_from_id[$id]}" == "$get_AdminID" ]; then
        systemctl restart stunnel5.service
	systemctl restart dropbear.service
	systemctl restart openssh.service
        systemctl restart openvpn.service
        systemctl restart server-sldns.service
	systemctl restart nginx.service
	systemctl restart haproxy.service
        systemctl restart ws-epro.service
        systemctl restart xray.service.service
        systemctl restart xray@none.service
        systemctl restart xray@vless.service
        systemctl restart xray@vmess.service
        systemctl restart xray@trojan.service
        systemctl restart xray@ss.service
        systemctl restart trojan-go.service
    
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "DONE RESTART ALL SERVICE ✅" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "⛔ ACCESS DENY ⛔\n" \
            --parse_mode html
    fi
}

sta_tus() {
        systemctl is-active --quiet stunnel5 && stsstn="Running 🟢" || stsstn="Not Running 🔴"
        systemctl is-active --quiet dropbear && stsdb="Running 🟢" || stsdb="Not Running 🔴"
        systemctl is-active --quiet cron && stscron="Running 🟢" || stscron="Not Running 🔴"
        systemctl is-active --quiet ssh && stsssh="Running 🟢" || stssah="Not Running 🔴"
        systemctl is-active --quiet openvpn && stsovpn="Running 🟢" || stsovpn="Not Running 🔴"
        systemctl is-active --quiet vnstat && stsvnstat="Running 🟢" || stsvnstat="Not Running 🔴"
        systemctl is-active --quiet fail2ban && stsban="Running 🟢" || stsban="Not Running 🔴"
        systemctl is-active --quiet nginx && stsnginx="Running 🟢" || stsnginx="Not Running 🔴"
        systemctl is-active --quiet haproxy && stshap="Running 🟢" || stshap="Not Running 🔴"
    	systemctl is-active --quiet server-sldns && stsdns="Running 🟢" || stsdns="Not Running 🔴"
        systemctl is-active --quiet ws-epro && stsepro="Running 🟢" || stsepro="Not Running 🔴"

	systemctl is-active --quiet xray && stsray="Running 🟢" || stsray="Not Running 🔴"
        systemctl is-active --quiet xray@none && stsnone="Running 🟢" || stsnone="Not Running 🔴"
        systemctl is-active --quiet xray@vless && stsvless="Running 🟢" || stsvless="Not Running 🔴"
        systemctl is-active --quiet xray@vmess && stsvmess="Running 🟢" || stsvmess="Not Running 🔴"
        systemctl is-active --quiet xray@trojan && ststrojan="Running 🟢" || ststrojan="Not Running 🔴"
        systemctl is-active --quiet xray@ss && stsss="Running 🟢" || stsss="Not Running 🔴"
        
    	systemctl is-active --quiet trojan-go && ststrgo="Running 🟢" || ststrgo="Not Running 🔴"
                
        local msg
        msg="━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="<b> WELCOME TO BOT </b>\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━\n"
        msg+="Status Service = 🟢🔴\n\n"
        msg+="<code>Dropbear          = $stsdb\n"
     	msg+="Openssh           = $stsssh\n"
        msg+="Stunnel5          = $stsstn\n"
     	msg+="Openvpn           = $stsovpn\n"
        msg+="Crons             = $stscron\n"
        msg+="Vnstat            = $stsvnstat\n"
        msg+="Fail²ban          = $stsban\n"
        msg+="Nginx             = $stsnginx\n"
        msg+="Haproxy           = $stshap\n"
    	msg+="Slowdns           = $stsdns\n"
        msg+="Xray Tcp Xtls     = $stsray\n"
    	msg+="Xray None Tls     = $stsnone\n"
        msg+="Xray Vless        = $stsvless\n"
    	msg+="Xray Vmess        = $stsvmess\n"
    	msg+="Xray Shadowsock22 = $stsss\n"
        msg+="Xray Trojan       = $ststrojan\n"
        msg+="Trojan-go         = $ststrgo\n"
        msg+="Ssh Ws Tls        = $stsepro\n"
        msg+="Ssh Ws None       = $stsepro\n"
        msg+="Ovpn Ws Tls       = $stsepro\n"
        msg+="Ovpn Ws None      = $stsepro</code>\n"
        msg+="━━━━━━━━━━━━━━━━━━━━━\n"
	
	ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
           --message_id ${callback_query_message_message_id[$id]} \
           --text "$msg" \
           --reply_markup "$keyboardsts" \
           --parse_mode html
   }        

unset menu1
menu1=''
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text '❇️ OPEN SERVICE ❇️️' --callback_data '_menuser'
ShellBot.InlineKeyboardButton --button 'menu1' --line 5 --text '🟢 STATUS SERVICE 🟢️️' --callback_data '_stsserv'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text '👨‍🦱 RESELLER 👨‍🦱' --callback_data '_resellerMenu'
ShellBot.InlineKeyboardButton --button 'menu1' --line 4 --text '🏷️ VOUCHER GENERATOR 🏷️' --callback_data '_voucherGenerator'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text '🌐 PUBLIC MODE 🌐' --callback_data '_publicMode'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text '🌡️ LIMIT FREE 🌡️' --callback_data '_freelimit'
ShellBot.InlineKeyboardButton --button 'menu1' --line 6 --text '🚀 SPEESTEST SERVER 🚀' --callback_data '_speedtest'
ShellBot.regHandleFunction --function menu_ser --callback_data _menuser
ShellBot.regHandleFunction --function sta_tus --callback_data _stsserv
ShellBot.regHandleFunction --function menuRes --callback_data _resellerMenu
ShellBot.regHandleFunction --function generatorReq --callback_data _voucherGenerator
ShellBot.regHandleFunction --function publicReq --callback_data _publicMode
ShellBot.regHandleFunction --function freelimitReq --callback_data _freelimit
ShellBot.regHandleFunction --function speed_test --callback_data _speedtest
unset keyboard1
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'menu1')"

# // Menu Back Status
unset menusts
menusts=''
ShellBot.InlineKeyboardButton --button 'menusts' --line 1 --text '🔙 BACK 🔙' --callback_data '_backsts'
ShellBot.regHandleFunction --function backReq --callback_data _backsts
unset keyboardsts
keyboardsts="$(ShellBot.InlineKeyboardMarkup -b 'menusts')"

unset menuxr
menuxr=''
ShellBot.InlineKeyboardButton --button 'menuxr' --line 1 --text 'MENU SSH-VPN' --callback_data '_menussh'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 2 --text 'MENU VLESS' --callback_data '_menuvless'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 2 --text 'MENU VMESS' --callback_data '_menuvmess'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 3 --text 'MENU TROJAN' --callback_data '_menutrojan'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 3 --text 'MENU XTLS' --callback_data '_menuxtls'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 4 --text 'MENU SS22' --callback_data '_menuss'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 5 --text '🔙 BACK 🔙' --callback_data '_backxray'
ShellBot.regHandleFunction --function menu_ssh --callback_data _menussh
ShellBot.regHandleFunction --function menu_vless --callback_data _menuvless
ShellBot.regHandleFunction --function menu_vmess --callback_data _menuvmess
ShellBot.regHandleFunction --function menu_trojan --callback_data _menutrojan
ShellBot.regHandleFunction --function menu_xtls --callback_data _menuxtls
ShellBot.regHandleFunction --function menu_ss --callback_data _menuss
ShellBot.regHandleFunction --function backReq --callback_data _backxray
unset keyboardxr
keyboardxr="$(ShellBot.InlineKeyboardMarkup -b 'menuxr')"

unset menu3
menu3=''
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text 'VMESS' --callback_data '_freevmess'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text 'VLESS' --callback_data '_freevless'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text 'XTLS' --callback_data '_freextls'
ShellBot.InlineKeyboardButton --button 'menu3' --line 3 --text 'TROJAN' --callback_data '_freetrojan'
ShellBot.InlineKeyboardButton --button 'menu3' --line 3 --text 'SSHVPN' --callback_data '_freeovpn'
ShellBot.InlineKeyboardButton --button 'menu3' --line 4 --text 'SS22' --callback_data '_freess'
ShellBot.regHandleFunction --function req_free --callback_data _freevmess
ShellBot.regHandleFunction --function req_free --callback_data _freevless
ShellBot.regHandleFunction --function req_free --callback_data _freextls
ShellBot.regHandleFunction --function req_free --callback_data _freetrojan
ShellBot.regHandleFunction --function req_free --callback_data _freeovpn
ShellBot.regHandleFunction --function req_free --callback_data _freess
unset keyboard3
keyboard3="$(ShellBot.InlineKeyboardMarkup -b 'menu3')"

unset menu5
menu5=''
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text 'MENU SSH' --callback_data '_menussh5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text 'MENU VLESS' --callback_data '_menuvless5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text 'MENU VMESS' --callback_data '_menuvmess5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text 'MENU TROJAN' --callback_data '_menutrojan5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text 'MENU XTLS' --callback_data '_menuxtls5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text 'MENU SS22' --callback_data '_menuss5'
ShellBot.regHandleFunction --function menu_ssh --callback_data _menussh5
ShellBot.regHandleFunction --function menu_vless --callback_data _menuvless5
ShellBot.regHandleFunction --function menu_vmess --callback_data _menuvmess5
ShellBot.regHandleFunction --function menu_trojan --callback_data _menutrojan5
ShellBot.regHandleFunction --function menu_xtls --callback_data _menuxtls5
ShellBot.regHandleFunction --function menu_ss --callback_data _menuss5

unset keyboard5
keyboard5="$(ShellBot.InlineKeyboardMarkup -b 'menu5')"

unset menu6
menu6=''
ShellBot.InlineKeyboardButton --button 'menu6' --line 1 --text 'REGISTER RESELLER' --callback_data '_resellerReq'
ShellBot.InlineKeyboardButton --button 'menu6' --line 2 --text 'ADD BALANCE' --callback_data '_balRes'
ShellBot.InlineKeyboardButton --button 'menu6' --line 2 --text 'ALL RESELLER' --callback_data '_allRes'
ShellBot.InlineKeyboardButton --button 'menu6' --line 3 --text 'DELETE RESELLER' --callback_data '_delRes'
ShellBot.InlineKeyboardButton --button 'menu6' --line 4 --text '🔙 BACK 🔙' --callback_data '_back6'
ShellBot.regHandleFunction --function resellerReq --callback_data _resellerReq
ShellBot.regHandleFunction --function balRes --callback_data _balRes
ShellBot.regHandleFunction --function allRes --callback_data _allRes
ShellBot.regHandleFunction --function delRes --callback_data _delRes
ShellBot.regHandleFunction --function backReq --callback_data _back6
unset keyboard6
keyboard6="$(ShellBot.InlineKeyboardMarkup -b 'menu6')"

unset menu7
menu7=''
ShellBot.InlineKeyboardButton --button 'menu7' --line 1 --text 'CLAIM VOUCHER' --callback_data '_claimvoucher'
ShellBot.regHandleFunction --function voucher_req --callback_data _claimvoucher
unset keyboard7
keyboard7="$(ShellBot.InlineKeyboardMarkup -b 'menu7')"

#unset menu8
#menu8=''
#ShellBot.InlineKeyboardButton --button 'menu8' --line 1 --text 'VMESS' --callback_data '_vouchervmess'
#ShellBot.InlineKeyboardButton --button 'menu8' --line 2 --text 'VLESS' --callback_data '_vouchervless'
#ShellBot.InlineKeyboardButton --button 'menu8' --line 2 --text 'XTLS' --callback_data '_voucherxtls'
#ShellBot.InlineKeyboardButton --button 'menu8' --line 3 --text 'TROJAN' --callback_data '_vouchertrojan'
#ShellBot.InlineKeyboardButton --button 'menu8' --line 3 --text 'SSHVPN' --callback_data '_voucherovpn'
#ShellBot.InlineKeyboardButton --button 'menu8' --line 4 --text 'SS22' --callback_data '_voucherss'
#ShellBot.regHandleFunction --function link_voucher --callback_data _vouchervmess
#ShellBot.regHandleFunction --function link_voucher --callback_data _vouchervless
#ShellBot.regHandleFunction --function link_voucher --callback_data _voucherxtls
#ShellBot.regHandleFunction --function link_voucher --callback_data _vouchertrojan
#ShellBot.regHandleFunction --function link_voucher --callback_data _voucherovpn
#ShellBot.regHandleFunction --function link_voucher --callback_data _voucherss
#unset keyboard8
#keyboard8="$(ShellBot.InlineKeyboardMarkup -b 'menu8')"

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
            if [[ ${message_entities_type[$id]} == bot_command ]]; then
                case ${message_text[$id]} in
                *)
                    :
                    comando=(${message_text[$id]})
                    [[ "${comando[0]}" = "/free" ]] && freeReq
                    [[ "${comando[0]}" = "/claim" ]] && claimVoucher
                    [[ "${comando[0]}" = "/restart" ]] && restartReq
                    ;;
                esac
            fi
            if [[ ${message_entities_type[$id]} == bot_command ]]; then
                echo "${message_text[$id]}" >$CAD_ARQ
                if [ "$(awk '{print $1}' $CAD_ARQ)" = '/start' ]; then
                    start_req $CAD_ARQ
                fi
            fi
            if [[ ${message_reply_to_message_message_id[$id]} ]]; then
                case ${message_reply_to_message_text[$id]} in
                '👤 Create User ssh-vpn 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🔐 Create Password ssh-vpn 🔐\n\n( passwd ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '🔐 Create Password ssh-vpn 🔐\n\n( passwd ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date ssh-vpn 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '🗓️ Create Expired Date ssh-vpn 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    input_addssh $CAD_ARQ
                    ;;
                '🗑 Remove User ssh-vpn 🗑\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    input_delssh $CAD_ARQ
                    ;;
                '📅 Renew User ssh-vpn 📅\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📅 Extend User ssh-vpn Days 📅\n\n( example: 1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '📅 Extend User ssh-vpn Days 📅\n\n( example: 1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    input_extssh $CAD_ARQ
                    ;;
	        '👤 Create User ssh-vpn 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
		    echo "${message_text[$id]}" >>/tmp/userssh.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date ssh-vpn 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
                '🗓️ Create Expired Date ssh-vpn 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
			exp=30
                    fi
		    user=$(sed -n '1 p' /tmp/userssh.txt | cut -d' ' -f1)
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^SSH $user" /usr/local/etc/ssh/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			echo "start ovpn_${user}_${vouch}" >$CAD_ARQ
                        rm -rf /tmp/userssh.txt
                        req_ovpn $CAD_ARQ
	            fi
                    ;;
	        '👤 Create User Vmess 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/uservmess.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📶 Limit Quota Vmess 📶\n\n( example 1Gb=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
	        '📶 Limit Quota Vmess 📶\n\n( example 1Gb=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/quotavmess.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date Vmess 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
                '🗓️ Create Expired Date Vmess 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
			exp=30
                    fi
		    user=$(sed -n '1 p' /tmp/uservmess.txt | cut -d' ' -f1)
                    limit=$(sed -n '1 p' /tmp/quotavmess.txt | cut -d' ' -f1)
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			echo "start vmess_${user}_${vouch}_${limit}" >$CAD_ARQ
                        rm -rf /tmp/uservmess.txt
			rm -rf /tmp/quotavmess.txt
                        create_vmess $CAD_ARQ
	            fi
                    ;;
	        '👤 Create User Vless 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
		    echo "${message_text[$id]}" >>/tmp/uservless.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📶 Limit Quota Vless 📶\n\n( example 1Gb=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
	         '📶 Limit Quota Vless 📶\n\n( example 1Gb=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/quotavless.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date Vless 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
                '🗓️ Create Expired Date Vless 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
			exp=30
                    fi
		    user=$(sed -n '1 p' /tmp/uservless.txt | cut -d' ' -f1)
                    limit=$(sed -n '1 p' /tmp/quotavless.txt | cut -d' ' -f1)
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			echo "start vless_${user}_${vouch}_${limit}" >$CAD_ARQ
                        rm -rf /tmp/uservless.txt
			rm -rf /tmp/quotavless.txt
                        create_vless $CAD_ARQ
	            fi
                    ;;
	        '👤 Create User Xtls 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
		    echo "${message_text[$id]}" >>/tmp/userxtls.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📶 Limit Quota Xtls 📶\n\n( example 1Gb=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
	         '📶 Limit Quota Xtls 📶\n\n( example 1Gb=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/quotaxtls.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date Xtls 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
                '🗓️ Create Expired Date Xtls 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
			exp=30
                    fi
		    user=$(sed -n '1 p' /tmp/userxtls.txt | cut -d' ' -f1)
                    limit=$(sed -n '1 p' /tmp/quotaxtls.txt | cut -d' ' -f1)
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			echo "start xtls_${user}_${vouch}_${limit}" >$CAD_ARQ
                        rm -rf /tmp/userxtls.txt
			rm -rf /tmp/quotaxtls.txt
                        create_xtls $CAD_ARQ
	            fi
	            ;;
                '👤 Create User Trojan 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/usertrojan.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📶 Limit Quota Trojan 📶\n\n( example 1Gb=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
	        '📶 Limit Quota Trojan 📶\n\n( example 1Gb=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/quotatrojan.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date Trojan 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
                '🗓️ Create Expired Date Trojan 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
			exp=30
                    fi
		    user=$(sed -n '1 p' /tmp/usertrojan.txt | cut -d' ' -f1)
                    limit=$(sed -n '1 p' /tmp/quotatrojan.txt | cut -d' ' -f1)
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			echo "start trojan_${user}_${vouch}_${limit}" >$CAD_ARQ
                        rm -rf /tmp/usertrojan.txt
			rm -rf /tmp/quotatrojan.txt
                        create_trojan $CAD_ARQ
	            fi
	            ;;
	        '👤 Create User Shadowaock22 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
		    echo "${message_text[$id]}" >>/tmp/userss.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📶 Limit Quota Shadowsock22 📶\n\n( example 1Gb=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
	        '📶 Limit Quota Shadowsock22 📶\n\n( example 1Gb=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    echo "${message_text[$id]}" >>/tmp/quotass.txt
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "🗓️ Create Expired Date Shadowsock22 🗓️\n\n( days=1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
	            ;;
                '🗓️ Create Expired Date Shadowsock22 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
			exp=30
                    fi
		    user=$(sed -n '1 p' /tmp/userss.txt | cut -d' ' -f1)
                    limit=$(sed -n '1 p' /tmp/quotass.txt | cut -d' ' -f1)
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^SS $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			echo "start ss_${user}_${vouch}_${limit}" >$CAD_ARQ
                        rm -rf /tmp/userss.txt
			rm -rf /tmp/quotass.txt
                        create_ss $CAD_ARQ
	            fi
	            ;;
                '👤 Create User Vmess free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start vmess_public${userfree}_free_50" >$CAD_ARQ
                    create_vmess $CAD_ARQ
                    ;;
                '👤 Create User Vless free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start vless_public${userfree}_free_50" >$CAD_ARQ
                    create_vless $CAD_ARQ
                    ;;
                '👤 Create User Xtls free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start xtls_public${userfree}_free_50" >$CAD_ARQ
                    create_xtls $CAD_ARQ
                    ;;
                '👤 Create User Trojan free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start trojan_public${userfree}_free_50" >$CAD_ARQ
                    create_trojan $CAD_ARQ
                    ;;
	        '👤 Create User Shadowsock22 free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start ss_public${userfree}_free_50" >$CAD_ARQ
                    create_ss $CAD_ARQ
                    ;;
                '🗑 Remove User Vless 🗑\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    del_vless $CAD_ARQ
                    ;;
                '📅 Renew User Vless 📅\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📅 Extend User Vless Days 📅\n\n( example: 1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '📅 Extend User Vless Days 📅\n\n( example: 1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    ext_vless $CAD_ARQ
                    ;;
	        '🗑 Remove User Vmess 🗑\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    del_vmess $CAD_ARQ
                    ;;
                '📅 Renew User Vmess 📅\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📅 Extend User Vmess Days 📅\n\n( example: 1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '📅 Extend User Vmess Days 📅\n\n( example: 1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    ext_vmess $CAD_ARQ
                    ;;
		'🗑 Remove User Xtls 🗑\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    del_xtls $CAD_ARQ
                    ;;
                '📅 Renew User Xtls 📅\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📅 Extend User Xtls Days 📅\n\n( example: 1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '📅 Extend User Xtls Days 📅\n\n( example: 1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    ext_xtls $CAD_ARQ
                    ;;
	        '🗑 Remove User Trojan 🗑\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    del_trojan $CAD_ARQ
                    ;;
                '📅 Renew User Trojan 📅\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📅 Extend User Trojan Days 📅\n\n( example: 1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '📅 Extend User Trojan Days 📅\n\n( example: 1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    ext_trojan $CAD_ARQ
                    ;;
		 '🗑 Remove User Shadowsock22 🗑\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    del_ss $CAD_ARQ
                    ;;
                '📅 Renew User Shadowsock 📅\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "📅 Extend User Shadowsock22 Days 📅\n\n( example: 1 ) :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '📅 Extend User Shadowsock22 Days 📅\n\n( example: 1 ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    ext_ss $CAD_ARQ
                    ;;
		'👤 Create Vmess Trial 👤\n\n( Expired Days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    else
			exp=1
                    fi
		    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
		    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
		    if grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else      
                        echo "$vouch $exp" >>/root/multi/voucher			
		        echo "start trialvmess_${user}_${vouch}_50" >$CAD_ARQ
		        vmess_trial $CAD_ARQ
		    fi
                    ;;
		'👤 Create Vless Trial 👤\n\n( Expired Days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    else
			exp=1
                    fi
		    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
		    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
		    if grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else      
                        echo "$vouch $exp" >>/root/multi/voucher			
		        echo "start trialvless_${user}_${vouch}_50" >$CAD_ARQ
	                vless_trial $CAD_ARQ
		    fi
                    ;;
		'👤 Create Xtls Trial 👤\n\n( Expired Days=1 ) :')                   
		    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    else
			exp=1
                    fi
		    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
		    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
		    if grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else      
                        echo "$vouch $exp" >>/root/multi/voucher			
		        echo "start trialxtls_${user}_${vouch}_50" >$CAD_ARQ
		        xtls_trial $CAD_ARQ
		    fi
                    ;;
		'👤 Create Trojan Trial 👤\n\n( Expired Days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then                      
			exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    else
			exp=1
                    fi
		    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
		    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
		    if grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else      
                        echo "$vouch $exp" >>/root/multi/voucher			
		        echo "start trialtrojan_${user}_${vouch}_50" >$CAD_ARQ
		        trojan_trial $CAD_ARQ
	            fi
                    ;;
	        '👤 Create Trojan Shadowsock 👤\n\n( Expired Days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
		    reseller_balance
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
			exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    else
			exp=1
                    fi
		    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
		    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
		    if grep -E "^SS $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else      
                        echo "$vouch $exp" >>/root/multi/voucher			
		        echo "start trialss_${user}_${vouch}_50" >$CAD_ARQ
		        ss_trial $CAD_ARQ
		    fi
                    ;;
                '🫂 Create Reseller 🫂 :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "💰 Reseller Balance 💰 :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '💰 Reseller Balance 💰 :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_input $CAD_ARQ
                    ;;
                '💰 Add Balance Reseller 💰 :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "💰 Add Balance 💰 :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                '💰 Add Balance 💰 :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    balance_reseller $CAD_ARQ
                    ;;
                '🗑️ Delete Reseller 🗑️ :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    delete_reseller $CAD_ARQ
                    ;;
                '🏷️ Input Your Voucher 🏷️ :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    input_voucher $CAD_ARQ
                    ;;
                '🗓️ Voucher Validity 🗓️\n\n( days=1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
		    exp1=$(date -d +${exp}days +%Y-%m-%d)
                    echo "$vouch $exp" >>/root/multi/voucher
		    local msg
                    msg="<code>Expired = $exp1</code>\n"
                    msg+="Voucher = <code>$vouch</code>\n"
                    msg+="<a href='https://t.me/${get_botName}?voucher_${vouch}_50'>Click Here To Claim</a>\n"

                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$msg" \
                        --parse_mode html
                    ;;
                '📝 Change Limit Config 📝\n\n( example =1 ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    freelim=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
		    freelama=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
		    sed -i "s/Limit: ${freelama}/Limit: ${freelim}/g" /root/multi/bot.conf
                    local msg
                    msg="Successful Change Limit Config To $freelim ✅"
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$msg" \
                        --parse_mode html
                    ;;
                esac
            fi
        ) &. 
    done
done
