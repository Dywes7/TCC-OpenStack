# openstack_ansible

1. EDITAR ARQUIVO 'pre_requisitos/pre_requisitos1.yaml' e inserir linhas "{{ip_computex}} {{hostname_computex}}" para novos computes 

2. Adicioanr novas variáveis em vars/main.yaml adicionando nova variável para 'hostname_computex' e 'ip_computex' inserindo o hostname e ip

3. Adicionar hosts no servidor ansible em /etc/ansible/hosts

4. Executar playbook

5. Configurar as interfaces com o OpenVSwtich
    
        Para o controller passos 1 a 5. Para os computes todos menos passo 2.
    
        1. Editar /etc/neutron/plugins/ml2/openvswitch_agent.ini
        	[ovs]
        	bridge_mappings = provider:br-provider
        
    
        2. Editar /etc/neutron/plugins/ml2/ml2_conf.ini
        	[ml2_type_flat]
        	flat_networks = * 
    
        3. Realizar o comando do OpenVSwitch
        	# ovs-vsctl add-br br-provider
    
        4. Editar interface em /etc/netplan/interface.yaml
        	trocar interface real por interface criada do OpenVswitch (br-prodiver)
        	e deixar a interface real apenas com outro IP para não perder conexão SSH
        
        5. Realizar o comando do OpenVSwitch
        	# ovs-vsctl add-port br-provider {{ physnet }}