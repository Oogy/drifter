module "vultr_workstation" {
  source = "../modules/machine"

  name       = "vultr"
  memory     = 2048
  vcpus      = 2
  cloud_init = data.terraform_remote_state.cloudinit.outputs.vultr_workstation
  disks      = [ data.terraform_remote_state.storage.outputs.vultr_workstation ]
  network    = data.terraform_remote_state.networking.outputs.work.id
  video_mode = ""
}

/*
module "kali_live" {
  source = "../modules/machine"

  name   = "kali"
  memory = 2048
  vcpus  = 2
  iso    = [module.kali_linux_live.id]
  network    = module.secure_network.id
  video_mode = "qxl"
}
*/
