cd
MYIP=$(wget -qO- ipv4.icanhazip.com)
apt install jq curl -y
DOMAIN=chapeey.shop
CF_ID=chegesam064@gmail.com
CF_KEY=zZ1poADbXOyDheuit-sOLndF7vBIHd8pvnMDu7LY  # New API token
generate_subdomain() {
echo "$(</dev/urandom tr -dc a-z0-9 | head -c5).${DOMAIN}"
}
check_subdomain_exists() {
local subdomain=$1
local zone_id=$2
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records?name=${subdomain}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
[[ "${#RECORD}" -gt 10 ]]
}
set -euo pipefail
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
while true; do
sub=$(generate_subdomain)
if ! check_subdomain_exists "${sub}" "${ZONE}"; then
break
fi
done
echo "Using subdomain: ${sub}"
echo "Updating DNS for ${sub}..."
IP=$(wget -qO- ipv4.icanhazip.com)
curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${sub}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id
echo "$sub" > /root/domain
echo "$sub" > /root/scdomain
echo "$sub" > /etc/xray/domain
echo "$sub" > /etc/v2ray/domain
echo "$sub" > /etc/xray/scdomain
echo "IP=$sub" > /var/lib/kyt/ipvps.conf
cd
