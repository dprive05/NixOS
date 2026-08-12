{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.config-hw.keyboard;
in
{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
