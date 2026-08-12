{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.config-hw.printer;
in
{
  config = lib.mkIf cfg {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
      ];
    };
  };
}
