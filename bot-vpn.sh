#!/bin/bash
# // Exporting maklumat rangkaian
source /root/ip-detail.txt;
export ip_nya="$IP";

source /etc/.maAsiss/.Shellbtsss
get_Token=$(sed -n '1 p' /root/ResBotAuth | cut -d' ' -f2)
get_AdminID=$(sed -n '2 p' /root/ResBotAuth | cut -d' ' -f2)
get_botName=$(sed -n '1 p' /root/multi/bot.conf | cut -d' ' -f2)
get_limituser=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
res_price=5

ShellBot.init --token $get_Token --monitor --return map --flush --log_file /root/log_bot

msg_welcome() {
    oribal=$(grep ${message_from_id} /root/multi/reseller | awk '{print $2}')
    if [ "${message_from_id[$id]}" == "$get_AdminID" ]; then
        local msg
        msg="Welcome MASTER\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
    elif [ "$(grep -wc ${message_from_id} /root/multi/reseller)" != '0' ]; then
        local msg
        msg="Welcome Reseller\n\n"
        msg+="Your Id : <code>${message_from_id}</code>\n"
        msg+="Your Balance Is $oribal"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard5" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "❌Access Deny❌\n\nThis Is Your Id: <code>${message_from_id}</code>\n" \
            --parse_mode html
    fi
}

backReq() {
    oribal=$(grep ${callback_query_from_id} /root/multi/reseller | awk '{print $2}')
    if [ "${callback_query_from_id[$id]}" == "$get_AdminID" ]; then
        local msg
        msg="Welcome MASTER\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
    elif [ "$(grep -wc ${callback_query_from_id} /root/multi/reseller)" != '0' ]; then
        local msg
        msg="Welcome Reseller\n\n"
        msg+="Your Id : <code>${callback_query_from_id}</code>\n"
        msg+="Your Balance Is $oribal"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard5" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "❌Access Deny❌\n\nThis Is Your Id: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
    fi
}

back_ser() {
    oribal=$(grep ${callback_query_from_id} /root/multi/reseller | awk '{print $2}')
    if [ "${callback_query_from_id[$id]}" == "$get_AdminID" ]; then
        local msg
        msg="⏭️ Menu Service ⏮️\n"
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboardxr" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${callback_query_message_message_id[$id]} \
            --text "⛔ Access Deny ⛔\n\nThis Is Your Id: <code>${callback_query_from_id}</code>\n" \
            --parse_mode html
    fi
}


freeReq() {
    if [ "$(cat /root/multi/public)" == "on" ]; then
        local msg
        msg="Welcome ${message_from_first_name}\n"
        msg+="Please Select Free Config Below\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard3" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Free Function Is Close\n" \
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
    msg="⏭️ Menu Service ⏮️\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardxr" \
        --parse_mode html
}

menuRes() {
    local msg
    msg="Welcome ${callback_query_from_first_name}\n"
    msg+="Menu Reseller\n"
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
            --text "✅ Public Mode Is Online, Limit Is $limituser ✅"
    else
        echo "off" >/root/multi/public
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⛔ Public Mode Is Offline,Limit Is $limituser ⛔"
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
                --text "Public Is Off\n" \
                --parse_mode html
            exit 1
        else
            echo "free"
        fi
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Already Claimed\n" \
            --parse_mode html
        exit 1
    fi
}

