module "main_disk" {
  source = "../modules/disk-image"

  disk_name     = "ubuntu_workstation_root"
  base_image_id = module.ubuntu_bionic_base_image.id
  #  size_gb = 30
}

module "kali_disk" {
  source = "../modules/disk-image"

  disk_name = "kali_data_drive"
  size_gb   = 10
}

module "ubuntu_config" {
  source = "../modules/cloudconfig"

  name           = "ubuntu-config"
  cloud_config   = file("./machine-configs/ubuntu_workstation")
  network_config = file("./machine-configs/network/ubuntu_workstation")
}

module "ubuntu_workstation" {
  source = "../modules/machine"

  name       = "drifter"
  memory     = 2048
  vcpus      = 2
  cloud_init = module.ubuntu_config.id
  disks      = [module.main_disk.id]
  network    = module.drifter_network.id
  video_mode = "qxl"
}

module "kali_live" {
  source = "../modules/machine"

  name   = "kali"
  memory = 2048
  vcpus  = 2
  iso    = [module.kali_linux_live.id]
  network    = module.secure_network.id
  video_mode = "qxl"
}

