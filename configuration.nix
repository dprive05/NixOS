{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "raph-framework";
    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
        macAddress = "preserve";
      };
    };
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
    settings = {
      download-buffer-size = 268435456;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = "auto";
      auto-optimise-store = true;
    };
  };

  security = {
    polkit.enable = true;
    pam.services = {
      greetd = {
        enableGnomeKeyring = true;
        fprintAuth = true;
      };
      login.fprintAuth = true;
      sudo.fprintAuth = true;
      hyprlock.text = ''
        auth sufficient pam_fprintd.so
        auth include login
      '';
    };
  };

  services = {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    seatd.enable = true;
    blueman.enable = true;
    fprintd = {
      enable = true;
      package = pkgs.fprintd-tod;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --user-menu --remember-user-session --time";
        };
      };
      useTextGreeter = true;
    };
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    udev = {
      packages = with pkgs; [
        libfprint-2-tod1-goodix
      ];
      extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="5740", MODE="0666"
      '';
    };
    rpcbind.enable = true;
  };

  boot.supportedFilesystems = [ "nfs" ];

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
    papirus-icon-theme
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  users.users.raph = {
    isNormalUser = true;
    extraGroups = [
      "sudo"
      "wheel"
      "vboxusers"
      "networkmanager"
      "docker"
    ];
    packages = with pkgs; [
      eza
      kitty
      home-manager
    ];
    shell = pkgs.zsh;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  programs = {
    firefox.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        protonup-ng
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
    thunar.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.webkitgtk_4_1 pkgs.glib-networking ];
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    tree
    wget
    gamescope
    wine-staging
    dxvk
    vkd3d
    wireguard-tools
  ];
 
  system.stateVersion = "25.11";
}
