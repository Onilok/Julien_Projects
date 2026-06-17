resource "local_file" "inventory" {
  filename = pathexpand("../ansible/inventory.ini")

  content = templatefile("${path.module}/templates/inventory.ini.tpl", {
    bastion_public_ips           = module.bastion.public_ips
    traefik_private_ips          = module.traefik.private_ips
    prometheus_private_ips       = module.prometheus.private_ips
    k3s_master_prd_private_ips   = module.k3s_masters.master_private_ips
    k3s_master_stg_private_ips   = module.k3s_masters_stg.master_private_ips
    k3s_worker_stg_private_ips   = module.k3s_workers_stg.worker_private_ips

  })
}

resource "local_file" "ssh_config" {
  filename = pathexpand("~/.ssh/config")

  content = templatefile("${path.module}/templates/ssh_config.tpl", {
    bastion_public_ips           = module.bastion.public_ips
    traefik_private_ips          = module.traefik.private_ips
    prometheus_private_ips       = module.prometheus.private_ips
    k3s_master_prd_private_ips   = module.k3s_masters.master_private_ips
    k3s_master_stg_private_ips   = module.k3s_masters_stg.master_private_ips
    k3s_worker_stg_private_ips   = module.k3s_workers_stg.worker_private_ips
  })
}

resource "local_file" "dynamic_3a" {
  filename = pathexpand("../ansible/roles/traefik/master/files/dynamic.yml")

  content = templatefile("${path.module}/templates/dynamic.yml.3a.tpl", {
    k3s_master_prd_private_ips   = module.k3s_masters.master_private_ips
    k3s_master_stg_private_ips   = module.k3s_masters_stg.master_private_ips
    k3s_worker_stg_private_ips   = module.k3s_workers_stg.worker_private_ips
  })
}

resource "local_file" "dynamic_3b" {
  filename = pathexpand("../ansible/roles/traefik/slave/files/dynamic.yml")

  content = templatefile("${path.module}/templates/dynamic.yml.3b.tpl", {
    k3s_master_prd_private_ips   = module.k3s_masters.master_private_ips
    k3s_master_stg_private_ips   = module.k3s_masters_stg.master_private_ips
    k3s_worker_stg_private_ips   = module.k3s_workers_stg.worker_private_ips
  })
}

