Host penpot-tower-az1
Hostname ${bastion_public_ips[0]}
User admin
Port 22
IdentityFile ~/.ssh/bastion-sshkey

Host penpot-tower-az2
Hostname ${bastion_public_ips[1]}
User admin
Port 22
IdentityFile ~/.ssh/bastion-sshkey

Host penpot-bastion-az1
Hostname ${bastion_public_ips[0]}
User bastion
Port 4242
IdentityFile ~/.ssh/bastion-sshkey
IdentitiesOnly yes

Host penpot-bastion-az2
Hostname ${bastion_public_ips[1]}
User bastion
Port 4242
IdentityFile ~/.ssh/bastion-sshkey
IdentitiesOnly yes

Host penpot-traefik-az1
HostName ${traefik_private_ips[0]}
User admin
IdentityFile ~/.ssh/traefik-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host penpot-traefik-az2
HostName ${traefik_private_ips[1]}
User admin
IdentityFile ~/.ssh/traefik-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

Host penpot-prometheus-az1
Hostname ${prometheus_private_ips[0]}
User admin
IdentityFile ~/.ssh/prometheus-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host penpot-prometheus-az2
Hostname ${prometheus_private_ips[1]}
User admin
IdentityFile ~/.ssh/prometheus-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

Host k3s-master-1
HostName ${k3s_master_prd_private_ips[0]}
User admin
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host k3s-slave-1
HostName ${k3s_master_prd_private_ips[2]}
User admin
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host k3s-slave-2
HostName ${k3s_master_prd_private_ips[4]}
User admin
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host k3s-master-2
HostName ${k3s_master_prd_private_ips[1]}
User admin
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

Host k3s-slave-3
HostName ${k3s_master_prd_private_ips[3]}
User admin
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

Host k3s-slave-4
HostName ${k3s_master_prd_private_ips[5]}
User admin
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

Host k3s-stg-master-1
Hostname ${k3s_master_stg_private_ips[0]}
User admin
Port 22
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host k3s-stg-master-2
Hostname ${k3s_master_stg_private_ips[1]}
User admin
Port 22
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

Host k3s-stg-worker-1
Hostname ${k3s_worker_stg_private_ips[0]}
User admin
Port 22
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az1

Host k3s-stg-worker-2
Hostname ${k3s_worker_stg_private_ips[1]}
User admin
Port 22
IdentityFile ~/.ssh/k3s-sshkey
IdentitiesOnly yes
ProxyJump penpot-bastion-az2

