#!/bin/sh

executescript() {
        sh $1
        sh_result=$?
        if [ $sh_result = 1 ]; then
                echo ""
                echo "Erro: Ocorreu um erro na execução do comando 'sh $1'"
                exit 1;
        fi
        return $sh_result
}

backupfile() {
        _path=$1
        echo "Verificando se já existe backup do ficheiro $_path ..."
        if [ ! -f $_path.original ]; then
                echo "Backup inexistente, criando backup original do ficheiro $_path ..."
                if [ ! -f $_path ]; then
                        echo "Aviso: Não foi possível criar a arquivo de backup $_path.original pela falta do arquivo $_path !!!"
                else
                        mv $_path $_path.original
                        echo "Backup $_path.original criado com sucesso !"
                fi
        else
                echo "Backup existente !!!"
        fi
}
