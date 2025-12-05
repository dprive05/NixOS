{ config, pkgs, ... }:

{
  # 1. Le Curseur de la souris (Home Manager le gère parfaitement)
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # 2. Le Thème GTK (Fenêtres, Fichiers, etc.)
  gtk = {
    enable = true;
    
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
  };

  # 3. Forcer le mode sombre pour les applis qui ne suivent pas GTK
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  
  # 4. Variables d'environnement pour que les apps Qt (KDE) suivent le style
  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
  };
}
