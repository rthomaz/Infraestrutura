#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

echo "Fazendo download dos pacotes base ..."

wget --no-cache -O common.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/common.sh
chmod 700 common.sh

wget --no-cache -O package-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/package-install.sh
chmod 700 package-install.sh

# clamav
wget --no-cache -O clamav-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/clamav-install.sh
chmod 700 clamav-install.sh

wget --no-cache -O clamav-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/clamav-config.sh
chmod 700 clamav-config.sh

# ntpdate
wget --no-cache -O ntpdate-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-install.sh
chmod 700 ntpdate-install.sh

wget --no-cache -O ntpdate-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-config.sh
chmod 700 ntpdate-config.sh

# ntp
wget --no-cache -O ntp-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntp-install.sh
chmod 700 ntp-install.sh

wget --no-cache -O ntp-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntp-config.sh
chmod 700 ntp-config.sh

echo ""
echo "Script $0 executado com sucesso !"
echo ""

exit 0;