#!/bin/sh

. ./common.sh

echo ""
echo "Iniciando execução do script $0"

_confpath="/etc/apt/sources.list"

backupfile $_confpath

echo "Criando novo ficheiro $_confpath ..."

cat > $_confpath << EOF

# deb cdrom:[Debian GNU/Linux 8.0.0 _Jessie_ - Official amd64 NETINST Binary-1 20150425-12:50]/ jessie main

#deb cdrom:[Debian GNU/Linux 8.0.0 _Jessie_ - Official amd64 NETINST Binary-1 20150425-12:50]/ jessie main

deb http://ftp.pt.debian.org/debian/ jessie main contrib non-free
# deb-src http://ftp.pt.debian.org/debian/ jessie main

deb http://security.debian.org/ jessie/updates main contrib non-free
# deb-src http://security.debian.org/ jessie/updates main

# jessie-updates, previously known as 'volatile'
deb http://ftp.pt.debian.org/debian/ jessie-updates main contrib non-free
# deb-src http://ftp.pt.debian.org/debian/ jessie-updates main

# debian-backports
deb http://ftp.debian.org/debian jessie-backports main contrib non-free

EOF

echo "Ficheiro criado com sucesso !"

echo "Atualizando os repositórios ..."

apt-get update

echo "Repositórios atualizados com sucesso !"

echo "Script $0 executado com sucesso !"

exit 0;
