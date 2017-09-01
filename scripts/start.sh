#!/bin/sh

if [ -d "infra" ]; then
        rm -rf infra
fi
mkdir infra
wget --no-cache -O infra/memberserver-install.sh http://dev02-pc/linux_scripts/memberserver-install.sh
chmod 700 infra/memberserver-install.sh
sed -i 's/\r//g' infra/memberserver-install.sh
cd infra
./memberserver-install.sh -f pdc-server.rthomaz.local -i 192.168.1.100

exit 0;
