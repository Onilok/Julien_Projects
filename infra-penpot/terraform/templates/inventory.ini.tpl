# inventory.ini template files

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

# ---- #
# PROD #
# ---- #

[tower]
penpot-tower-az1 ansible_host=${bastion_public_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/bastion-sshkey
penpot-tower-az2 ansible_host=${bastion_public_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/bastion-sshkey

[bastion]
penpot-bastion-az1 ansible_host=${bastion_public_ips[0]} ansible_user=bastion ansible_ssh_private_key_file=~/.ssh/bastion-sshkey
penpot-bastion-az2 ansible_host=${bastion_public_ips[1]} ansible_user=bastion ansible_ssh_private_key_file=~/.ssh/bastion-sshkey

[traefik]
penpot-traefik-az1 ansible_host=${traefik_private_ips[0]} leader=true ansible_user=admin ansible_ssh_private_key_file=~/.ssh/traefik-sshkey
penpot-traefik-az2 ansible_host=${traefik_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/traefik-sshkey

[monitoring]
penpot-prometheus-az1 ansible_host=${prometheus_private_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/prometheus-sshkey
penpot-premetheus-az2 ansible_host=${prometheus_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/prometheus-sshkey

[k3s_prd_masters]
k3s-master-1 ansible_host=${k3s_master_prd_private_ips[0]} master=true ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey
k3s-master-2 ansible_host=${k3s_master_prd_private_ips[1]} master=true ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_prd_master_3a]
k3s-master-1 ansible_host=${k3s_master_prd_private_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_prd_master_3b]
k3s-master-2 ansible_host=${k3s_master_prd_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_prd_master_slave_3a]
k3s-slave-1 ansible_host=${k3s_master_prd_private_ips[2]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey
k3s-slave-2 ansible_host=${k3s_master_prd_private_ips[4]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_prd_master_slave_3b]
k3s-slave-3 ansible_host=${k3s_master_prd_private_ips[3]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey
k3s-slave-4 ansible_host=${k3s_master_prd_private_ips[5]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_prd_masters_slave:children]
k3s_prd_master_slave_3a
k3s_prd_master_slave_3b


# ------- #
# Staging #
# ------- #

[k3s_stg_masters]
k3s-stg-master-1 ansible_host=${k3s_master_stg_private_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey 
k3s-stg-master-2 ansible_host=${k3s_master_stg_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_stg_master_3a]
k3s-stg-master-1 ansible_host=${k3s_master_stg_private_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_stg_master_3b]
k3s-stg-master-2 ansible_host=${k3s_master_stg_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_stg_worker_3a]
k3s-stg-worker-1 ansible_host=${k3s_worker_stg_private_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_stg_worker_3b]
k3s-stg-worker-2 ansible_host=${k3s_worker_stg_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[k3s_stg_workers:children]
k3s_stg_worker_3a
k3s_stg_worker_3b

[penpot_stg_az1]
${k3s_master_stg_private_ips[0]} master=true ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey
${k3s_worker_stg_private_ips[0]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

[penpot_stg_az2]
${k3s_master_stg_private_ips[1]} master=true ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey
${k3s_worker_stg_private_ips[1]} ansible_user=admin ansible_ssh_private_key_file=~/.ssh/k3s-sshkey

