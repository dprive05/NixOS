# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, external, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      (inputs.nixos-hardware + "/framework/16-inch/7040-amd/default.nix")
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raph = {
    isNormalUser = true;
    description = "raph";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };


  # Install firefox.
  programs = {
	  firefox.enable = true;
	  steam.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Add framework hardware module
  services.fwupd.enable = true;

  #Pour eviter les problème de couleur d´écran
  boot.kernelParams = [ "amdgpu.abmlevel=0" ];

  # On dit à NixOS : "Ne touche à rien, laisse Hyprland gérer le capot"
  services.logind.lidSwitch = "ignore";

  #Setup VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "raph" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;   #Guest si nixos est une VM est non l'host
  #virtualisation.virtualbox.guest.dragAndDrop = true;

  #Setup Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Activer Hyprland
  programs.hyprland.enable = true;
  
  #Active Hyprlock
  programs.hyprlock.enable = true;

  programs.dconf.enable = true;

  #Optionnel : aide pour que les fenêtres comme Electron (Discord/VSCode) marchent bien sur Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Activer le "coffre-fort" (Keyring)
  services.gnome.gnome-keyring.enable = true;
  
  # Dire à SDDM de déverrouiller le coffre quand tu tapes ton mot de passe au login
  security.pam.services.sddm.enableGnomeKeyring = true;

  #Raph ne me tue pas STP pour ce qu'il y a si dessous
  # Activer Flatpak (pour Bambu Studio et autres apps propriétaires)
  services.flatpak.enable = true;

  
  # Indispensable pour que les Flatpaks puissent ouvrir les fenêtres "Enregistrer sous..." sur Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; with external; [

	#virtualbox	
	slack	
	microsoft-edge
	wget
	git
	tree
	vesktop
	zen-browser
	kitty 
	deezer-enhanced	

	#Outils système pour Hyprland
    	waybar        # La barre d'état / dock
    	dunst         # Pour les notifications
    	libnotify     # Dépendance pour les notifs
    	wofi          # Le menu d'applications
    	rofi	      # Alternative à Wofi 
    	hyprpaper     # Pour gérer le fond d'écran
	brightnessctl #Pour les raccourcie clavier    
	waypaper      #Gerer les fond ecrans
	nwg-displays  #Gerer les ecrans	
	hypridle      #Gere la veille et l'inactivite	
	swayosd	
	glib	      #permet de setup des theme + Fournit 'gsettings'
  	libsForQt5.qt5ct  # Pour configurer les apps Qt (VLC, etc.)
 	kdePackages.qt6ct
	
	# Thèmes & Icônes
	catppuccin-gtk    # Le thème sombre
	papirus-icon-theme # Les icônes
	bibata-cursors    # Le curseur de souris

    	#Gestion du réseau/son en graphique 
    	networkmanagerapplet
    	pavucontrol   # Contrôle du volume audio
	blueman	      #service de bluetooth
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];


  environment.sessionVariables = {
    # On force le curseur ici aussi pour le login manager (SDDM)
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
	
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  
  #Setup bluetooth setting 
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      # Shows battery charge of connected devices on supported
      # Bluetooth adapters. Defaults to 'false'.
      Experimental = true;
      # When enabled other devices can connect faster to us, however
      # the tradeoff is increased power consumption. Defaults to
      # 'false'.
      FastConnectable = true;
    };
    Policy = {
      # Enable all controllers when they are found. This includes
      # adapters present on start as well as adapters that are plugged
      # in later on. Defaults to 'true'.
      AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;

  # Nettoyage automatique
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  # Optimisation du stockage (déduplication)
  nix.settings.auto-optimise-store = true;
 
}
