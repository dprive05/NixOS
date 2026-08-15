{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.selfhost.htop;
in
{
  config = lib.mkIf cfg {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
    services = {
      glances.enable = true;

      nginx = {
        enable = true;
        virtualHosts."htop.dprive.fr" = {
          locations."/" = {
            proxyPass = "http://10.0.10.4:61208";
          };
        };
      };
    };
  };
}