req_url() {
    ori=$(grep ${callback_query_from_id} /root/multi/reseller | awk '{print $2}')

    if [[ ${callback_query_data[$id]} == _addvmess ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vmess 👤\n\n( Username Expired ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _addvless ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vless 👤\n\n( Username Expired ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _addxtls ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Xtls 👤\n\n( Username Expired ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _addtrojan ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Trojan 👤\n\n( Username Expired ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _voucherOVPN ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User ssh-vpn 👤\n\n( Username Expired ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    fi
}

link_voucher() {
    file_user=/tmp/cad.${callback_query_message_chat_id[$id]}
    vouch=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    duration=$(grep $vouch /root/multi/voucher | awk '{print $2}')
    exp1=$(date -d +${duration}days +%Y-%m-%d)
    user=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c4)

    if [[ ${callback_query_data[$id]} == _vouchervmess ]]; then
        local msg
        msg="User      = $user\n"
        msg+="<code>Expired = $exp1</code>\n"
        msg+="https://t.me/${get_botName}?start=vmess_${user}_${vouch}\n\n"
        msg+="Click Link To Confirm Vmess Acc\n"

        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
	    
    elif [[ ${callback_query_data[$id]} == _vouchervless ]]; then
        local msg
        msg="User      = $user\n"
        msg+="<code>Expired = $exp1</code>\n"
        msg+="https://t.me/${get_botName}?start=vless_${user}_${vouch}\n\n"
        msg+="Click Link To Confirm Vless Acc\n"

        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    elif [[ ${callback_query_data[$id]} == _voucherxtls ]]; then
        local msg
        msg="User      = $user\n"
        msg+="<code>Expired = $exp1</code>\n"
        msg+="https://t.me/${get_botName}?start=xtls_${user}_${vouch}\n\n"
        msg+="Click Link To Confirm Xtls Acc\n"

        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    elif [[ ${callback_query_data[$id]} == _vouchertrojan ]]; then
        local msg
        msg="User      = $user\n"
        msg+="<code>Expired = $exp1</code>\n"
        msg+="https://t.me/${get_botName}?start=trojan_${user}_${vouch}\n\n"
        msg+="Click Link To Confirm Trojan Acc\n"

        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    elif [[ ${callback_query_data[$id]} == _voucherovpn ]]; then
        local msg
        msg="User      = $user\n"
        msg+="<code>Expired = $exp1</code>\n"
        msg+="https://t.me/${get_botName}?start=ovpn_${user}_${vouch}\n\n"
        msg+="Click Link To Confirm Vmess Acc\n"

        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    fi
}

req_free() {
    if [[ ${callback_query_data[$id]} == _freevmess ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vmess free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _freevless ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Vless free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _freextls ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Xtls free 👤\n\n( Username ) :" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ ${callback_query_data[$id]} == _freetrojan ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
            --text "👤 Create User Trojan free 👤\n\n( Username ) :" \
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
            --text "Already Redeem" \
            --parse_mode html
        exit 1
    elif (($total >= $limituser)); then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Fully Redeem" \
            --parse_mode html
        exit 1
    else
        echo "${message_from_id[$id]}" >>/root/multi/claimed
    fi
}

freelimitReq() {
    limituser=$(sed -n '2 p' /root/multi/bot.conf | cut -d' ' -f2)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Your Current Free Limit Is $limituser" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Change Limit:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

generatorReq() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Voucher Validity:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

voucher_req() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Input Your Voucher:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

resellerReq() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Create Reseller :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

balRes() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Add Balance Reseller :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

allRes() {
    result=$(cat /root/multi/reseller)
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━\n 🟢 Reseller 🟢 \n━━━━━━━━━━━━━━━━━━━━━\n\n$result\n\n━━━━━━━━━━━━━━━━━━━━━\n" \
        --reply_markup "$keyboard6" \
        --parse_mode html
}

delRes() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Delete Reseller :" \
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
        msg="$User New Balance Is $topup\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard6" \
            --parse_mode html
    else
        msg="$User Is Not Reseller\n"
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
        msg="$User Successful Deleted\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --reply_markup "$keyboard6" \
            --parse_mode html
    else
        msg="$User Is Not Reseller\n"
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

###############-SSH-VPN-ALL-############
menu_ssh() {
    local msg
    msg="🕴️ Welcome ${callback_query_from_first_name} Menu ssh-vpn 🕴️\n"
 #   msg+="Menu\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboard4" \
        --parse_mode html
}

add_ssh() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create User ssh-vpn 👤\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

del_ssh() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User ssh-vpn 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

ext_ssh() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User ssh-vpn 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
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
        fi
    done
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Done Remove Expired User\n" \
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
    masaaktif=$(sed -n '3 p' $file_user | cut -d' ' -f1)
    domain=$(cat /root/domain)
    IP=$(wget -qO- ipinfo.io/ip)
    ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2 | sed 's/ //g')"
    sqd="$(cat ~/log-install.txt | grep -w "Squid Proxy" | cut -d: -f2 | sed 's/ //g')"
    ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
    ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
    useradd -e $(date -d "$masaaktif days" +"%Y-%m-%d") -s /bin/false -M $Login
    exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
    echo -e "$Pass\n$Pass\n" | passwd $Login &>/dev/null
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸 OVPN ACCOUNT 🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="Thank You For Using Our Services\n"
    msg+="SSH %26 OpenVPN Account Info\n"
    msg+="Username       : $Login\n"
    msg+="Password       : $Pass\n"
    msg+="Expired On     : $exp\n"
    msg+="Host           : ${domain}\n"
    msg+="\n"
    msg+="OpenVPN        : TCP $ovpn http://$IP:81/client-tcp-$ovpn.ovpn\n"
    msg+="OpenVPN        : UDP $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn\n"
    msg+="OpenVPN        : SSL 442 http://$IP:81/client-tcp-ssl.ovpn\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
}

input_delssh() {
    file_user=$1
    Pengguna=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if getent passwd $Pengguna >/dev/null 2>&1; then
        userdel $Pengguna
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$Pengguna Was Removed\n" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Failure: User $Pengguna Not Exist\n" \
            --parse_mode html
    fi
}

input_extssh() {
    file_user=$1
    User=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    Days=$(sed -n '2 p' $file_user | cut -d' ' -f1)
    egrep "^$User" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        Today=$(date +%s)
        Days_Detailed=$(($Days * 86400))
        Expire_On=$(($Today + $Days_Detailed))
        Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
        Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
        passwd -u $User
        usermod -e $Expiration $User
        egrep "^$User" /etc/passwd >/dev/null
        echo -e "$Pass\n$Pass\n" | passwd $User &>/dev/null

        local msg
        msg="Username :  $User\n"
        msg+="Days Added :  $Days Days\n"
        msg+="Expires on :  $Expiration_Display\n"

        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$msg" \
            --parse_mode html
    else
        local msg
        msg="Username Doesnt Exist\n"

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
    domain=$(cat /root/domain)
    IP=$(wget -qO- ipinfo.io/ip)
    ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2 | sed 's/ //g')"
    sqd="$(cat ~/log-install.txt | grep -w "Squid Proxy" | cut -d: -f2 | sed 's/ //g')"
    ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
    ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
    useradd -e $(date -d "$masaaktif days" +"%Y-%m-%d") -s /bin/false -M $Login
    exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
    echo -e "$Pass\n$Pass\n" | passwd $Login &>/dev/null
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸 OVPN ACCOUNT 🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="Thank You For Using Our Services\n"
    msg+="SSH %26 OpenVPN Account Info\n"
    msg+="Username       : $Login\n"
    msg+="Password       : $Pass\n"
    msg+="Expired On     : $exp\n"
    msg+="Host           : ${domain}\n"
    msg+="\n"
    msg+="OpenVPN        : TCP $ovpn http://$IP:81/client-tcp-$ovpn.ovpn\n"
    msg+="OpenVPN        : UDP $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn\n"
    msg+="OpenVPN        : SSL 442 http://$IP:81/client-tcp-ssl.ovpn\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html

    sed -i "/$coupon/d" /root/multi/voucher
}

##################-VMESS-ALL-MENU-#######

menu_vmess() {
    local msg
    msg="🕴️ Menu Xray Vmess 🕴️\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardvm" \
        --parse_mode html
}

vmess_del() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VM " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE VMESS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Vmess 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

vmess_ext() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VM " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW VMESS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Vmess 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"

}

trial_vm() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Vmess Trial 👤\n\n( Expired Days ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_vmess() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    
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
        duration=3
    fi
    limit='0'
    if [[ $limit -gt 0 ]]; then
    echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vmess/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vmess/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
    none1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')"

    # VM WS TLS 
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json

    # VM GRPC
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
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸VMESS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = ${ip_nya}\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vmh2.${domain}\n"
    msg+="Limit Quota  = ${limit_nya}\n"
    msg+="Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Alter Id     = 0\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS TLS LINK\n"
    msg+="<code> $vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS LINK\n"
    msg+="<code> $vmesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS H2 TLS LINK\n"
    msg+="<code> $vmesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS GRPC TLS LINK\n"
    msg+="<code> $vmesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="Expired On    = $exp\n"

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
    rm -f /usr/local/etc/xray/$user-none.json;
    rm -f /usr/local/etc/xray/$user-grpc.json;
    rm -f /usr/local/etc/xray/$user-h2.json;
    rm -f /etc/manternet/limit/vmess/quota/$user
    rm -f /etc/manternet/limit/vmess/ip/$user
    rm -f /etc/manternet/vmess/$user
    rm -f /etc/manternet/cache/vmess/$user

    systemctl restart xray@vmess.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE USER VMESS🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━\n"
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
	msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW USER VMESS🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
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

trial_vmess() {
    file_user=$1
    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )";
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
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
    limit='10'
    if [[ $limit -gt 0 ]]; then
    echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vmess/quota/$user
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vmess/quota/$user) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)

    # VM WS TLS 
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json

    # VM GRPC
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
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸VMESS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = ${ip_nya}\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vmh2.${domain}\n"
    msg+="Limit Quota  = ${limit_nya}\n"
    msg+="Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}\n"
    msg+="Alter Id     = 0\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS TLS LINK\n"
    msg+="<code> $vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS WS LINK\n"
    msg+="<code> $vmesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS H2 TLS LINK\n"
    msg+="<code> $vmesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS GRPC TLS LINK\n"
    msg+="<code> $vmesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="Expired On    = $exp\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuvm
menuvm=''
ShellBot.InlineKeyboardButton --button 'menuvm' --line 1 --text 'Create Account Vmess' --callback_data '_addvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 1 --text 'Delete Account Vmess' --callback_data '_delconfvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 2 --text 'Renew Account Vmess' --callback_data '_extconfvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 2 --text 'Check Account Vmess' --callback_data '_cekvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 3 --text 'Trial Account Vmess' --callback_data '_trialvmess'
ShellBot.InlineKeyboardButton --button 'menuvm' --line 4 --text '🔙 Back 🔙' --callback_data '_backvmess'
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
    msg="🕴️ Menu Xray Vless 🕴️\n"
  #  msg+="Menu SSH\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardvl" \
        --parse_mode html
}

vless_del() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VL " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE VLESS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Vless 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

vless_ext() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^VL " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW VLESS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Vless 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"

}

trial_vl() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Vless Trial 👤\n\n( Expired Days ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

vless_kota() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "Limit Quota ( ex: 1= 1Gb ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_vless() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
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
        duration=3
    fi
    warp-nya() {
      if [ -r /usr/local/etc/warp/warp-reg ]; then
         msg+="<code>Vless Warp   = Cloudflare Ip</code>\n"
    else
         SKIP=true
    fi
    }
    limit='0'
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vless/quota/$userna
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vless/quota/$userna) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
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
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸VLESS ACCOUNT🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vlh2.${domain}\n"
    msg+="Limit Quota  = $limit_nya\n"
    msg+="Port None    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    warp-nya
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS TLS LINK\n"
    msg+="<code> $vlesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS LINK\n"
    msg+="<code> $vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS H2 TLS LINK\n"
    msg+="<code> $vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS GRPC TLS LINK\n"
    msg+="<code> $vlesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="Expired On    = $exp\n"

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
        msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW USER VLESS🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
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
    msg="━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE USER VLESS🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━━━\n"
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

trial_vless() {
    file_user=$1
    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )";     
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
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
    
    limit='10'
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vless/quota/$userna
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vless/quota/$userna) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
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
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸VLESS ACCOUNT🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vlh2.${domain}\n"
    msg+="Limit Quota  = $limit_nya\n"
    msg+="Port None    = ${none}\n"
    msg+="Grpc Type    = Gun %26 Multi\n"
    msg+="User Id      = ${uuid}</code>\n"
    warp-nya
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS TLS LINK\n"
    msg+="<code> $vlesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS WS LINK\n"
    msg+="<code> $vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS H2 TLS LINK\n"
    msg+="<code> $vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS GRPC TLS LINK\n"
    msg+="<code> $vlesslink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="Expired On    = $exp\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuvl
menuvl=''
ShellBot.InlineKeyboardButton --button 'menuvl' --line 1 --text 'Create Account Vless' --callback_data '_addvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 1 --text 'Delete Account Vless' --callback_data '_delconfvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 2 --text 'Renew Account Vless' --callback_data '_extconfvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 2 --text 'Check Account Vless' --callback_data '_cekvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 3 --text 'Trial Account Vless' --callback_data '_trialvless'
ShellBot.InlineKeyboardButton --button 'menuvl' --line 4 --text '🔙 Back 🔙' --callback_data '_backvless'
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
    msg="🕴️ Menu Xray Xtls 🕴️\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardxt" \
        --parse_mode html
}

