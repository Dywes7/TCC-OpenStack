# Implementação de um Cluster OpenStack com Ansible

Este repositório contém os scripts e instruções necessários para a implementação de um cluster OpenStack utilizando Ansible para automação. O sistema operacional utilizado é o Ubuntu Server 22.04.03 LTS, e a versão do OpenStack implementada é a 23.1 Antelope.

## Pré-requisitos

- **Sistema Operacional**: Ubuntu Server 22.04.03 LTS instalado em todas as máquinas do cluster.
- **Ansible**: Instalado em um notebook ou máquina que atuará como servidor de controle.
- **Acesso SSH**: Configuração de chaves SSH para comunicação sem senha entre o servidor Ansible e os nós do cluster.

## Configuração do Ambiente

### 1. Instalação do Sistema Operacional

- Instale o Ubuntu Server 22.04.03 LTS em todas as máquinas do cluster.
- Crie um usuário comum (`ifce`) com a mesma senha em todas as máquinas.
- Configure o espaço de disco conforme necessário:
  - **Nós de Computação e Controlador**: Utilize uma partição de 40 GB para o sistema operacional e sistema de arquivos.
  - **Nó de Armazenamento**: Formate um disco de 500 GB e crie uma partição com o espaço total disponível.

### 2. Configuração de IP Fixo

- Atribua um IP fixo privado a cada máquina na rede local.
- Exemplo de configuração:
  - Controlador: `10.50.7.11`
  - Nós de Computação: `10.50.7.12`, `10.50.7.25`, `10.50.7.35`
  - Nó de Armazenamento: `10.50.7.25`

### 3. Configuração das Interfaces de Rede

- Padronize o nome das interfaces de rede físicas nos nós de computação para `enp250`.

### 4. Configuração do SSH

- Exporte a chave SSH pública do servidor Ansible e adicione-a ao arquivo `/home/ifce/.ssh/authorized_keys` em cada nó do cluster.

### 5. Configuração do Arquivo `/etc/ansible/hosts`

- Configure o arquivo `/etc/ansible/hosts` no servidor Ansible para incluir os IPs dos nós do cluster, categorizados por função:

```ini
[cluster]
10.50.7.11
10.50.7.12
10.50.7.25
10.50.7.35

[controller]
10.50.7.11

[computes]
10.50.7.12
10.50.7.25
10.50.7.35

[storage]
10.50.7.25
