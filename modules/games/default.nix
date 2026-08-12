{
  config,
  pkgs,
  lib,
  ...
}:

let
  steam = import ./steam.nix {
    inherit config pkgs lib;
  };
in
{
  imports = [
    steam
  ];

  options.games = {
    steam = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable steam installation";
    };
  };
}