xtls_del() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^XTLS " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE XTLS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Xtls 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

xtls_ext() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^XTLS " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW XTLS ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Xtls 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

trial_xt() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Xtls Trial 👤\n\n( Expired Days ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_xtls() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
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
        duration=3
    fi
    limit='0'
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

    # // VL XTLS
sed -i '/#xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "'xtls-rprx-vision'","email": "'""$user""'"' /usr/local/etc/xray/config.json

    # // TR TCP TLS
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

    # // VM TCP HTTP TLS
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

    # // VL TCP HTTP TLS
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
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸XTLS ACCOUNT🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip               = $ip_nya\n"
    msg+="Subdomain          = ${domain}\n"    
    msg+="Limit Quota        = ${limit_nya}\n"
    msg+="Port Tls           = ${xtls}</code>\n"
    msg+="<code>Password %26 User Id = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP TLS VISION LINK\n"
    msg+="<code> $vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP HTTP TLS LINK\n"
    msg+="<code> $vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS TCP HTTP TLS LINK\n"
    msg+="<code> $vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN TCP TLS LINK\n"
    msg+="<code> $trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
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
	msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW USER XTLS🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
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
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE USER VLESS🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
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

trial_xtls() {
    file_user=$1
    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )";
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
    expadmin=$(grep $coupon /root/multi/voucher | awk '{print $2}')
    xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')";
    xtls1="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2 | awk '{print $1}' | sed 's/,//g' | sed 's/ //g')";
  
#    req_voucher $file_user
#    req_limit
    if grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "User Already Exist ❗❗\n" \
            --parse_mode html
        exit 1
    fi
  #  if [ "$(grep -wc $coupon /root/multi/voucher)" != '0' ]; then
 #       duration=$expadmin
 #   else
  #      duration=1
  #  fi
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

    # // VL XTLS
sed -i '/#xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "'xtls-rprx-vision'","email": "'""$user""'"' /usr/local/etc/xray/config.json

    # // TR TCP TLS
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

    # // VM TCP HTTP TLS
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

    # // VL TCP HTTP TLS
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
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸XTLS ACCOUNT🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks            = $user\n"
    msg+="Myip               = $ip_nya\n"
    msg+="Subdomain          = ${domain}\n"    
    msg+="Limit Quota        = ${limit_nya}\n"
    msg+="Port Tls           = ${xtls}</code>\n"
    msg+="<code>Password %26 User Id = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key   (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP TLS VISION LINK\n"
    msg+="<code> $vlesslink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VLESS TCP HTTP TLS LINK\n"
    msg+="<code> $vlesslink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="VMESS TCP HTTP TLS LINK\n"
    msg+="<code> $vmesslink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN TCP TLS LINK\n"
    msg+="<code> $trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"

    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}

