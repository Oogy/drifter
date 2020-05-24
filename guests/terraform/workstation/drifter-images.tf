module "ubuntu_bionic_base_image" {
  source = "../modules/base-image"

  image_name   = "ubuntu-bionic-base"
  image_source = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
}

module "kali_linux_live" {
  source = "../modules/base-image"

  image_name   = "kali-linux-live"
  image_source = "https://cdimage.kali.org/kali-2020.2/kali-linux-2020.2-live-amd64.iso"
}
