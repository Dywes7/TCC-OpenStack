# Implementação de um Cluster OpenStack com Ansible

Este repositório contém os scripts e instruções necessários para a implementação de um cluster OpenStack utilizando Ansible para automação. O sistema operacional utilizado é o Ubuntu Server 22.04.03 LTS, e a versão do OpenStack implementada é a 23.1 Antelope.

## Pré-requisitos

- **Sistema Operacional**: Ubuntu Server 22.04.03 LTS instalado em todas as máquinas do cluster.
- **Ansible**: Instalado em um notebook ou máquina que atuará como servidor de controle.
- **Acesso SSH**: Configuração de chaves SSH para comunicação sem senha entre o servidor Ansible e os nós do cluster.

## Configuração do Ambiente

### 1. Instalação do Sistema Operacional

- Instale o Ubuntu Server 22.04.03 LTS em todas as máquinas do cluster.
- Crie um usuário comum (`nomeusuario`) com a mesma senha em todas as máquinas.
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

- Exporte a chave SSH pública do servidor Ansible e adicione-a ao arquivo `/home/nomeusuario/.ssh/authorized_keys` em cada nó do cluster.

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

```

## Testes de Conexão e Configuração do Cluster

### Testes de Conexão

Execute os seguintes comandos no servidor Ansible para testar a conectividade com os nós do cluster:

```bash
ansible -m ping cluster -u nomeusuario
ansible -m ping controller -u nomeusuario
ansible -m ping computes -u nomeusuario
ansible -m ping storage -u nomeusuario
```

## Configuração das Variáveis do Cluster

### 1. Clonagem do Repositório

Clone o repositório contendo os scripts de configuração:

```bash
git clone <repositório>

```

## Configuração do Arquivo `vars/main.yaml`

Edite o arquivo `openstack-ansible/ansible/playbooks/vars/main.yaml` com as seguintes variáveis:

```yaml
ansible_user: nomeusuario
hostname_controller: "controller"
ip_controller: "10.50.7.11"
hostname_ansible: "ansible"
ip_ansible: "192.168.0.24"
ip_storage: "10.50.7.25"
subrede: "10.50.7.0/26"
ntp_server: "200.160.7.186"
name_nic_controller: "enp250"
name_nic_computes: "enp250"
ip_provider_network_controller: "10.50.7.11"
name_disc_storage: sda
name_disc_storage_part: sda2
name_disc_conservar_so: sda

computes:
- hostname: "compute1"
  ip: "10.50.7.12"
- hostname: "compute2"
  ip: "10.50.7.25"
- hostname: "compute3"
  ip: "10.50.7.35"
```
## Configuração das Senhas

Defina as senhas para os serviços do OpenStack no arquivo `openstack-ansible/ansible/playbooks/vars/pass.yaml`.

## Execução do Playbook

Acesse o diretório `openstack-ansible/ansible/playbooks` e execute o playbook principal:

```bash
ansible-playbook ./install_openstack.yaml --ask-become-pass
```

Insira a senha do usuário `nomeusuario` quando solicitado.

