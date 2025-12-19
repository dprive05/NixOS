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
  
  # --- CONFIGURATION STABLE BAMBU STUDIO ---
  home.file.".local/share/flatpak/overrides/com.bambulab.BambuStudio".text = ''
    [Context]
    # On donne accès aux thèmes pour éviter les erreurs de style
    filesystems=xdg-config/gtk-3.0:ro;

    [Environment]
    # FORCE le mode X11 pour éviter les erreurs de taille Wayland
    GDK_BACKEND=x11
    # On reste sur une échelle de 1 pour éviter le flou et les erreurs "height > 0"
    GDK_SCALE=1
    # On grossit juste le texte pour tes yeux
    GDK_DPI_SCALE=1.25
  '';

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
