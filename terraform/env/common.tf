locals {
  ssh_ip  = "192.168.11.12"
  keyfile = "~/.ssh/main"
}

module k8s-common-libvirt {
  source = "../modules/common"

  pool_path = "/var/kvm/terraform/images"
  ssh_ip  = local.ssh_ip
  keyfile = local.keyfile
}
