provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_domain" "machine" {
  name   = var.name
  memory = var.memory
  vcpu   = var.vcpus
  running = var.running

  cloudinit = var.cloud_init

  network_interface {
    network_id = var.network
    hostname = var.name
    wait_for_lease = var.wait_for_lease
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

  dynamic "disk" {
    for_each = var.disks
    content {
      volume_id = disk.value
    }
  }

  dynamic "disk" {
    for_each = var.iso
    content {
      file = disk.value
    }
  }

  graphics {
    type        = var.graphics_type
    listen_type = "address"
    autoport    = true
  }

  video {
    type = var.video_mode
  }
}
