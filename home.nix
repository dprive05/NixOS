{ config, pkgs, ... }:

{
  home.username = "raph";
  home.homeDirectory = "/home/raph";

  # C'EST ICI QUE TU CONNECTES TES FICHIERS
  imports = [
    ./home-manager/zsh.nix
    ./home-manager/kitty.nix
    ./home-manager/theme.nix
    ./home-manager/dunst.nix
    ./home-manager/clamshell.nix
    ./home-manager/hyrland.nix
    ./home-manager/security.nix
  ];

  # Tu peux laisser des paquets en vrac ici si tu veux
  home.packages = with pkgs; [
    # fastfetch
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
