#!/bin/sh

echo ""
echo "Iniciando execução do script $0"

usage() { echo "Usage: $0 [-p <package name>]" 1>&2; exit 1; }

while getopts p: option
do
        case "${option}"
        in
        p) _packageName=${OPTARG};;
        *) usage;;
        esac
done

if [ "$_packageName" = "" ];
then
        echo "Erro: parâmetro -p (package name) requerido !"
        usage
fi

echo "Verificando se o pacote '$_packageName' já está instalado ..."

if [ $(dpkg-query -W -f='${Status}' $_packageName 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo "Instalando '$_packageName' ..."
        apt-get -y -qq install $_packageName
        echo "'$_packageName' instalado com sucesso !"
else
        echo "Aviso: '$_packageName' já está instalado no sistema !"
fi

echo "Script $0 executado com sucesso !"

exit 0;
