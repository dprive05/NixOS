{
  config,
  pkgs,
  lib,
  ...
}:

let
  greetd = import ./greetd.nix {
    inherit config pkgs lib;
  };
  cfg = config.graphical;
in
{
  imports = [
    greetd
  ];

  options.graphical = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "adding default graphical option";
    };
    mail = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "adding mail client (thunderbird)";
    };
    greetd = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "adding greetd login screen";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
    programs = {
      thunderbird.enable = cfg.mail;
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    environment.systemPackages = with pkgs; [
      libjpeg
      libpng
      libuuid
      cairo
      xsel
      dconf
      uwsm
    ];

    services = {
      xserver.enable = true;
      gnome.gnome-keyring.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      dbus.enable = true;
      seatd.enable = true;
      udev.extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="5740", MODE="0666"
      '';
    };
    security = {
      pam.services.swaylock = { };
      polkit.enable = true;
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
  };
}
