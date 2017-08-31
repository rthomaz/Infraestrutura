#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

echo "Fazendo download dos pacotes base ..."

wget -N --no-cache -O common.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/common.sh
chmod 700 common.sh

wget -N --no-cache -O package-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/package-install.sh
chmod 700 package-install.sh

# openssh-server
wget -N --no-cache -O openssh-server-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/openssh-server-install.sh
chmod 700 openssh-server-install.sh

wget -N --no-cache -O openssh-server-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/openssh-server-config.sh
chmod 700 openssh-server-config.sh

# clamav
wget -N --no-cache -O clamav-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/clamav-install.sh
chmod 700 clamav-install.sh

wget -N --no-cache -O clamav-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/clamav-config.sh
chmod 700 clamav-config.sh

# ntpdate
wget -N --no-cache -O ntpdate-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-install.sh
chmod 700 ntpdate-install.sh

wget -N --no-cache -O ntpdate-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-config.sh
chmod 700 ntpdate-config.sh

# ntp
wget -N --no-cache -O ntp-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntp-install.sh
chmod 700 ntp-install.sh

wget -N --no-cache -O ntp-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntp-config.sh
chmod 700 ntp-config.sh

# memberserver
wget -N --no-cache -O memberserver-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/memberserver-install.sh
chmod 700 memberserver-install.sh

echo ""
echo "Script $0 executado com sucesso !"
echo ""

./memberserver-install.sh

exit 0;