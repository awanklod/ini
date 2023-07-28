REPO="https://raw.githubusercontent.com/awanklod/ini/main/"
print_install "Memasang Service Limit Quota"
wget -q -O /usr/local/sbin/quota "${REPO}limit/quota"
chmod +x /usr/local/sbin/quota
chmod + x /usr/local/sbin/quota
cd /usr/local/sbin/
sed -i 's/\r//' quota
cd
wget -q -O /usr/bin/limit-all-ip "${REPO}limit/limit-all-ip.sh"
chmod +x /usr/bin/*
clear
#SERVICE LIMIT ALL IP
cat >/etc/systemd/system/all-ip.service << EOF
[Unit]
Description=My 
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-all-ip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart all-ip
systemctl enable all-ip
#SERVICE VMESS
cat >/etc/systemd/system/qmv.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota vmess
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmv
systemctl enable qmv

#SERVICE VLESS
cat >/etc/systemd/system/qmvl.service << EOF
[Unit]
Description=My 
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota vless
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmvl
systemctl enable qmvl

#SERVICE TROJAN
cat >/etc/systemd/system/qmtr.service << EOF
[Unit]
Description=My 
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota trojan
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmtr
systemctl enable qmtr
