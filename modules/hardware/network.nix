{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.config-hw.network;
in
{
  config = lib.mkIf cfg {
    networking = {
      firewall.enable = true;
      networkmanager.enable = true;
      defaultGateway = "10.0.10.1";
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
    };
  };
}
