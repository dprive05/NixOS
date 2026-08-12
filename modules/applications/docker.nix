{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.applications.docker;
in
{
  config = lib.mkIf cfg {
    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    environment.systemPackages = with pkgs; [
      docker
      docker-buildx
      docker-compose
    ];
  };
}
