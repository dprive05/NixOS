{
  config,
  pkgs,
  lib,
  ...
}:

let
  raph = import ./raph.nix {
    inherit config pkgs lib;
  };
in
{
  imports = [
    raph
  ];

  options.config-user = {
    raph = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "raph user configuration";
    };
  };
}
