module "vultr_workstation" {
  source = "../modules/machine"

  name       = "vultr"
  memory     = 4096
  vcpus      = 4
  cloud_init = data.terraform_remote_state.cloudinit.outputs.vultr_workstation
  disks      = [ data.terraform_remote_state.storage.outputs.vultr_workstation ]
  network    = data.terraform_remote_state.networking.outputs.work.id
  video_mode = "qxl"
  running    = false
}
