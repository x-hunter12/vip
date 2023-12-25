#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/rmbl/theme/color.conf)
export NC="\e[0m"
export YELLOW='\033[0;33m';
export RED="\033[0;31m"
export COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
export COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########
ipsaya=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/zhets/izinsc/main/ip"
checking_sc() {
useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│            ${RED}PERMISSION DENIED !${NC}                  │"
echo -e "$COLOR1│   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}           │"
echo -e "$COLOR1│     \033[0;33mBuy access permissions for scripts${NC}          │"
echo -e "$COLOR1│             \033[0;33mContact Your Admin ${NC}                 │"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
exit
fi
}
checking_sc

clear
echo ""
echo " This Feature Can Only Be Used According To VPS Data With This Autoscript"
echo " Please Insert VPS Data Backup Link To Restore The Data"
echo ""
read -rp "Link File: " -e url
cd
mkdir -p /root/backup
wget -O backup.zip "$url"
unzip backup.zip  &> /dev/null
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
echo -e "[ ${green}INFO${NC} ] Start Restore . . . "
cp -r passwd /etc/ &> /dev/null
cp -r group /etc/ &> /dev/null
cp -r shadow /etc/ &> /dev/null
cp -r xray /etc/xray/config.json &> /dev/null
cp -r ssh /etc/xray/ssh &> /dev/null
cp -r idchat /usr/bin/idchat &> /dev/null
cp -r token /usr/bin/token &> /dev/null
cp -r id /etc/per/id &> /dev/null
cp -r token2 /etc/per/token &> /dev/null
cp -r loginid /etc/perlogin/id &> /dev/null
cp -r logintoken /etc/perlogin/token &> /dev/null
#cp gshadow /etc/ /etc/ &> /dev/null
#cp -r /root/backup/.acme.sh /root/ &> /dev/null
#cp -r /root/backup/xray /etc/ &> /dev/null
#cp -r /root/backup/conf.d /etc/nginx/ &> /dev/null
cp -r public_html /home/vps/ &> /dev/null
#cp -r crontab /etc/ &> /dev/null
#cp -r cron.d /etc/ &> /dev/null
cp -r gshadow /etc/ &> /dev/null
cp -r sshx /etc/xray/ &> /dev/null
cp -r vmess /etc/ &> /dev/null
cp -r vless /etc/ &> /dev/null
cp -r trojan /etc/ &> /dev/null
cp -r issue /etc/issue.net &> /dev/null
echo ""
echo -e "[ ${green}INFO${NC} ] VPS Data Restore Complete !"
echo ""
echo -e "[ ${green}INFO${NC} ] Restart All Service"
systemctl restart xray
systemctl restart nginx
cd
rm -rf *
sleep 0.5
read -n 1 -s -r -p "Press any key to back on menu"
menu
