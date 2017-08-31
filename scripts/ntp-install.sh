#!/bin/sh

. ./common.sh

echo ""
echo "Iniciando execução do script $0"

echo "Instalando pacotes do ntp ..."
executescript "package-install.sh -p ntp"
executescript "package-install.sh -p ntp-doc"

echo ""
echo "Script $0 executado com sucesso !"

exit 0;
