#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://raw.githubusercontent.com/bagusid93/hss/main/sc3 > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}
# https://raw.githubusercontent.com/bagusid93/hss/main/sc3 
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/bagusid93/hss/main/sc3 | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/bagusid93/hss/main/sc3 | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 2
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 1

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

coreselect=''
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
END
chmod 644 /root/.profile

echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Alright good ... installation file is ready"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check permission : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted!"
else
red "Permission Denied!"
rm bantur.sh > /dev/null 2>&1
sleep 2
exit 0
fi
sleep 2
rm -rf /etc/per
mkdir -p /etc/{vmess,websocket,vless,trojan,shadowsocks}
mkdir -p /etc/julak/public_html
mkdir -p /var/log/xray/
touch /var/log/xray/{access.log,error.log}
chmod 777 /var/log/xray/*.log
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/ssh/.ssh.db
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/ssh/.ssh.db
touch /etc/shadowsocks/.shadowsocks.db
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/lokasi
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/lokasi/city
touch /etc/loksi/isp
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
mkdir -p /etc/dns
mkdir -p /etc/slowdns
touch /etc/slowdns/server.pub
touch /etc/slowdns/server.key
mkdir -p /etc/julak
mkdir -p /etc/julak/theme
mkdir -p /var/lib/julak >/dev/null 2>&1
echo "IP=" >> /var/lib/julak/ipvps.conf
clear
clear
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}|              MASUKKAN NAMA AUTHOR        |${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
read -rp "Masukan Nama Anda Disini : " -e pp
rm -rf /etc/profil
echo "$pp" > /etc/profil
echo ""
clear
author=$(cat /etc/profil)
echo ""
echo ""
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/tools.sh;chmod +x tools.sh;./tools.sh
rm tools.sh
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/api;chmod +x api;./api
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/menu/BotApi.sh;chmod +x BotApi.sh;./BotApi.sh
clear
yellow "Add Domain for vmess/vless/trojan dll"
echo " "
echo -e "$green      Please select a domain type below               $NC"
echo  ""
tyblue "   1 : Enter your Subdomain"
tyblue "   2 : Use a random Subdomain"
echo ""
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
read -rp "Input your domain : " -e pp
echo "$pp" > /root/domain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/v2ray/domain
echo "IP=$pp" > /var/lib/julak/ipvps.conf
echo ""
elif [[ $host == "2" ]]; then
#install cf
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/ssh/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
echo -e "Random Subdomain/Domain is used"
wget https://raw.githubusercontent.com/kdg-hss/punya93/main/ssh/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
fi
cat <<EOF>> /etc/julak/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/julak/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/julak/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/julak/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/julak/theme/magenta
BG : \E[40;1;95m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/julak/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/julak/theme/color.conf
magenta
EOF

#install ssh ovpn
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install Julak Bantur              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q https://raw.githubusercontent.com/julakhss/julakhss/main/JB5/julak-bantur.sh && chmod +x julak-bantur.sh && ./julak-bantur.sh
clear
#install Backup
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install BACKUP           $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q https://raw.githubusercontent.com/julakhss/julakhss/main/JB2/set-br.sh &&  chmod +x set-br.sh && ./set-br.sh
clear
#Instal Xray
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green       Install XRAY              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q https://raw.githubusercontent.com/julakhss/julakhss/main/JB5/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
#install file
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install Yang Janda Janda                $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q https://raw.githubusercontent.com/julakhss/julakhss/main/JB1/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
#install slowdns
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install SLOWDNS                $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/slowdns/installsl.sh && chmod +x installsl.sh && ./installsl.sh
clear
#install ssh ohp
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green       Install OHP               $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/OPENVPN/ohp.sh && chmod +x ohp.sh && ./ohp.sh
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/ssh/notif.sh;chmod +x notif.sh;./notif.sh
clear
#install limit xray
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green       Install Limit Xray               $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/ssh/limit.sh && chmod +x limit.sh && ./limit.sh
clear
wget -q https://raw.githubusercontent.com/julakhss/julakhss/main/JB7/tunlp;chmod +x tunlp;./tunlp
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green       Install Linak Waluh                $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/ssh/swapkvm.sh && chmod +x swapkvm.sh && ./swapkvm.sh
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green       Install Udp Custom                $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Klto36D2R5vjfEbyDILadU6MMaZcVZVq' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Klto36D2R5vjfEbyDILadU6MMaZcVZVq" -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green       Install Barang Bagus                $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q https://raw.githubusercontent.com/julakhss/julakhss/main/JB10/ins-menu.sh && chmod +x ins-menu.sh && ./ins-menu.sh
clear
wget -q https://raw.githubusercontent.com/kdg-hss/punya93/main/ssh/julak;chmod +x julak;./julak
rm julak
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/kdg-hss/punya93/main/versi )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps
echo " "
echo "=====================-[ SCRIPT PAPADA'AN STORE ]-===================="
echo ""
echo "------------------------------------------------------------"
echo ""
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenVPN		: 2086"  | tee -a log-install.txt
echo "   - OpenSSH		: 22"  | tee -a log-install.txt
echo "   - SSH Websocket	: 80 [ON]" | tee -a log-install.txt
echo "   - SSH SSL Websocket	: 443" | tee -a log-install.txt
echo "   - Stunnel4		: 445, 8443" | tee -a log-install.txt
echo "   - Dropbear		: 109, 143" | tee -a log-install.txt
echo "   - Badvpn		: 7100-7900" | tee -a log-install.txt
echo "   - Nginx		: 81" | tee -a log-install.txt
echo "   - Vmess TLS		: 443" | tee -a log-install.txt
echo "   - Vmess None TLS	: 80" | tee -a log-install.txt
echo "   - Vless TLS		: 443" | tee -a log-install.txt
echo "   - Vless None TLS	: 80" | tee -a log-install.txt
echo "   - Trojan GRPC		: 443" | tee -a log-install.txt
echo "   - Trojan WS		: 443" | tee -a log-install.txt
echo "   - Trojan None TLS		: 80" | tee -a log-install.txt
echo "   - Port Alternatif		: 8080,8880,2082,2052" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone		: Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban		: [ON]"  | tee -a log-install.txt
echo "   - Dflate		: [ON]"  | tee -a log-install.txt
echo "   - IPtables		: [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot		: [ON]"  | tee -a log-install.txt
echo "   - IPv6			: [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On	: $aureb:00 $gg GMT +7" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Change port" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------"
echo ""
echo "===============-[ PAPADA'AN STORE ]-==============="
echo -e ""
echo ""
echo "" | tee -a log-install.txt
rm /root/bantur.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/julak.bantur.sh >/dev/null 2>&1
rm /root/*.sh >/dev/null 2>&1
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e ""
echo "JulakBantur"
sleep 1
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