unset menuxt
menuxt=''
ShellBot.InlineKeyboardButton --button 'menuxt' --line 1 --text 'Create Account Xtls' --callback_data '_addxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 1 --text 'Delete Account Xtls' --callback_data '_delconfxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 2 --text 'Renew Account Xtls' --callback_data '_extconfxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 2 --text 'Check Account Xtls' --callback_data '_cekxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 3 --text 'Trial Account Xtls' --callback_data '_trialxtls'
ShellBot.InlineKeyboardButton --button 'menuxt' --line 4 --text '🔙 Back 🔙' --callback_data '_backxtls'
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
    msg="🕴️ Menu Xray Trojan 🕴️\n"
    ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
        --message_id ${callback_query_message_message_id[$id]} \
        --text "$msg" \
        --reply_markup "$keyboardtr" \
        --parse_mode html
}

trojan_del() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^TR " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE TROJAN ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "🗑 Remove User Trojan 🗑\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

trojan_ext() {
    cat /usr/local/etc/xray/user.txt >/tmp/cad.${message_from_id[$id]}
    alluser=$(cat /usr/local/etc/xray/user.txt | grep -E "^TR " | awk '{print $2,$3}' | nl -s '• ' | sort | uniq)
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "━━━━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW TROJAN ACCOUNT🔸🔸🔸 </b>\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n$alluser\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━\n" \
        --parse_mode html
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "📅 Renew User Trojan 📅\n\n( Username ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

trial_tr() {
    ShellBot.sendMessage --chat_id ${callback_query_from_id[$id]} \
        --text "👤 Create Trojan Trial 👤\n\n( Expired Days ) :" \
        --reply_markup "$(ShellBot.ForceReply)"
}

create_trojan() {
    file_user=$1
    user=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '2p')
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
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
        duration=3
    fi
    limit='0'
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
    
    # // TR WS TLS
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

    # // TR GRPC
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

    echo -e "TR $user $exp" >> /usr/local/etc/xray/user.txt;

    trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
    trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com%26security=none%26type=ws%26path=%2Ftrojan-none#${user}";
    trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
    trojanlink4="trojan://${uuid}@trh2.${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%2Ftrojan-h2%26sni=bug.com#${user}";
 
    systemctl restart xray@trojan.service
      
    local msg 
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸TROJAN ACCOUNT🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vlh2.${domain}\n"
    msg+="Limit Quota  = ${limit_nya}\n"
    msg+="Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}</code>\n"
    msg+="<code>Grpc Type    = Gun %26 Multi</code>\n"
    msg+="<code>Password     = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key  a (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS TLS LINK\n"
    msg+="<code> $trojanlink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS LINK\n"
    msg+="<code> $trojanlink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN H2 TLS LINK\n"
    msg+="<code> $trojanlink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN GRPC TLS LINK\n"
    msg+="<code> $trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
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
	msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸RENEW USER TROJAN🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
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
    msg="━━━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸DELETE USER TROJAN🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━━━\n"
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

trial_trojan() {
    file_user=$1
    user="Trial-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )";
    coupon=$(grep 'start [^_]*' $file_user | grep -o '[^_]*' | cut -d' ' -f2 | sed -n '3p')
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
    limit='10'
    if [[ $limit -gt 0 ]]; then
       echo -e "$[$limit * 1024 * 1024 * 1024]" > /etc/manternet/limit/vless/quota/$userna
       export limit_nya=$(printf `echo $(cat /etc/manternet/limit/vless/quota/$userna) | numfmt --to=iec-i --suffix=B --format="%.1f" | column -t`)
    else
       export limit_nya="Unlimited"
    fi
    domain=$(cat /usr/local/etc/xray/domain);
    ns_nya=$(cat /usr/local/etc/xray/nsdomain);
    pub_key=$(cat /etc/slowdns/server.pub);
    uuid=$(uuidgen);
    exp=$(date -d +${duration}days +%Y-%m-%d)
    
    # // TR WS TLS
    sed -i '/#trojanws$/a\### '"$user $exp"'\
      },{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

    # // TR GRPC
    sed -i '/#trojangrpc$/a\### '"$user $exp"'\
      },{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

    echo -e "TR $user $exp" >> /usr/local/etc/xray/user.txt;

    trojanlink1="trojan://${uuid}@${domain}:${xtls1}?type=ws%26security=tls%26path=%2Ftrojan%26sni=bug.com#${user}";
    trojanlink2="trojan://${uuid}@${domain}:${none1}?host=bug.com&security=none%26type=ws%26path=%2Ftrojan-none#${user}";
    trojanlink3="trojan://${uuid}@${domain}:${xtls1}?mode=gun%26security=tls%26type=grpc%26serviceName=trojan-grpc%26sni=bug.com#${user}";
    trojanlink4="trojan://${uuid}@trh2.${domain}:${xtls1}?security=tls%26type=h2%26headerType=none%26path=%252Ftrojan-h2%26sni=bug.com#${user}";
 
    systemctl restart xray@trojan.service
      
    local msg
    msg="━━━━━━━━━━━━━━━━━━━━━\n<b>🔸🔸🔸TROJAN ACCOUNT🔸🔸🔸</b>\n━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Remarks      = $user\n"
    msg+="Myip         = $ip_nya\n"
    msg+="Subdomain    = ${domain}\n"
    msg+="Subdomain H2 = vlh2.${domain}\n"
    msg+="Limit Quota  = ${limit_nya}\n"
    msg+="Port Tls     = ${xtls}\n"
    msg+="Port None    = ${none}</code>\n"
    msg+="<code>Grpc Type    = Gun %26 Multi</code>\n"
    msg+="<code>Password     = ${uuid}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Slowdns Port (PORT) = ${xtls1}\n"
    msg+="Name Server  (NS)   = ${ns_nya}\n"
    msg+="Public Key  a (KEY)  = ${pub_key}</code>\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS TLS LINK\n"
    msg+="<code> $trojanlink1</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN WS LINK\n"
    msg+="<code> $trojanlink2</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN H2 TLS LINK\n"
    msg+="<code> $trojanlink4</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="TROJAN GRPC TLS LINK\n"
    msg+="<code> $trojanlink3</code>\n"
    msg+="\n"
    msg+="━━━━━━━━━━━━━━━━━━━━━\n"
    msg+="<code>Expired On    = $exp</code>\n"
    
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$msg" \
        --parse_mode html
        sed -i "/$coupon/d" /root/multi/voucher
}


unset menutr
menutr=''
ShellBot.InlineKeyboardButton --button 'menutr' --line 1 --text 'Create Account Trojan' --callback_data '_addtrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 1 --text 'Delete Account Trojan' --callback_data '_delconftrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 2 --text 'Renew Account Trojan' --callback_data '_extconftrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 2 --text 'Check Account Trojan' --callback_data '_cektrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 3 --text 'Trial Account Trojan' --callback_data '_trialtrojan'
ShellBot.InlineKeyboardButton --button 'menutr' --line 4 --text '🔙 Back 🔙' --callback_data '_backtrojan'
ShellBot.regHandleFunction --function req_url --callback_data _addtrojan
ShellBot.regHandleFunction --function trojan_del --callback_data _delconftrojan
ShellBot.regHandleFunction --function trojan_ext --callback_data _extconftrojan
ShellBot.regHandleFunction --function check_trojan --callback_data _cektrojan
ShellBot.regHandleFunction --function trial_tr --callback_data _trialtrojan
ShellBot.regHandleFunction --function back_ser --callback_data _backtrojan
unset keyboardtr
keyboardtr="$(ShellBot.InlineKeyboardMarkup -b 'menutr')"



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
    elif [ "${config}" == "ovpn" ]; then
        req_ovpn $file_user
    elif [ "${config}" == "free" ]; then
        freeReq $file_user
    elif [ "${config}" == "voucher" ]; then
        echo "$user" >$file_user
        input_voucher $file_user
    else
        echo -e "hey"
       # msg_welcome
    fi
}

