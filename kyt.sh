NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
grenbo="[92;1m"
NC='[0m'
apt update && apt upgrade
apt install python3 python3-pip git
cd /usr/bin
wget https://raw.githubusercontent.com/duffer51/vvdip/main/ubuntu/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip
clear
wget https://raw.githubusercontent.com/duffer51/vvdip/main/ubuntu/kyt.zip
unzip kyt.zip
pip3 install -r kyt/requirements.txt
echo ""
echo -e "[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e " [1;97;101m          ADD BOT PANEL          [0m"
echo -e "[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
clear
cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target
[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always
[Install]
WantedBy=multi-user.target
END
systemctl start kyt
systemctl enable kyt
systemctl restart kyt
cd /root
rm -rf kyt.sh
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot         : $bottoken"
echo "Admin          : $admin"
echo "Domain        : $domain"
echo "Pub            : $PUB"
echo "Host           : $NS"
echo -e "==============================="
echo "Setting done"
clear
echo " Installations complete, type /menu on your bot"
