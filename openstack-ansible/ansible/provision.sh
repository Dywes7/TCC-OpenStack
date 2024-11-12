#!/bin/sh

# PASSOS ARA INSTALAÇÃO DO ANSIBLE

# Instalação repositório para poder instalar o Ansible
sudo yum -y install epel-release

echo "Inicio instalacao do ansible"

# Instalação ansible
sudo yum -y install ansible

# Modificando arquivo /etc/hosts para adicionar nomes dos hosts que vão ser gerenciados
cat <<EOT >> /etc/hosts
192.168.56.2 controller
192.168.56.3 compute1
192.168.56.4 compute2
192.168.56.5 ansible
EOT