input_voucher() {
    file_user=$1
    voucher=$(sed -n '1 p' $file_user | cut -d' ' -f1)
    if [ "$(grep -wc $voucher /root/multi/voucher)" != '0' ]; then
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Valid Voucher\n" \
            --reply_markup "$keyboard8" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Not A Valid Voucher\n" \
            --parse_mode html
        exit 1
    fi
}

restartReq() {
    if [ "${message_from_id[$id]}" == "$get_AdminID" ]; then
        systemctl restart stunnel4
        systemctl restart xray.service
        systemctl restart xray@n
        systemctl restart xray.service
        systemctl restart dropbear
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "Done Restart All Service" \
            --parse_mode html
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "❌Access Deny❌\n" \
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
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text '❇️ Open Service ❇️️' --callback_data '_menuser'
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text '🟢 Status Service 🟢️️' --callback_data '_stsserv'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text '👨‍🦱 Reseller 👨‍🦱' --callback_data '_resellerMenu'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text '🏷️ Voucher Generator 🏷️' --callback_data '_voucherGenerator'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text '🌐 Public Mode 🌐' --callback_data '_publicMode'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text '🌡️ Limit Free 🌡️' --callback_data '_freelimit'
ShellBot.regHandleFunction --function menu_ser --callback_data _menuser
ShellBot.regHandleFunction --function sta_tus --callback_data _stsserv
ShellBot.regHandleFunction --function menuRes --callback_data _resellerMenu
ShellBot.regHandleFunction --function generatorReq --callback_data _voucherGenerator
ShellBot.regHandleFunction --function publicReq --callback_data _publicMode
ShellBot.regHandleFunction --function freelimitReq --callback_data _freelimit
unset keyboard1
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'menu1')"

