dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
red() { echo -e "\033[32;1m${*}\033[0m"; }
clear
fun_bar() {
CMD[0]="$1"
CMD[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${CMD[0]} -y >/dev/null 2>&1
${CMD[1]} -y >/dev/null 2>&1
touch $HOME/fim
) >/dev/null 2>&1 &
tput civis
echo -ne "  [0;33mPlease Wait Loading [1;37m- [0;33m["
while true; do
for ((i = 0; i < 18; i++)); do
echo -ne "[0;32m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "[0;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  [0;33mPlease Wait Loading [1;37m- [0;33m["
done
echo -e "[0;33m][1;37m -[1;32m OK ![1;37m"
tput cnorm
}
res1() {
wget https://raw.githubusercontent.com/duffer51/vvdip/main/ubuntu/menu.zip
unzip menu.zip
chmod +x menu/*
mv menu/* /usr/local/sbin
rm -rf menu
rm -rf menu.zip
rm -rf update.sh
}
netfilter-persistent
clear
echo -e "[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e " [1;97;101m          UPDATED SCRIPT POWERED BY CHAPEEY      [0m"
echo -e "[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e ""
echo -e "  [1;91m update script service[1;37m"
fun_bar 'res1'
echo -e "[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m"
echo -e ""
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
