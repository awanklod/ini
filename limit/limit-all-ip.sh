#!/bin/bash

function send_log(){
CHATID="1210833546"
KEY="6013860299:AAEJj7Sr6Cc_fxCOR9Oj8V0EedNj7PriVv8"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="
<code>────────────────────</code>
<b>⚠️NOTIF LIMIT IP KYT⚠️</b>
<code>────────────────────</code>
<code>Username  : </code><code>$user</code>
<code>Limit Ip    : </code><code>$jum2</code>
<code>────────────────────</code>
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
function limit_all_ip(){
#LIMITVMESSIP
echo -n > /var/log/xray/access.log
sleep 4
data=( `ls /etc/kyt/limit/vmess/ip`);
#Decrypted By YADDY D PHREAKER
    for user in "${data[@]}"
    do
        iplimit=$(cat /etc/kyt/limit/vmess/ip/$user)
        ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
        cekcek=$(echo -e "$ehh" | wc -l);
        if [[ $cekcek -gt $iplimit ]]; then
            exp=$(grep -w "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                  sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
                  sed -i "/^### $user $exp/d" /etc/vmess/.vmess.db
                  systemctl restart xray >> /dev/null 2>&1
                  jum2=$(cat /tmp/ipvmess.txt | wc -l)
                  rm -rf /etc/kyt/limit/vmess/ip/$user
                  send_log
                else
            echo ""
        fi
        sleep 0.1
    done
#LIMITVLESSIP
echo -n > /var/log/xray/access.log
sleep 4
data=( `ls /etc/kyt/limit/vless/ip`);
#Decrypted By YADDY D PHREAKER
    for user in "${data[@]}"
    do
        iplimit=$(cat /etc/kyt/limit/vless/ip/$user)
        ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
        cekcek=$(echo -e "$ehh" | wc -l);
        if [[ $cekcek -gt $iplimit ]]; then
            exp=$(grep -w "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                  sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
                  sed -i "/^### $user $exp/d" /etc/vless/.vless.db
                  systemctl restart xray >> /dev/null 2>&1
                  jum2=$(cat /tmp/ipvless.txt | wc -l)
                  rm -rf /etc/kyt/limit/vless/ip/$user
                  send_log
                else
            echo ""
        fi
        sleep 0.1
    done
#LIMITIPTROJAN
echo -n > /var/log/xray/access.log
sleep 4
data=( `ls /etc/kyt/limit/trojan/ip`);
#Decrypted By YADDY D PHREAKER
    for user in "${data[@]}"
    do
        iplimit=$(cat /etc/kyt/limit/trojan/ip/$user)
        ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
        cekcek=$(echo -e "$ehh" | wc -l);
        if [[ $cekcek -gt $iplimit ]]; then
            exp=$(grep -w "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                  sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
                  sed -i "/^### $user $exp/d" /etc/trojan/.trojan.db
                  systemctl restart xray >> /dev/null 2>&1
                  jum2=$(cat /tmp/iptrojan.txt | wc -l)
                  rm -rf /etc/kyt/limit/trojan/ip/$user
                  send_log
                else
            echo ""
        fi
        sleep 0.1
    done
#LIMITIPSHADOWSOCKS
echo -n > /var/log/xray/access.log
sleep 4
data=( `ls /etc/kyt/limit/shadowsocks/ip`);
#Decrypted By YADDY D PHREAKER
    for user in "${data[@]}"
    do
        iplimit=$(cat /etc/kyt/limit/shadowsocks/ip/$user)
        ehh=$(cat /var/log/xray/access.log | grep "$user" | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq);
        cekcek=$(echo -e "$ehh" | wc -l);
        if [[ $cekcek -gt $iplimit ]]; then
            exp=$(grep -w "^## $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
                  sed -i "/^## $user $exp/,/^},{/d" /etc/xray/config.json
                  sed -i "/^### $user $exp/d" /etc/shadowsocks/.shadowsocks.db
                  systemctl restart xray >> /dev/null 2>&1
                  jum2=$(cat /tmp/ipshadowsocks.txt | wc -l)
                  rm -rf /etc/kyt/limit/shadowsocks/ip/$user
                  send_log
                else
            echo ""
        fi
        sleep 0.1
    done
limit_all_ip


