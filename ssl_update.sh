#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

xray_qr_config_file="/usr/local/vmess_qr.json"
domain=$(grep '\"add\"' $xray_qr_config_file | awk -F '"' '{print $4}')

systemctl stop nginx &> /dev/null
sleep 1
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /dev/null
"/root/.acme.sh"/acme.sh --installcert -d ${domain} --fullchainpath /data/xray.crt --keypath /data/xray.key --ecc
sleep 1
chmod -f a+rw /data/xray.crt
chmod -f a+rw /data/xray.key
systemctl start nginx &> /dev/null
