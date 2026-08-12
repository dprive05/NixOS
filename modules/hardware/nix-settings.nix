{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.config-hw.nix-settings;
in
{
  config = lib.mkIf cfg {

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      nixfmt
    ];

    nix = {
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 14d";
      };
      settings = {
        download-buffer-size = 268435456;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        max-jobs = "auto";
        auto-optimise-store = true;
      };
    };
  };
}
