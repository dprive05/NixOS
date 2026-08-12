{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.config-user.raph;
in
{
  config = lib.mkIf cfg {
    users.users = {
      raph = {
        isNormalUser = true;
        description = "Raph";
        useDefaultShell = true;
        extraGroups = [
          "dialout"
          "docker"
          "input"
          "networkmanager"
          "wheel"
        ];
      };
    };
  };
}
