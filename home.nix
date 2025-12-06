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
    ./home-manager/hyprland.nix
    ./home-manager/security.nix
  ];

  # Tu peux laisser des paquets en vrac ici si tu veux
  home.packages = with pkgs; [
    #Pour faire des screen : 
	grim          # Le photographe
  	slurp         # Le sélecteur de zone
  	wl-clipboard  # Le presse-papier (nécessaire pour copier l'image)
  	swappy        # (Optionnel) Un petit éditeur pour dessiner des flèches sur tes screens
	
	#"Presse-Papier Infini" (Cliphist)
	cliphist
	wl-clip-persist

  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