# // Menu Back Status
unset menusts
menusts=''
ShellBot.InlineKeyboardButton --button 'menusts' --line 1 --text '🔙 Back 🔙' --callback_data '_backsts'
ShellBot.regHandleFunction --function backReq --callback_data _backsts
unset keyboardsts
keyboardsts="$(ShellBot.InlineKeyboardMarkup -b 'menusts')"

unset menuxr
menuxr=''
ShellBot.InlineKeyboardButton --button 'menuxr' --line 1 --text 'Menu Ssh-Vpn' --callback_data '_menussh'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 2 --text 'Menu Vless' --callback_data '_menuvless'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 1 --text 'Menu Vmess' --callback_data '_menuvmess'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 2 --text 'Menu Trojan' --callback_data '_menutrojan'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 2 --text 'Menu Xtls' --callback_data '_menuxtls'
ShellBot.InlineKeyboardButton --button 'menuxr' --line 4 --text '🔙 Back 🔙' --callback_data '_backxray'
ShellBot.regHandleFunction --function menu_ssh --callback_data _menussh
ShellBot.regHandleFunction --function menu_vless --callback_data _menuvless
ShellBot.regHandleFunction --function menu_vmess --callback_data _menuvmess
ShellBot.regHandleFunction --function menu_trojan --callback_data _menutrojan
ShellBot.regHandleFunction --function menu_xtls --callback_data _menuxtls
ShellBot.regHandleFunction --function backReq --callback_data _backxray
unset keyboardxr
keyboardxr="$(ShellBot.InlineKeyboardMarkup -b 'menuxr')"

unset menu3
menu3=''
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text '• Vmess •️' --callback_data '_freevmess'
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text '• Vless •️' --callback_data '_freevless'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text '• Xtls •️' --callback_data '_freextls'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text '• Trojan •️' --callback_data '_freetrojan'
ShellBot.regHandleFunction --function req_free --callback_data _freevmess
ShellBot.regHandleFunction --function req_free --callback_data _freevless
ShellBot.regHandleFunction --function req_free --callback_data _freextls
ShellBot.regHandleFunction --function req_free --callback_data _freetrojan
unset keyboard3
keyboard3="$(ShellBot.InlineKeyboardMarkup -b 'menu3')"

unset menu4
menu4=''
ShellBot.InlineKeyboardButton --button 'menu4' --line 1 --text '• Create User •️' --callback_data '_addssh'
ShellBot.InlineKeyboardButton --button 'menu4' --line 1 --text '• Delete User •️' --callback_data '_delssh'
ShellBot.InlineKeyboardButton --button 'menu4' --line 2 --text '• Delete Expired •️' --callback_data '_delexp'
ShellBot.InlineKeyboardButton --button 'menu4' --line 2 --text '• Extend User •️' --callback_data '_extssh'
ShellBot.InlineKeyboardButton --button 'menu4' --line 3 --text '• Voucher OVPN •️' --callback_data '_voucherOVPN'
ShellBot.InlineKeyboardButton --button 'menu4' --line 4 --text '🔙 Back 🔙' --callback_data '_back4'
ShellBot.regHandleFunction --function add_ssh --callback_data _addssh
ShellBot.regHandleFunction --function del_ssh --callback_data _delssh
ShellBot.regHandleFunction --function del_exp --callback_data _delexp
ShellBot.regHandleFunction --function ext_ssh --callback_data _extssh
ShellBot.regHandleFunction --function req_url --callback_data _voucherOVPN
ShellBot.regHandleFunction --function backReq --callback_data _back4
unset keyboard4
keyboard4="$(ShellBot.InlineKeyboardMarkup -b 'menu4')"

