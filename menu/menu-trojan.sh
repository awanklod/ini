#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/ssnvpn/theme/color.conf)
NC="\e[0m"
RED='\e[1;32m' 
BLUE='\033[0;35m'
###########- END COLOR CODE -##########
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
function cektrojan(){
clear
function con() {
    local -i bytes=$1;
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes}B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$(( (bytes + 1023)/1024 ))KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$(( (bytes + 1048575)/1048576 ))MB"
    else
        echo "$(( (bytes + 1073741823)/1073741824 ))GB"
    fi
}
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "              TROJAN USER LOGIN            $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "   User"     "       Last Login"    "  Usage"   " Total IP"
echo -e "\033[1;91m┌──────────────────────────────────────────┐\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojan.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
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
jum2=$(cat /tmp/iptrojan.txt | wc -l)
byte=$(cat /etc/trojan/${akun})
lim=$(con ${byte})
wey=$(cat /etc/limit/trojan/${akun})
gb=$(con ${wey})
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
printf "  %-13s %-7s %-8s %2s\n"   "${akun}" "$lastlogin"  " ${gb}/${lim}"   "$jum2";
fi 
rm -rf /tmp/iptrojan.txt
done
rm -rf /tmp/other.txt
echo ""
echo -e "\033[1;91m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "        Autoscript Mod by cloudvpn        "
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-trojan
}

function deltrojan(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC}  • You Dont have any existing clients!"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$BLUE│${NC}"
echo -e "$BLUE│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-trojan
else
exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC}   • Accound Delete Successfully"
echo -e "$BLUE│${NC}"
echo -e "$BLUE│${NC}   • Client Name : $user"
echo -e "$BLUE│${NC}   • Expired On  : $exp"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}              • CLOUDVPN •            $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
}

function renewtrojan(){
clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}            • RENEW TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$BLUE│${NC}  • You have no existing clients!"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}              • CLOUDVPN •            $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}            • RENEW TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$BLUE│${NC}"
echo -e "$BLUE│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-trojan
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#! $user/c\#! $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}            • RENEW TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$BLUE│${NC}   "
echo -e "$BLUE│${NC}   Client Name : $user"
echo -e "$BLUE│${NC}   Days Added  : $masaaktif Days"
echo -e "$BLUE│${NC}   Expired On  : $exp4"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
}

function addtrojan(){
source /var/lib/ssnvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
read -rp "   Input Username : " -e user
if [ -z $user ]; then
echo -e "$BLUE│${NC}   [Error] Username cannot be empty "
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
user_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
if [[ ${user_EXISTS} == '1' ]]; then
clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC}  Please choose another name."
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
read -n 1 -s -r -p "   Press any key to back on menu"
trojan-menu
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
read -p "Limit User (GB): " Quota
read -p "Limit User (IP): " iplimit
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
trojanlink="trojan://${uuid}@bug.com:${tr}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
if [ ! -e /etc/trojan ]; then
  mkdir -p /etc/trojan
fi

if [[ $iplimit -gt 0 ]]; then
mkdir -p /etc/kyt/limit/trojan/ip
echo -e "$iplimit" > /etc/kyt/limit/trojan/ip/$user
else
echo > /dev/null
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/trojan/${user}
fi
DATADB=$(cat /etc/trojan/.trojan.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
fi
echo "### ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/trojan/.trojan.db
clear
cat >/home/vps/public_html/trojan-$user.yaml <<-END

# Format Trojan GO/WS

- name: Trojan-$user-GO/WS
  server: ${domain}
  port: 443
  type: trojan
  password: ${uuid}
  network: ws
  sni: ${domain}
  skip-cert-verify: true
  udp: true
  ws-opts:
    path: /trojan-ws
    headers:
        Host: ${domain}

# Format Trojan gRPC

- name: Trojan-$user-gRPC
  type: trojan
  server: ${domain}
  port: 443
  password: ${uuid}
  udp: true
  sni: ${domain}
  skip-cert-verify: true
  network: grpc
  grpc-opts:
    grpc-service-name: trojan-grpc

END

echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}           • CREATE TROJAN USER •              ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE ${NC} Remarks     : ${user}" 
echo -e "$BLUE ${NC} Expired On  : $exp" 
echo -e "$BLUE ${NC} Host/IP     : ${domain}"
echo -e "$BLUE ${NC} User Quota    : ${Quota} GB"
echo -e "$BLUE ${NC} User Ip       : ${iplimit} IP"
echo -e "$BLUE ${NC} Port        : ${tr}" 
echo -e "$BLUE ${NC} Key         : ${uuid}" 
echo -e "$BLUE ${NC} Path        : /trojan-ws"
echo -e "$BLUE ${NC} Path WSS    : wss://bug.com/trojan-ws" 
echo -e "$BLUE ${NC} ServiceName : trojan-grpc" 
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE ${NC} Link WS : "
echo -e "$BLUE ${NC} ${trojanlink}" 
echo -e "$BLUE  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$${NC} "
echo -e "$BLUE ${NC} Link GRPC : "
echo -e "$BLUE ${NC} ${trojanlink1}"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$BLUE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC} "
echo -e "Format OpenClash : http://${domain}:81/trojan-$user.yaml"
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
}


clear
echo -e "$BLUE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$BLUE│${NC} ${COLBG1}              • TROJAN PANEL MENU •            ${NC} $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}"
echo -e " $BLUE┌───────────────────────────────────────────────┐${NC}"
echo -e " $BLUE│$NC   ${BLUE}[01]${NC} • ADD TROJAN    ${BLUE}[03]${NC} • DELETE TROJAN${NC}   $BLUE│$NC"
echo -e " $BLUE│$NC   ${BLUE}[02]${NC} • RENEW TROJAN${NC}  ${BLUE}[04]${NC} • USER ONLINE     $BLUE│$NC"
echo -e " $BLUE│$NC                                              ${NC} $BLUE│$NC"
echo -e " $BLUE│$NC   ${BLUE}[00]${NC} • GO BACK${NC}                              $BLUE│$NC"
echo -e " $BLUE└───────────────────────────────────────────────┘${NC}"
echo -e "$BLUE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$BLUE│${NC}                 • CLOUDVPN •                 $BLUE│$NC"
echo -e "$BLUE└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addtrojan ;;
02 | 2) clear ; renewtrojan ;;
03 | 3) clear ; deltrojan ;;
04 | 4) clear ; cektrojan ;;
00 | 0) clear ; menu ;;
*) clear ; menu-trojan ;;
esac

       
