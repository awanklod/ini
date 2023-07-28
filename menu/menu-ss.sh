#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e '\''s/< Date: //'\'')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
RED='\''\033[0;31m'\''

NC='\''\033[0m'\''

GREEN='\''\033[0;32m'\''

ORANGE='\''\033[0;33m'\''

BLUE='\''\033[0;34m'\''

PURPLE='\''\033[0;35m'\''

CYAN='\''\033[0;36m'\''

LIGHT='\''\033[0;37m'\''
###########- END COLOR CODE -##########
red='\''\e[1;31m'\''
ORANGE='\''\e[1;32m'\''
NC='\''\e[0m'\''
ORANGE() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
function addssws(){
clear
domain=$(cat /etc/xray/domain)

echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}             • CREATE SSWS USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
tls="$(cat ~/log-install.txt | grep -w "Sodosok WS/GRPC" | cut -d: -f2|sed '\''s/ //g'\'')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '\''0'\'' ]]; do
read -rp "   Input Username : " -e user
if [ -z $user ]; then
echo -e "$ORANGE│${NC} [Error] Username cannot be empty "
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

if [[ ${CLIENT_EXISTS} == '\''1'\'' ]]; then
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}             • CREATE SSWS USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} Please choose another name."
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
		fi
	done

cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
echo -e "$COLOR1 ${NC} User Quota    : ${Quota} GB"
echo -e "$COLOR1 ${NC} User Ip       : ${iplimit} IP"
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '\''/#ssws$/a\## '\''"$user $exp"'\''\
},{"password": "'\''""$uuid""'\''","method": "'\''""$cipher""'\''","email": "'\''""$user""'\''"'\'' /etc/xray/config.json
sed -i '\''/#ssgrpc$/a\## '\''"$user $exp"'\''\
},{"password": "'\''""$uuid""'\''","method": "'\''""$cipher""'\''","email": "'\''""$user""'\''"'\'' /etc/xray/config.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/ss-ws;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"
systemctl restart xray
rm -rf /tmp/log
rm -rf /tmp/log1
cat > /home/vps/public_html/ss-ws/ss-$user.txt <<-END
# sodosok ws
{ 
 "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        },
        "wsSettings": {
          "headers": {
            "Host": "$domain"
          },
          "path": "/ss-ws"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
 }
 
 # SODOSOK grpc


{
    "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "$domain",
            "level": 8,
            "method": "$cipher",
            "password": "$uuid",
            "port": 443
          }
        ]
      },
      "streamSettings": {
        "grpcSettings": {
          "multiMode": true,
          "serviceName": "ss-grpc"
        },
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "isi_bug_disini"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
END
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
if [ ! -e /etc/shadowsocks ]; then
  mkdir -p /etc/shadowsocks
fi

if [[ $iplimit -gt 0 ]]; then
mkdir -p /etc/kyt/limit/shadowsocks/ip
echo -e "$iplimit" > /etc/kyt/limit/shadowsocks/ip/$user
else
echo > /dev/null
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/shadowsocks/${user}
fi
DATADB=$(cat /etc/shadowsocks/.shadowsocks.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/shadowsocks/.shadowsocks.db
fi
echo "### ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/shadowsocks/.shadowsocks.db
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}             • CREATE SSWS USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} Remarks     : ${user}" 
echo -e "$COLOR1 ${NC} Expired On  : $exp"  
echo -e "$COLOR1 ${NC} Domain      : ${domain}"  
echo -e "$COLOR1 ${NC} User Quota    : ${Quota} GB"
echo -e "$COLOR1 ${NC} User Ip       : ${iplimit} IP"
echo -e "$COLOR1 ${NC} Port TLS    : ${tls}"  
echo -e "$COLOR1 ${NC} Port  GRPC  : ${tls}" 
echo -e "$COLOR1 ${NC} Password    : ${uuid}"  
echo -e "$COLOR1 ${NC} Cipers      : aes-128-gcm"  
echo -e "$COLOR1 ${NC} Network     : ws/grpc"  
echo -e "$COLOR1 ${NC} Path        : /ss-ws"  
echo -e "$COLOR1 ${NC} ServiceName : ss-grpc"  
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} Link TLS : "
echo -e "$COLOR1 ${NC} ${shadowsockslink}"  
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1 ${NC} Link GRPC : "
echo -e "$COLOR1 ${NC} ${shadowsockslink1}"  
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1 ${NC} Link JSON : http://${domain}:81/ss-ws/ss-$user.txt"  
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""  
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
}

function renewssws(){
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}              • RENEW SSWS USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^## " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '\''0'\'' ]]; then
echo -e "$ORANGE│${NC}  • You have no existing clients!"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}              • RENEW SSWS USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
grep -E "^## " "/etc/xray/config.json" | cut -d '\'' '\'' -f 2-3 | column -t | sort | uniq | nl
echo -e "$ORANGE│${NC}"
echo -e "$ORANGE│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-ss
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^## $user" "/etc/xray/config.json" | cut -d '\'' '\'' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/## $user/c\## $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}              • RENEW SSWS USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$COLOR1│${NC}   "
echo -e "$COLOR1│${NC}   Client Name : $user"
echo -e "$COLOR1│${NC}   Days Added  : $masaaktif Days"
echo -e "$COLOR1│${NC}   Expired On  : $exp4"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
}

function delssws(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^## " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '\''0'\'' ]]; then
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC}  • You Dont have any existing clients!"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
grep -E "^## " "/etc/xray/config.json" | cut -d '\'' '\'' -f 2-3 | column -t | sort | uniq | nl
echo -e "$ORANGE│${NC}"
echo -e "$ORANGE│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-ss
else
exp=$(grep -wE "^## $user" "/etc/xray/config.json" | cut -d '\'' '\'' -f 3 | sort | uniq)
sed -i "/^## $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
rm /home/vps/public_html/ss-ws/ss-$user.txt
clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}           • DELETE TROJAN USER •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound Delete Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-ss
fi
}

function cekssws(){
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
data=( `cat /etc/xray/config.json | grep '##' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "              VLESS USER LOGIN            $NC"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e "   User"     "       Last Login"    "  Usage"   " Total IP"
echo -e "\033[1;91m┌──────────────────────────────────────────┐\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipshadowsocks.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipshadowsocks.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipshadowsocks.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipshadowsocks.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipshadowsocks.txt | wc -l)
byte=$(cat /etc/shadowsocks/${akun})
lim=$(con ${byte})
wey=$(cat /etc/limit/shadowsocks/${akun})
gb=$(con ${wey})
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
printf "  %-13s %-7s %-8s %2s\n"   "${akun}" "$lastlogin"  " ${gb}/${lim}"   "$jum2";
fi 
rm -rf /tmp/ipshadowsocks.txt
done
rm -rf /tmp/other.txt
echo ""
echo -e "\033[1;91m└──────────────────────────────────────────┘\033[0m"
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "        Autoscript Mod by cloudvpn        "
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu-ss
}

clear
echo -e "$ORANGE┌─────────────────────────────────────────────────┐${NC}"
echo -e "$ORANGE│${NC} ${COLBG1}              • SSWS PANEL MENU •              ${NC} $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}"
echo -e " $ORANGE┌───────────────────────────────────────────────┐${NC}"
echo -e " $COLOR1│$NC   ${COLOR1}[01]${NC} • ADD SSWS      ${COLOR1}[03]${NC} • DELETE SSWS${NC}     $COLOR1│$NC"
echo -e " $COLOR1│$NC   ${COLOR1}[02]${NC} • RENEW SSWS${NC}    ${COLOR1}[04]${NC} • USER ONLINE     $COLOR1│$NC"
echo -e " $COLOR1│$NC                                              ${NC} $COLOR1│$NC"
echo -e " $COLOR1│$NC   ${COLOR1}[00]${NC} • GO BACK${NC}                              $COLOR1│$NC"
echo -e " $ORANGE└───────────────────────────────────────────────┘${NC}"
echo -e "$ORANGE┌────────────────────── BY ───────────────────────┐${NC}"
echo -e "$ORANGE│${NC}                 • CLOUDVPN •                 $COLOR1│$NC"
echo -e "$ORANGE└─────────────────────────────────────────────────┘${NC}" 
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addssws ;;
02 | 2) clear ; renewssws ;;
03 | 3) clear ; delssws ;;
04 | 4) clear ; cekssws ;;
00 | 0) clear ; menu ;;
*) clear ; menu-ss ;;
esac
