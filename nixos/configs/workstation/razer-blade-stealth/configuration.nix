{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  
  # Boot and Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.enableContainers = true;
  boot.kernelParams = [ "button.lid_init_state=open" ];

  # Networking  
  networking.hostName = "deathnote"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.networkmanager.enable = true;

    # Firewall
  networking.firewall.allowedTCPPorts = [ 24800 ];

  # Localization 
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus32";
     keyMap = "us";
   };

  # Set your time zone.
   time.timeZone = "America/New_York";

  # Packages 
   nixpkgs.config.allowUnfree = true;
   
   environment.systemPackages = with pkgs; [
     wget vim nix firefox lastpass-cli htop vscode barrier gnome3.gnome-tweaks gnome3.gnome-shell-extensions git terminator tmux tree jq cmatrix gnomeExtensions.caffeine gnomeExtensions.drop-down-terminal
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;

  # Services
   services.openssh.enable = true;

  # Audio
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
 
  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  
  # services.xserver.layout = "us";

  # Enable touchpad support.
   services.xserver.libinput.enable = true;
  
  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Users
   users.users.light = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
   };

  # Virt
  virtualisation.docker.enable = true;

  # Bash
  programs.bash.promptInit = ''
	if [ "$TERM" != "dumb" -o -n "$INSIDE_EMACS" ]; then
	  PROMPT_COLOR="1;31m"
	  let $UID && PROMPT_COLOR="1;32m"
	  if [ -n "$INSIDE_EMACS" -o "$TERM" == "eterm" -o "$TERM" == "eterm-color" ]; then
	    # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
	    PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
	  else
	    PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
	  fi
	  if test "$TERM" = "xterm"; then
	    PS1="\[\033]2;\h:\u:\w\007\]$PS1"
	  fi
	fi
'';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03";
}

