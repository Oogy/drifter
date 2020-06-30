#!/bin/bash
set -e

WORKDIR=$(pwd)
RPM_OSTREE_LAYERS='gtk-murrine-engine gtk2-engines gnome-tweaks lastpass-cli systemd-container'
WALLPAPERS_DIR=$WORKDIR/wallpapers
AVAILABLE_WALLPAPERS=$(ls $WALLPAPERS_DIR)
SUPPORTED_DEVICES="Blade Stealth, Blade 15"
WALLPAPER="redforest.jpg"
DEVICE=$(sudo dmidecode -s baseboard-product-name)

wallpaper(){
  if [ ! -f $WALLPAPERS_DIR/$WALLPAPER ]; then
    echo "==> Wallpaper does not exist, use one of the following:"
    tree $WALLPAPERS_DIR
    exit 1
  fi

  gsettings set org.gnome.desktop.background picture-uri file://$WALLPAPERS_DIR/$WALLPAPER
  gsettings set org.gnome.desktop.screensaver picture-options 'zoom'
}

gnome_theme(){
  if [ ! -d $HOME/.themes ]; then
    mkdir $HOME/.themes
  fi

  git clone https://github.com/vinceliuice/Matcha-gtk-theme
  ./Matcha-gtk-theme/install.sh -c dark -t aliz
  rm -rf ./Matcha-gtk-theme

  gsettings set org.gnome.shell.extensions.user-theme name 'Matcha-dark-aliz'
  gsettings set org.gnome.desktop.interface gtk-theme 'Matcha-dark-aliz'
}

rpm_ostree_layers(){
  rpm-ostree install $RPM_OSTREE_LAYERS
}

hw_setup_razer_blade_stealth(){
  rpm-ostree kargs --append intel_idle.max_cstate=4 --append button.lid_init_state=open --append pci=nomsi
}

hw_setup_razer_blade_15(){
  rpm-ostree kargs --append button.lid_init_state=open
}

hw_setup(){
  case $DEVICE in
  "Blade Stealth")
    echo "==> Setting kernel params for $DEVICE"
    hw_setup_razer_blade_stealth
    ;;
  *)
    echo "==> $DEVICE not supported, use: $SUPPORTED_DEVICES"
    ;;
  esac
}

main(){
  echo "==> Installing rpm-ostree layers: $RPM_OSTREE_LAYERS"
  rpm_ostree_layers
  echo "==> Setting up $DEVICE"
  hw_setup
  echo "==> Installing Gnome theme"
  gnome_theme
  echo "==> Setting Wallpaper"
  wallpaper
}

main
echo "==> Setup done"
exit 0
