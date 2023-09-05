#!/bin/bash
echo "Updating package lists"
apt update
echo "Installing mosh, squid and apache2-utils"
apt install -y mosh squid apache2-utils
echo "Allowing udp traffic on port range 60000:61000"
ufw allow 60000:61000/udp
echo "Creating user jihane in password file"
htpasswd -c /etc/squid/passwords jihane
echo "Restarting squid service"
systemctl restart squid.service
echo "Allowing tcp traffic on port 3128"
ufw allow 3128
echo "Restarting squid service"
systemctl restart squid.service