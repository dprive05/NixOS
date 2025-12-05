{ config, pkgs, ... }:

{
  # Tes infos utilisateur
  home.username = "raph";
  home.homeDirectory = "/home/raph";

  # C'est ici qu'on mettra Zsh et Starship juste après
  home.packages = with pkgs; [
    # Tu pourras ajouter des petits outils ici plus tard
    # fastfetch
    # ripgrep
  ];

  # Active Home Manager
  programs.home-manager.enable = true;

  # Ne pas toucher (version de l'état)
  home.stateVersion = "24.05";
}
