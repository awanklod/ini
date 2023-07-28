#!/bin/bash
#Decrypted By YADDY D PHREAKER
#!/bin/bash
# Created by CLOUDVPN
# Lock User.
red='\e[31m'
green='\e[32m'
blue='\e[34m'
NC='\e[0m'
clear
echo -e "${green}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${green}| \E[44;1;39m                °LOCK ACCOUNT°             \E[0m|"
echo -e "${green}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"

echo -e "\e[36m------------------------------------------\e[0m"
read -p "※ Enter Username To Be Lock : " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
# proses mengganti passwordnya
passwd -l $username
clear
  echo " ";
	echo " ";
	echo " ";
	echo " ";
	echo -e " \e[36m※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※
 ※                                 ※
 ※\e[0m   WELCOME MY SYSTEM CLOUDVPN \e[36m※
 ※                                 ※
 ※\e[0m   \e[35mTelegram\e[0m    \e[36m:\e[0m \e[33m@amiqyu\e[0m    \e[36m※
  ※                                 ※
 ※\e[0m        \e[31m©\e[0m CLOUDVPN™ \e[31m®\e[0m         \e[36m※
 ※                                 ※
 ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※\e[0m";
	echo "
 ◎ Your Account Status ◎";
  echo " "
  echo -e "  \e[34m※\e[0m Username : ${blue}$username${NC}";
  echo -e "  \e[31m※\e[0m Status   : ${red}LOCKED${NC}";
  echo " ";
  echo " ★ POWER BY CLOUDVPN™ SERVER ★";
  echo " ";
	echo " ";
	echo " ";
	echo " ";
else
echo "Username ${red}$username${NC} Does Not Exist ..!"
    exit 1
fi
