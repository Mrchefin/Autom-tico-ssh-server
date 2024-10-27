#!/bin/bash

# Função para exibir o banner
show_banner() {
    echo "#############################################"
    echo "#                                           #"
    echo "#          CONFIGURAÇÃO DO SERVIDOR SSH      #"
    echo "#                                           #"
    echo "#############################################"
}

# Função para gerar uma senha aleatória
generate_password() {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 16
}

# Função para gerar uma porta aleatória
generate_port() {
    shuf -i 1024-65535 -n 1
}

# Função para configurar o servidor SSH
configure_ssh() {
    local username="usuario_$(date +%s)"
    local password=$(generate_password)
    local port=$(generate_port)

    echo "Atualizando pacotes do sistema..."
    sudo apt update

    echo "Instalando o servidor OpenSSH..."
    sudo apt install -y openssh-server

    echo "Fazendo backup do arquivo de configuração original..."
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

    echo "Configurando o servidor SSH..."
    sudo sed -i "s/#Port 22/Port $port/" /etc/ssh/sshd_config
    sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

    echo "Reiniciando o serviço SSH..."
    sudo systemctl restart ssh

    echo "Criando usuário $username..."
    sudo useradd -m -s /bin/bash $username
    echo "$username:$password" | sudo chpasswd

    echo "Exibindo o status do serviço SSH..."
    sudo systemctl status ssh

    echo "#############################################"
    echo "#                                           #"
    echo "#  CONFIGURAÇÃO COMPLETA!                    #"
    echo "#  Use o comando abaixo para acessar o SSH:  #"
    echo "#                                           #"
    echo "#############################################"
    echo "ssh $username@$(hostname -I | awk '{print $1}') -p $port"
    echo "Senha: $password"
}

# Executar a configuração automaticamente
clear
show_banner
configure_ssh