unset menu5
menu5=''
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text '• Menu SSH •️' --callback_data '_menussh5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text '• Menu Vless •️' --callback_data '_menuvless5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text '• Menu Vmess •️' --callback_data '_menuvmess5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text '• Menu Trojan •️' --callback_data '_menutrojan5'
ShellBot.InlineKeyboardButton --button 'menu5' --line 1 --text '• Menu Xtls •️' --callback_data '_menuxtls5'
ShellBot.regHandleFunction --function menu_ssh --callback_data _menussh5
ShellBot.regHandleFunction --function menu_vless --callback_data _menuvless5
ShellBot.regHandleFunction --function menu_vmess --callback_data _menuvmess5
ShellBot.regHandleFunction --function menu_trojan --callback_data _menutrojan5
ShellBot.regHandleFunction --function menu_xtls --callback_data _menuxtls5

unset keyboard5
keyboard5="$(ShellBot.InlineKeyboardMarkup -b 'menu5')"

unset menu6
menu6=''
ShellBot.InlineKeyboardButton --button 'menu6' --line 1 --text '• Register Reseller •️' --callback_data '_resellerReq'
ShellBot.InlineKeyboardButton --button 'menu6' --line 1 --text '• Add Balance •️' --callback_data '_balRes'
ShellBot.InlineKeyboardButton --button 'menu6' --line 2 --text '• All Reseller •️' --callback_data '_allRes'
ShellBot.InlineKeyboardButton --button 'menu6' --line 2 --text '• Delete Reseller •️' --callback_data '_delRes'
ShellBot.InlineKeyboardButton --button 'menu6' --line 3 --text '🔙 Back 🔙' --callback_data '_back6'
ShellBot.regHandleFunction --function resellerReq --callback_data _resellerReq
ShellBot.regHandleFunction --function balRes --callback_data _balRes
ShellBot.regHandleFunction --function allRes --callback_data _allRes
ShellBot.regHandleFunction --function delRes --callback_data _delRes
ShellBot.regHandleFunction --function backReq --callback_data _back6
unset keyboard6
keyboard6="$(ShellBot.InlineKeyboardMarkup -b 'menu6')"

unset menu7
menu7=''
ShellBot.InlineKeyboardButton --button 'menu7' --line 1 --text '• Claim Voucher •️' --callback_data '_claimvoucher'
ShellBot.regHandleFunction --function voucher_req --callback_data _claimvoucher
unset keyboard7
keyboard7="$(ShellBot.InlineKeyboardMarkup -b 'menu7')"

