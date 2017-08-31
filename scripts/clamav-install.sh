#!/bin/sh

. ./common.sh

echo ""
echo "Iniciando execução do script $0"

echo "Instalando pacotes do ClamAv ..."
executescript "package-install.sh -p clamav"
executescript "package-install.sh -p clamav-daemon"
executescript "package-install.sh -p clamav-freshclam"

echo "Instalando documentação ..."
executescript "package-install.sh -p clamav-docs"

echo "Instalando pacotes de verificação de ficheiros compactados ..."
executescript "package-install.sh -p arc"
executescript "package-install.sh -p arj"
executescript "package-install.sh -p bzip2"
executescript "package-install.sh -p cabextract"
executescript "package-install.sh -p lzop"
executescript "package-install.sh -p nomarch"
executescript "package-install.sh -p p7zip-full"
executescript "package-install.sh -p pax"
executescript "package-install.sh -p tnef"
executescript "package-install.sh -p unrar-free"
executescript "package-install.sh -p unzip"
executescript "package-install.sh -p zoo"

echo "Instalando pacotes de verificação de ficheiros compactados unrar ..."
executescript "package-install.sh -p libclamunrar6"
executescript "package-install.sh -p unrar"

echo ""
echo "Script $0 executado com sucesso !"

exit 0;
