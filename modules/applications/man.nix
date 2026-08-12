{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.applications.man;
in
{
  config = lib.mkIf cfg {
    environment.defaultPackages = with pkgs; [
      linux-manual
      man
      man-pages
      man-pages-posix
    ];
    documentation = {
      enable = true;
      man.enable = true;
      dev.enable = true;
    };
  };
}
