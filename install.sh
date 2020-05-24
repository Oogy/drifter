#!/bin/bash
#set -euxo
set -euo

GRUB_DEFAULTS_DRIFTER_RAZER_BLADE_STEALTH='GRUB_CMDLINE_LINUX_DEFAULT="quiet apparmor=1 security=apparmor udev.log_priority=3 intel_idle.max_cstate=4 button.lid_init_state=open pci=nomsi"'

HYPERVISOR_USER=$(logname)
HYPERVISOR_USER_HOME=/home/$HYPERVISOR_USER
HYPERVISOR_USER_TF_PLUGINS_DIR=$HYPERVISOR_USER_HOME/.terraform.d/plugins
HYPERVISOR_DEPS='terraform go libvirt qemu virt-viewer cdrtools ebtables dnsmasq bridge-utils gcc make lastpass-cli tmux' 

TERRAFORM_LIBVIRT_PROVIDER="github.com/dmacvicar/terraform-provider-libvirt"

GOPATH=$HYPERVISOR_USER_HOME/go

if [ $(whoami) != "root" ]; then
  echo "==> Must be run as root."
  exit 1
fi

hw_setup(){
  device=$(dmidecode | grep "Product Name:" | uniq | tr -d '\t')

  case $device in
  "Product Name: Blade Stealth")
    echo "==> Setting up $device"
    hw_setup_razer_blade_stealth
    ;;
  esac  
}

hw_setup_razer_blade_stealth(){
  GRUB_DEFAULTS_CURRENT=$(cat /etc/default/grub | grep GRUB_CMDLINE_LINUX_DEFAULT)

  if [ "$GRUB_DEFAULTS_DRIFTER_RAZER_BLADE_STEALTH" != "$GRUB_DEFAULTS_CURRENT" ]; then
    echo "==> Updating grub defaults..."
    sed -i "s/$GRUB_DEFAULTS_CURRENT/$GRUB_DEFAULTS_DRIFTER_RAZER_BLADE_STEALTH/" /etc/default/grub
    update-grub    
  else
    echo "==> Grub defaults are good."
  fi
}

system_update(){
  echo "==> Updating Pacman mirrors"
  pacman-mirrors --api --geoip 
  echo "==> Updating Manjaro system"
  pacman -Syyu
}

hypervisor_deps(){
  echo "==> Provisioning hypervisor..."
  echo "==> Installing $HYPERVISOR_DEPS"
  pacman -S $HYPERVISOR_DEPS
}

terraform_setup(){
  echo "==> Setting up Terraform"

  if [ ! -d $HYPERVISOR_USER_TF_PLUGINS_DIR ]; then
    sudo -u $HYPERVISOR_USER bash -c "cd && mkdir -p $HYPERVISOR_USER_TF_PLUGINS_DIR"
  fi 
  
  echo "==> Getting $TERRAFORM_LIBVIRT_PROVIDER"
  sudo -u $HYPERVISOR_USER bash -c "cd && go get -v $TERRAFORM_LIBVIRT_PROVIDER"

  echo "==> Building $TERRAFORM_LIBVIRT_PROVIDER"
  sudo -u $HYPERVISOR_USER bash -c "cd $GOPATH/src/github.com/dmacvicar/terraform-provider-libvirt && make install"

  sudo -u $HYPERVISOR_USER bash -c "ln -s $GOPATH/bin/terraform-provider-libvirt $HYPERVISOR_USER_TF_PLUGINS_DIR/terraform-provider-libvirt"
}

hypervisor_user(){
  usermod -G libvirt $HYPERVISOR_USER
}

hypervisor_setup(){
  hypervisor_deps
  hypervisor_user

  systemctl start libvirtd
  systemctl enable libvirtd

  terraform_setup
}

main(){
  hw_setup
  system_update
  hypervisor_setup
}

main
