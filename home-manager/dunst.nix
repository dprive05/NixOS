{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    
    settings = {
      global = {
        # Apparence
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "20x20";     # Marge par rapport au bord de l'écran
        notification_limit = 5;
        
        # Style
        font = "FiraCode Nerd Font 11";
        frame_width = 2;
        frame_color = "#89b4fa"; # Bleu (Catppuccin Sapphire)
        corner_radius = 10;      # Arrondis
        
        # Couleurs (Fond sombre, texte blanc)
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        
        # Comportement
        timeout = 5;          # Disparait après 5 secondes
        markup = "full";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
      };

      # Niveaux d'urgence (Couleurs spécifiques)
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#a6e3a1"; # Vert
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa"; # Bleu
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8"; # Rouge
        timeout = 0; # Ne disparait pas tant que tu ne cliques pas
      };
    };
  };
}
