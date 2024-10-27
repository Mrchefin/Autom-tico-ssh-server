#!/bin/bash

# Função para exibir o banner
show_banner() {
    echo "#############################################"
    echo "#                                           #"
    echo "#          PREPARAÇÃO DO AMBIENTE SSH        #"
    echo "#                                           #"
    echo "#############################################"
}

# Função para preparar o ambiente
prepare_environment() {
    local script_name="server.sh"

    echo "Dando permissões de execução para o script $script_name..."
    chmod +x $script_name

    echo "#############################################"
    echo "#                                           #"
    echo "#  PREPARAÇÃO COMPLETA!                      #"
    echo "#  Agora você pode executar o script:        #"
    echo "#  ./$script_name                            #"
    echo "#                                           #"
    echo "#############################################"
}

# Executar a preparação automaticamente

./$script_name
