#!/bin/sh

. ./common.sh

echo ""
echo "Iniciando execução do script $0"

echo "Instalando pacotes do openssh-server ..."
executescript "package-install.sh -p openssh-server"

echo ""
echo "Script $0 executado com sucesso !"

exit 0;
