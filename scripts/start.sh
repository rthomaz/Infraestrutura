#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

echo "Fazendo download dos pacotes base ..."

getpackage(){
	packagename=$1
	# baseurl="https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts"	
	baseurl="http://dev02-pc/linux_scripts"	
	wget --no-cache -O infra/$packagename $baseurl/$packagename
	chmod 700 infra/$packagename
	sed -i 's/\r//g' infra/$packagename
}

if [ ! -d "infra" ]; then
	echo "Criando diretório de 'infra' ..."	
	mkdir infra
fi

# core
getpackage "common.sh"
getpackage "package-install.sh"

# openssh-server
getpackage "openssh-server-install.sh"
getpackage "openssh-server-config.sh"

# clamav
getpackage "clamav-install.sh"
getpackage "clamav-config.sh"

# ntpdate
getpackage "ntpdate-install.sh"
getpackage "ntpdate-config.sh"

# ntp
getpackage "ntp-install.sh"
getpackage "ntp-config.sh"

# memberserver
getpackage "memberserver-install.sh"

echo ""
echo "Script $0 executado com sucesso !"
echo ""

exit 0;