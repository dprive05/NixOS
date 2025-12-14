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
    ./home-manager/wallpaper.nix
    ./home-manager/nano.nix
  ];
  
  # Définir les applications par défaut
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
    };
  };

  # Tu peux laisser des paquets en vrac ici si tu veux
  home.packages = with pkgs; [
    #Pour faire des screen : 
	grim          # Le photographe
  	slurp         # Le sélecteur de zone
  	wl-clipboard  # Le presse-papier (nécessaire pour copier l'image)
    	swappy        # (Optionnel) Un petit éditeur pour dessiner des flèches sur tes screens
   	imv  	      # Le visualiseur d'images        
	python3

	#"Presse-Papier Infini" (Cliphist)
	cliphist
	wl-clip-persist

  ];
  
  # --- CONFIGURATION PERMANENTE BAMBU STUDIO (FLATPAK) ---
  home.file.".local/share/flatpak/overrides/com.bambulab.BambuStudio".text = ''
    [Context]
    # Donne accès aux thèmes pour qu'il soit sombre (Catppuccin)
    filesystems=~/.themes;~/.icons;xdg-config/gtk-3.0:ro;

    [Environment]
    # Règle le problème de flou (Netteté parfaite)
    GDK_SCALE=1
    
    # Règle la taille du texte (Si c'est trop petit, mets 1.2 ou 1.5 ici)
    GDK_DPI_SCALE=1.25
    '';

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
