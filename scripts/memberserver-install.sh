#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

usage() { echo "Usage: $0 [-f <hot name do pdc server>] [-i <static ip address>] [-h <host name>] [-m <netmask address>] [-n <network address>] [-b <broadcast address>] [-g <gateway address>] [-d <domain name>] [-a <dns ip address>] [-e <network interface>]" 1>&2; exit 1; }

while getopts f:i:h:m:n:b:g:d:a:e: option
do
        case "${option}"
        in
        f) _pdchostname=${OPTARG};;
        i) _ip=${OPTARG};;
		h) _hostname=${OPTARG};;
        m) _netmask=${OPTARG};;
		n) _network=${OPTARG};;
		b) _broadcast=${OPTARG};;
		g) _gateway=${OPTARG};;
		d) _domainname=${OPTARG};;
		a) _dns=${OPTARG};;
		e) _networkinterface=${OPTARG};;
        *) usage;;
        esac
done

if [ "$_pdchostname" = "" ]; then
        echo "Erro: parâmetro -f (host name do pdc server) requerido !"
fi

if [ "$_ip" = "" ]; then
        echo "Erro: parâmetro -i (static ip) requerido !"
fi

if [ "$_hostname" = "" ]; then
        echo "Erro: parâmetro -h (host name) requerido !"
fi

if [ "$_netmask" = "" ]; then
        echo "Erro: parâmetro -m (netmask address) requerido !"
fi

if [ "$_network" = "" ]; then
        echo "Erro: parâmetro -n (network address) requerido !"
fi

if [ "$_broadcast" = "" ]; then
        echo "Erro: parâmetro -b (broadcast address) requerido !"
fi

if [ "$_gateway" = "" ]; then
        echo "Erro: parâmetro -g (gateway address) requerido !"
fi

if [ "$_domainname" = "" ]; then
        echo "Erro: parâmetro -d (domain name) requerido !"
fi

if [ "$_dns" = "" ]; then
        echo "Erro: parâmetro -a (dns ip address) requerido !"
fi

if [ "$_networkinterface" = "" ]; then
        echo "Erro: parâmetro -e (network interface) requerido !"
fi

if [ "$_pdchostname" = "" ] || [ "$_ip" = "" ] || [ "$_hostname" = "" ] || [ "$_netmask" = "" ] || [ "$_network" = "" ] || [ "$_broadcast" = "" ] || [ "$_gateway" = "" ] || [ "$_domainname" = "" ] || [ "$_dns" = "" ] || [ "$_networkinterface" = "" ]; then
        usage
fi

echo "Fazendo download dos pacotes base ..."

getpackage(){
	packagename=$1
	#baseurl="https://raw.githubusercontent.com/rthomaz/Infraestrutura/master/scripts"
	baseurl="http://dev02-pc/linux_scripts"
	wget --no-cache -O $packagename $baseurl/$packagename
	chmod 700 $packagename
	sed -i 's/\r//g' $packagename
}

# core
getpackage "common.sh"

. ./common.sh

getpackage "package-install.sh"

# network
getpackage "network-config.sh"

# apt-jessie
getpackage "apt-jessie-config.sh"

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



# network
executescript "network-config.sh -i $_ip -h $_hostname -m $_netmask -n $_network -b $_broadcast -g $_gateway -d $_domainname -a $_dns -e $_networkinterface"

# apt-jessie
executescript "apt-jessie-config.sh"

# openssh-server
executescript "openssh-server-install.sh"
executescript "openssh-server-config.sh -i $_ip"

# clamav
executescript "clamav-install.sh"
executescript "clamav-config.sh"

# ntpdate
executescript "ntpdate-install.sh"
executescript "ntpdate-config.sh -n $_pdchostname.$_domainname"

# ntp
executescript "ntp-install.sh"
executescript "ntp-config.sh -n $_pdchostname.$_domainname"

echo ""
echo "Script $0 executado com sucesso !"
echo ""

exit 0;