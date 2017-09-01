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

echo "Fazendo download dos pacotes base ..."

getpackage(){
	packagename=$1
	baseurl="http://dev02-pc/linux_scripts"
	wget --no-cache -O $packagename $baseurl/$packagename
	chmod 700 $packagename
	sed -i 's/\r//g' $packagename
}

# core
getpackage "common.sh"

. ./common.sh

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





# openssh-server
executescript "openssh-server-install.sh"
executescript "openssh-server-config.sh -i $_ip"

# clamav
executescript "clamav-install.sh"
executescript "clamav-config.sh"

# ntpdate
executescript "ntpdate-install.sh"
executescript "ntpdate-config.sh -n $_pdc_server_fqdn"

# ntp
executescript "ntp-install.sh"
executescript "ntp-config.sh -n $_pdc_server_fqdn"

echo ""
echo "Script $0 executado com sucesso !"
echo ""

exit 0;