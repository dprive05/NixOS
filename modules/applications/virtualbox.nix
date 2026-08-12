{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.applications.virtualbox;
in
{
  config = lib.mkIf cfg {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    users = {
      extraGroups.vboxusers.members = [ "raph" ];
    };
  };
}
