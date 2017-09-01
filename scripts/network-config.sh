#!/bin/sh

. ./common.sh

echo ""
echo "Iniciando execução do script $0"

usage() { echo "Usage: $0 [-i <static ip address>] [-h <host name>] [-m <netmask address>] [-n <network address>] [-b <broadcast address>] [-g <gateway address>] [-d <domain name>] [-a <dns ip address>] [-e <network interface>]" 1>&2; exit 1; }

while getopts i:h:m:n:b:g:d:a:e: option
do
        case "${option}"
        in
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

if [ "$_ip" = "" ] || [ "$_hostname" = "" ] || [ "$_netmask" = "" ] || [ "$_network" = "" ] || [ "$_broadcast" = "" ] || [ "$_gateway" = "" ] || [ "$_domainname" = "" ] || [ "$_dns" = "" ] || [ "$_networkinterface" = "" ];; then
        usage
fi


### Antes de alterar a configuração, a interface de rede deve ser parada

echo "Pausando a interface $_networkinterface ..."
ifdown $_networkinterface

### Configurando interfaces

_interfacesconfpath="/etc/network/interfaces"

backupfile $_interfacesconfpath

echo "Criando novo ficheiro $_interfacesconfpath ..."

cat > $_interfacesconfpath << EOF

# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# Static IP address
auto $_networkinterface
iface $_networkinterface inet static
        address $_ip
        netmask $_netmask
        network $_network
        broadcast $_broadcast
        gateway $_gateway
        dns-search $_domainname
        dns-nameservers $_dns

EOF

echo "Ficheiro $_interfacesconfpath criado com sucesso !"

### Configurando resolv.conf

_resolvconfpath="/etc/resolv.conf"

backupfile $_resolvconfpath

echo "Criando novo ficheiro $_resolvconfpath ..."

cat > $_resolvconfpath << EOF

domain $_domainname
search $_domainname
nameserver $_dns

EOF

echo "Ficheiro $_resolvconfpath criado com sucesso !"

### Reiniciar a interface de rede para ativar a nova configuração

echo "Reiniciando a interface $_networkinterface ..."
ifup $_networkinterface

### Configurando hostname

_hostnameconfpath="/etc/hostname"

backupfile $_hostnameconfpath

echo "Criando novo ficheiro $_hostnameconfpath ..."

cat > $_hostnameconfpath << EOF

$_hostname

EOF

echo "Ficheiro $_hostnameconfpath criado com sucesso !"

echo "Aplicando o novo nome de host ..."
hostname -F /etc/hostname

### Configurando hosts

_hostsconfpath="/etc/hosts"

backupfile $_hostsconfpath

echo "Criando novo ficheiro $_hostsconfpath ..."

cat > $_hostsconfpath << EOF

127.0.0.1       localhost
$_ip  $_hostname.$_domainname $_hostname

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

EOF

echo "Ficheiro $_hostsconfpath criado com sucesso !"




echo "Script $0 executado com sucesso !"

exit 0;
