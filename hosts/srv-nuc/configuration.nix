{
  config,
  inputs,
  lib,
  nixName,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/games/default.nix
    ../../modules/graphical/default.nix
    ../../modules/hardware/default.nix
    ../../modules/users/default.nix
    ../../modules/applications/default.nix
  ];

  networking = {
    hostName = "srv-nuc";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "10.0.10.10";
        prefixLength = 24;
      }
    ];
  };

  config-hw = {
    nix-settings = true;
    network = true;
    keyboard = true;
    bluetooth = false;
    printer = false;
  };

  config-user = {
    raph = true;
  };

  graphical = {
    enable = false;
    greetd = false;
  };

  applications = {
    docker = true;
    virtualbox = false;
    wireguard = false;
    man = true;
    ssh = false;
  };

  games = {
    steam = false;
  };

  system.stateVersion = "25.11";
}
