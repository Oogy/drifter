#!/bin/bash
set -eu

RPM_OSTREE_LAYERS='gtk-murrine-engine gtk2-engines gnome-tweaks lastpass-cli systemd-container'
WALLPAPERS_DIR=$(pwd)/wallpapers
AVAILABLE_WALLPAPERS=$(ls $WALLPAPERS_DIR)
SUPPORTED_DEVICES="Blade Stealth, Blade 15"


wallpaper(){
  WALLPAPER=$1
  if [ ! -f $WALLPAPERS_DIR/$WALLPAPER ]; then
    echo "==> Wallpaper does not exist, use one of the following:"
    tree $WALLPAPERS_DIR
    exit 1
  fi

  gsettings set org.gnome.desktop.background picture-uri file://$WALLPAPERS_DIR/$WALLPAPER
}

help_message(){
      echo "Script Usage:"
      echo " "
      echo "	-l - install rpm-ostree [l]ayers"
      echo "	-d - setup specified [d]evice: [$SUPPORTED_DEVICES]"
      echo "	-h - print this [h]elp message"
      echo "	-g - install [g]nome theme(Matcha Dark Aliz)"
      echo "	-w - set [w]allpaper: [$AVAILABLE_WALLPAPERS]"
      echo " "
}

gnome_theme(){
  if [ ! -d $HOME/.themes ]; then
    mkdir $HOME/.themes
  fi

  git clone https://github.com/vinceliuice/Matcha-gtk-theme
  ./Matcha-gtk-theme/install.sh -c dark -t aliz
  rm -rf ./Matcha-gtk-theme
}

rpm_ostree_layers(){
  rpm-ostree install $RPM_OSTREE_LAYERS
}

hw_setup_razer_blade_stealth(){
  rpm-ostree kargs --append intel_idle.max_cstate=4 --append button.lid_init_state=open --append pci=nomsi
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

while getopts 'ld:gw:h' OPTION; do
  case "$OPTION" in
    l)
      echo "==> Layering RPM-OSTree packages: $RPM_OSTREE_LAYERS"
      rpm_ostree_layers
      ;;
    d)
      DEVICE="$OPTARG"
      echo "==> Setting kernel args for [d]evice: $DEVICE"
      hw_setup
      ;;
    g)
      echo "==> Installing Gnome theme Matcha Dark Aliz"
      gnome_theme
      ;;
    w)
      WALLPAPER="$OPTARG"
      echo "==> Setting wallpaper $WALLPAPER"
      wallpaper $WALLPAPER
      ;;
    h)
      help_message
      ;;
    ?)
      help_message
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

