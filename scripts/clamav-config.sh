#!/bin/sh

. ./common.sh

echo ""
echo "Iniciando execução do script $0"

_confpath="/etc/clamav/freshclam.conf"

backupfile $_confpath

echo "Criando novo ficheiro $_confpath ..."

cat > $_confpath << EOF

DatabaseOwner clamav
UpdateLogFile /var/log/clamav/freshclam.log
LogVerbose false
LogSyslog false
LogFacility LOG_LOCAL6
LogFileMaxSize 0
LogRotate true
LogTime true
Foreground false
Debug false
MaxAttempts 5
DatabaseDirectory /var/lib/clamav
DNSDatabaseInfo current.cvd.clamav.net
ConnectTimeout 30
ReceiveTimeout 30
TestDatabases yes
ScriptedUpdates yes
CompressLocalDatabase no
SafeBrowsing false
Bytecode true
NotifyClamd /etc/clamav/clamd.conf
# Check for new database 24 times a day
Checks 24
DatabaseMirror db.local.clamav.net
DatabaseMirror database.clamav.net


EOF

echo "Ficheiro criado com sucesso !"

echo "Script $0 executado com sucesso !"

exit 0;
