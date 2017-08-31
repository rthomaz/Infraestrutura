#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

usage() { echo "Usage: $0 [-n <ntp server address>]" 1>&2; exit 1; }

while getopts n: option
do
        case "${option}"
        in
        n) _ntp=${OPTARG};;
        *) usage;;
        esac
done

if [ "$_ntp" = "" ];
then
        echo "Erro: parâmetro -n (ntp server) requerido !"
        usage
fi

echo "Sincronizando o relógio do sistema com o NTP Server:" $_ntp
ntpdate $_ntp
echo "Relógio sincronizado com sucesso !"

echo "Script $0 executado com sucesso !"

exit 0;
