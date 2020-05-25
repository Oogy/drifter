module "vultr_workstation" {
  source = "../modules/machine"

  name       = "vultr"
  memory     = 2048
  vcpus      = 2
  cloud_init = data.terraform_remote_state.cloudinit.outputs.vultr_workstation
  disks      = [ data.terraform_remote_state.storage.outputs.vultr_workstation ]
  network    = data.terraform_remote_state.networking.outputs.work.id
  video_mode = "vga"
  running    = false
}

module "kali_live" {
  source = "../modules/machine"

  name       = "kali"
  memory     = 2048
  vcpus      = 2
  disks      = [data.terraform_remote_state.images.outputs.kali_live]
  network    = data.terraform_remote_state.networking.outputs.secure.id
  video_mode = "vga"
  running    = false
}

module "ubuntu_live_test" {
  source = "../modules/machine"

  name          = "focal"
  memory        = 4096
  vcpus         = 4
  disks         = [data.terraform_remote_state.images.outputs.ubuntu_focal_live]
  network       = data.terraform_remote_state.networking.outputs.home.id
  graphics_type = "vnc"
  video_mode    = "vga"
  running       = false
}


