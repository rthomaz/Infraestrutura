#!/bin/sh

. ./common.sh

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

_confpath="/etc/ntp.conf"

backupfile $_confpath

echo "Criando novo ficheiro $_confpath ..."

cat > $_confpath << EOF

# Local clock. Note that is not the "localhost" address!
server 127.127.1.0
fudge  127.127.1.0 stratum 10

# Where to retrieve the time from
server   $_ntp                         iburst prefer
# server bdc-server.rthomaz.local      iburst

driftfile /var/lib/ntp/ntp.drift
logfile   /var/log/ntp

# Access control
# Default restriction: Disallow everything
restrict default ignore

# No restrictions for "localhost"
restrict 127.0.0.1

# Enable the time sources only to only provide time to this host
restrict   $_ntp                       mask 255.255.255.255    nomodify notrap nopeer noquery
# restrict bdc-server.rthomaz.local    mask 255.255.255.255    nomodify notrap nopeer noquery

EOF

echo "Ficheiro criado com sucesso !"
