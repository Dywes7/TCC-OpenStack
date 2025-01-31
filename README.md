# Implantação de Cluster OpenStack com Ansible

Este repositório contém scripts Ansible para a implantação de um cluster OpenStack utilizando o Ubuntu Server 22.04.03 LTS. Os scripts automatizam a instalação e configuração do OpenStack versão 23.1 Antelope em múltiplos nós, incluindo um controlador, nós de computação e um nó de armazenamento.

## Pré-requisitos
- **Sistema Operacional:** Ubuntu Server 22.04.03 LTS instalado em todas as máquinas do cluster.
- **Ansible:** Instalado em um nó de controle (preferencialmente um notebook).
- **Hardware:** 
  - Nós gerais: Partição de 40 GB para o sistema operacional e sistema de arquivos.
  - Nó de armazenamento: HDD de 500 GB com uma partição total disponível.

## Configuração Inicial
1. **Instale o Ubuntu Server** em todos os nós com o mesmo nome de usuário e senha.
2. **Configure IPs privados fixos** para todas as máquinas para garantir conectividade estável.
3. **Padronize os nomes das interfaces de rede** nos nós de computação para funcionamento consistente do script de automação.
4. **Exporte e distribua as chaves públicas SSH** do servidor de controle Ansible para todos os nós para login SSH sem senha.

## Configuração de Hosts Ansible
Configurar o arquivo `/etc/ansible/hosts` no servidor Ansible para incluir os endereços IP dos nós do cluster, categorizados de acordo com suas funções no ambiente:

```yaml
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
