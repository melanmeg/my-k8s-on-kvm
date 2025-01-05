module k8s-lb-libvirt {
  source = "../modules/vm"

  vm_count  = 1
  vm_name   = "test-k8s-lb" # $VM_NAME-$VM_COUNT
  vcpu      = 1
  memory    = 3072
  size      = 10 # GiB
  autostart = false
  first_ip  = "192.168.11.131" # $FIRST_IP + $VM_COUNT

  base_volume_id = module.k8s-common-libvirt.base_volume_id
  pool_name      = module.k8s-common-libvirt.pool_name
  ssh_ip         = local.ssh_ip
  keyfile        = local.keyfile
}

module k8s-cp-libvirt {
  source = "../modules/vm"

  vm_count  = 1
  vm_name   = "test-k8s-cp" # $VM_NAME-$VM_COUNT
  vcpu      = 4
  memory    = 8192 # In case of 4096, oomkilled by argocd
  size      = 30 # GiB
  autostart = false
  first_ip  = "192.168.11.141" # $FIRST_IP + $VM_COUNT

  base_volume_id = module.k8s-common-libvirt.base_volume_id
  pool_name      = module.k8s-common-libvirt.pool_name
  ssh_ip         = local.ssh_ip
  keyfile        = local.keyfile
}

module k8s-wk-libvirt {
  source = "../modules/vm"

  vm_count    = 3
  vm_name     = "test-k8s-wk" # $VM_NAME-$VM_COUNT
  vcpu        = 8
  memory      = 16384
  size        = 30 # GiB
  data_disk_1 = {
    enable = true
    size   = 40 # GiB
  }
  data_disk_2 = {
    enable = true
    size   = 40 # GiB
  }
  autostart   = false
  first_ip    = "192.168.11.151" # $FIRST_IP + $VM_COUNT

  base_volume_id = module.k8s-common-libvirt.base_volume_id
  pool_name      = module.k8s-common-libvirt.pool_name
  ssh_ip         = local.ssh_ip
  keyfile        = local.keyfile
}
