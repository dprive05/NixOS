{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  htop = import ./htop.nix {
    inherit
    inputs
    config
    pkgs
    lib
    ;
  };
  cfg = config.selfhost;

in
{
  imports = [
    htop
  ];

  options.selfhost = {
    htop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the htop";
    };
  };
}
