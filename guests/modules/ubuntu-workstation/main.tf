provider "libvirt" {
  uri = "qemu:///system"
}

resource "random_string" "random_id" {
  length = 8
  special = false
}

resource "libvirt_network" "ubuntu" {
  name      = "ubuntu"
  mode      = "nat"
  domain    = "ubuntu.local"
  addresses = ["10.77.7.0/24"]
  dns {
    enabled    = true
    local_only = true
  }
}

resource "libvirt_pool" "ubuntu" {
  name = "ubuntu-pool"
  type = "dir"
  path = "/tmp/ubuntu-pool"
}

resource "libvirt_pool" "ubuntu_root" {
  name = "ubuntu-root-pool"
  type = "dir"
  path = "/tmp/ubuntu-root-pool"
}

resource "libvirt_volume" "ubuntu_image" {
  name   = "ubuntu"
  pool   = libvirt_pool.ubuntu_root.name
  source = var.ubuntu_1604_base
  format = "qcow2"
}

resource "libvirt_volume" "primary_disk" {
  name = "ubuntu_primary_disk"
  pool = libvirt_pool.ubuntu_root.name
  base_volume_id = libvirt_volume.ubuntu_image.id
  size = 30000000000
}

resource "libvirt_cloudinit_disk" "ubuntuinit" {
  name           = "ubuntuinit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.ubuntu.name
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_domain" "domain-ubuntu" {
  name   = "ubuntu-${random_string.random_id.result}"
  memory = var.memory
  vcpu   = var.cpus

  cloudinit = libvirt_cloudinit_disk.ubuntuinit.id

  network_interface {
    network_id = libvirt_network.ubuntu.id
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.ubuntu_image.id
  }

  disk {
    volume_id = libvirt_volume.primary_disk.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
