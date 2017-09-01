#!/bin/sh

if [ -d "infra" ]; then
        rm -rf infra
fi
mkdir infra
wget --no-cache -O infra/memberserver-install.sh http://dev02-pc/linux_scripts/memberserver-install.sh
chmod 700 infra/memberserver-install.sh
sed -i 's/\r//g' infra/memberserver-install.sh
cd infra
./memberserver-install.sh -f pdc-server -i 192.168.1.110 -h admin-server -m 255.255.255.0 -n 192.168.1.0 -b 192.168.1.255 -g 192.168.1.1 -d rthomaz.local -a 192.168.1.100 -e eth0

exit 0;
