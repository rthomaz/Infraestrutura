#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

usage() { echo "Usage: $0 [-f <fqdn do pdc server>] [-i <static ip>]" 1>&2; exit 1; }

while getopts f:i: option
do
        case "${option}"
        in
        f) _pdc_server_fqdn=${OPTARG};;
        i) _ip=${OPTARG};;
        *) usage;;
        esac
done

if [ "$_pdc_server_fqdn" = "" ]; then
        echo "Erro: parâmetro -f (fqdn do pdc server) requerido !"
fi

if [ "$_ip" = "" ]; then
        echo "Erro: parâmetro -i (static ip) requerido !"
fi

if [ "$_pdc_server_fqdn" = "" ] || [ "$_ip" = "" ]; then
        usage
fi

echo "Verificando a existência da pasta source ..."
if [ ! -d "source" ]; then
		echo "Criando a pasta 'souce' ..."
        mkdir source
fi

. ./source/common.sh

echo "Fazendo download dos pacotes base ..."

wget --no-cache -O source/common.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/common.sh
chmod 700 source/common.sh

wget --no-cache -O source/package-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/package-install.sh
chmod 700 source/package-install.sh



# clamav
wget --no-cache -O source/clamav-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/clamav-install.sh
executescript "clamav-install.sh"
chmod 700 source/clamav-install.sh

wget --no-cache -O source/clamav-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/clamav-config.sh
executescript "clamav-config.sh"
chmod 700 source/clamav-config.sh

# ntpdate
wget --no-cache -O source/ntpdate-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-install.sh
executescript "ntpdate-install.sh"
chmod 700 source/ntpdate-install.sh

wget --no-cache -O source/ntpdate-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-config.sh
executescript "ntpdate-config.sh -n $_pdc_server_fqdn"
chmod 700 source/ntpdate-config.sh

# ntp
wget --no-cache -O source/ntp-install.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntp-install.sh
executescript "ntp-install.sh"
chmod 700 source/ntp-install.sh

wget --no-cache -O source/ntpdate-config.sh https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts/ntpdate-config.sh
executescript "ntp-config.sh -n $_pdc_server_fqdn"
chmod 700 source/ntpdate-config.sh

echo ""
echo "Script $0 executado com sucesso !"
echo ""

exit 0;