unset menu8
menu8=''
ShellBot.InlineKeyboardButton --button 'menu8' --line 1 --text '• Vmess •️' --callback_data '_vouchervmess'
ShellBot.InlineKeyboardButton --button 'menu8' --line 1 --text '• Vless •️' --callback_data '_vouchervless'
ShellBot.InlineKeyboardButton --button 'menu8' --line 2 --text '• Xtls •️' --callback_data '_voucherxtls'
ShellBot.InlineKeyboardButton --button 'menu8' --line 2 --text '• Trojan •️' --callback_data '_vouchertrojan'
ShellBot.InlineKeyboardButton --button 'menu8' --line 3 --text '• Ovpn •️' --callback_data '_voucherovpn'
ShellBot.regHandleFunction --function link_voucher --callback_data _vouchervmess
ShellBot.regHandleFunction --function link_voucher --callback_data _vouchervless
ShellBot.regHandleFunction --function link_voucher --callback_data _voucherxtls
ShellBot.regHandleFunction --function link_voucher --callback_data _vouchertrojan
ShellBot.regHandleFunction --function link_voucher --callback_data _voucherovpn
unset keyboard8
keyboard8="$(ShellBot.InlineKeyboardMarkup -b 'menu8')"

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
                '👤 Create User ssh-vpn 👤\n\n( Username Expired ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    user=$(cut -d' ' -f1 $CAD_ARQ)
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
                        duration=$(cut -d' ' -f2 $CAD_ARQ)
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
                        duration=30
			exp=30
                    fi
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    echo "$vouch $exp" >>/root/multi/voucher
		    exp1=$(date -d +${duration}days +%Y-%m-%d)
                    local msg
                    msg="User      = $user\n"
                    msg+="<code>Expired = $exp1</code>\n"
                    msg+="https://t.me/${get_botName}?start=ovpn_${user}_${vouch}\n\n"
                    msg+="Click Link To Confirm OVPN Acc\n"

                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$msg" \
                        --parse_mode html
                    ;;
                '👤 Create User Vmess 👤\n\n( Username Expired ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    user=$(cut -d' ' -f1 $CAD_ARQ)
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
                        duration=$(cut -d' ' -f2 $CAD_ARQ)
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
                        duration=30
			exp=30
                    fi
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^VM $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else
                        echo "$vouch $exp" >>/root/multi/voucher
			exp1=$(date -d +${duration}days +%Y-%m-%d)
                        local msg
                        msg="User      = $user\n"
                        msg+="<code>Expired = $exp1</code>\n"
                        msg+="https://t.me/${get_botName}?start=vmess_${user}_${vouch}\n\n"
                        msg+="Click Link To Confirm Vmess Acc\n"

                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$msg" \
                            --parse_mode html
	            fi
                    ;;
                '👤 Create User Vless 👤\n\n( Username Expired ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    user=$(cut -d' ' -f1 $CAD_ARQ)
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
                        duration=$(cut -d' ' -f2 $CAD_ARQ)
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
                        duration=30
			exp=30
                    fi
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^VL $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else       
                        echo "$vouch $exp" >>/root/multi/voucher
			exp1=$(date -d +${duration}days +%Y-%m-%d)
                        local msg
                        msg="User      = $user\n"
                        msg+="<code>Expired = $exp1</code>\n"
                        msg+="https://t.me/${get_botName}?start=vless_${user}_${vouch}\n\n"
                        msg+="Click Link To Confirm Vless Acc\n"

                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$msg" \
                            --parse_mode html
                    fi
                    ;;                    
		'👤 Create User Xtls 👤\n\n( Username Expired ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    user=$(cut -d' ' -f1 $CAD_ARQ)
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
                        duration=$(cut -d' ' -f2 $CAD_ARQ)
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
                        duration=30
			exp=30
                    fi
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^XTLS $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else       
                        echo "$vouch $exp" >>/root/multi/voucher
			exp1=$(date -d +${duration}days +%Y-%m-%d)
                        local msg
                        msg="User      = $user\n"
                        msg+="<code>Expired = $exp1</code>\n"
                        msg+="https://t.me/${get_botName}?start=xtls_${user}_${vouch}\n\n"
                        msg+="Click Link To Confirm bXtls Acc\n"

                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$msg" \
                            --parse_mode html
                    fi
                    ;;
                '👤 Create User Trojan 👤\n\n( Username Expired ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    reseller_balance
                    user=$(cut -d' ' -f1 $CAD_ARQ)
                    if [ "$(grep -wc ${message_from_id} /root/multi/reseller)" = '0' ]; then
                        duration=$(cut -d' ' -f2 $CAD_ARQ)
			exp=$(cut -d' ' -f2 $CAD_ARQ)
                    else
                        duration=30
			exp=30
                    fi
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    if grep -E "^TR $user" /usr/local/etc/xray/user.txt; then
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "User Already Exist ❗❗\n" \
                            --parse_mode html
                        exit 1
                    else      
                        echo "$vouch $exp" >>/root/multi/voucher
			exp1=$(date -d +${duration}days +%Y-%m-%d)
		        local msg
                        msg="User      = $user\n"
                        msg+="<code>Expired = $exp1</code>\n"
                        msg+="https://t.me/${get_botName}?start=trojan_${user}_${vouch}\n\n"
                        msg+="Click Link To Confirm Trojan Acc\n"

                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$msg" \
                            --parse_mode html
                    fi
                    ;;
                '👤 Create User Vmess free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start vmess_public${userfree}_free" >$CAD_ARQ
                    create_vmess $CAD_ARQ
                    ;;
                '👤 Create User Vless free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start vmess_public${userfree}_free" >$CAD_ARQ
                    create_vless $CAD_ARQ
                    ;;
                '👤 Create User Xtls free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start vmess_public${userfree}_free" >$CAD_ARQ
                    create_xtls $CAD_ARQ
                    ;;
                '👤 Create User Trojan free 👤\n\n( Username ) :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    userfree=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "start vmess_public${userfree}_free" >$CAD_ARQ
                    create_trojan $CAD_ARQ
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
		'👤 Create Vmess Trial 👤\n\n( Expired Days ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    trial_vm $CAD_ARQ
                    ;;
		'👤 Create Vless Trial 👤\n\n( Expired Days ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    trial_vl $CAD_ARQ
                    ;;
		'👤 Create Xtls Trial 👤\n\n( Expired Days ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    trial_xt $CAD_ARQ
                    ;;
		'👤 Create Trojan Trial 👤\n\n( Expired Days ) :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_balance
                    trial_tr $CAD_ARQ
                    ;;
                'Create Reseller :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "Reseller Balance :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Reseller Balance :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    reseller_input $CAD_ARQ
                    ;;
                'Add Balance Reseller :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "Add Balance :" \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Add Balance :')
                    echo "${message_text[$id]}" >>$CAD_ARQ
                    balance_reseller $CAD_ARQ
                    ;;
                'Delete Reseller :')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    delete_reseller $CAD_ARQ
                    ;;
                'Input Your Voucher:')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    input_voucher $CAD_ARQ
                    ;;
                'Voucher Validity:')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    vouch=$(tr </dev/urandom -dc a-zA-Z0-9 | head -c8)
                    exp=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    echo "$vouch $exp" >>/root/multi/voucher
                    local msg
                    msg="<code>Expired : $exp</code>\n"
                    msg+="Voucher : <code>$vouch</code>\n"
                    msg+="<a href='https://t.me/${get_botName}?start=voucher_${vouch}'>Click Here To Claim</a>\n"

                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$msg" \
                        --parse_mode html
                    ;;
                'Change Limit:')
                    echo "${message_text[$id]}" >$CAD_ARQ
                    freelim=$(sed -n '1 p' $CAD_ARQ | cut -d' ' -f1)
                    sed -i "/Limit/d" /root/multi/bot.conf
                    echo "Limit: $freelim" >>/root/multi/bot.conf
                    local msg
                    msg="Free Limit Successful Change To $freelim"
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                        --text "$msg" \
                        --parse_mode html
                    ;;
                esac
            fi
        ) &
    done
done
