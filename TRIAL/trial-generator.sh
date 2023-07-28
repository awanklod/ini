export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
clear
echo -e "${PURPLE}=================================="
echo -e "${LIGHT} TRIAL GENERATOR BY CLOUDVPN"


echo -e "${PURPLE}=================================="
echo -e "${LIGHT}"
echo -e " Akumulasi Trial minimal 1 menit"
echo -e ""
echo -e " 1).TRIAL AKUN SSH & slowdns"
echo -e " 3).TRIAL AKUN VMESS"
echo -e " 4).TRIAL AKUN VLESS"
echo -e " 5).TRIAL AKUN TROJAN"
echo -e "${PURPLE}==================================="

read -p "PILIH NOMOR: " bro
echo -e ""
case $bro in
1) clear ; trial-ssh ;;
2) clear ; trial-vmess ;;
3) clear ; trial-vless ;;
4) clear ; trial-trojan ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
