#!/bin/sh

. ./common.sh

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