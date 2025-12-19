{ config, pkgs, ... }:

{
  # 1. Installer les outils modernes
  home.packages = with pkgs; [
    fastfetch   # Infos système au démarrage
    eza         # Remplaçant de 'ls' avec couleurs
    zoxide      # Remplaçant de 'cd' intelligent
    fzf         # Recherche floue (Ctrl+R pour chercher dans l'historique)
    bat         # Remplaçant de 'cat' avec coloration syntaxique
  ];

  # 2. Configurer Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Lancer Fastfetch à chaque ouverture de terminal
    initExtra = ''
      fastfetch
    '';

    # Tes Raccourcis (Alias)
    shellAliases = {
      # Remplacer ls par eza (plus beau)
      ls = "eza --icons=always --group-directories-first";
      ll = "eza -al --icons=always --group-directories-first";
      lt = "eza -aT --icons=always --group-directories-first"; # Vue en arbre
      
      # Raccourcis NixOS (Gain de temps)
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos";
      conf = "sudo nano /etc/nixos/configuration.nix";
      home = "sudo nano /etc/nixos/home.nix";
      update = "sudo cd /etc/nixos/ && sudo flatpak update -y && sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos/";
      
      cl = "clear && fastfetch";
      
      # Divers
      cat = "bat"; # Utiliser bat pour lire les fichiers
      ".." = "cd ..";
    };
    
    history.size = 10000;
  };

  # 3. Configurer Zoxide (le cd intelligent)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # Maintenant tu peux taper 'z dos' pour aller dans 'Documents'
  };

 
  # --- STARSHIP (Style "Lean" avec Icônes & Heure) ---
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      
      # GAUCHE : Dossier -> Git -> Saut de ligne -> Flèche
      format = "$directory$git_branch$git_status$line_break$character";
      
      # DROITE : Temps d'exécution -> Heure
      right_format = "$cmd_duration$time";

      # --- LE DOSSIER (Avec Icônes) ---
      directory = {
        style = "bold #89b4fa";
        format = "[$path]($style) ";
        truncation_length = 3;
        truncation_symbol = "…/";
        
        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          "Videos" = " ";
          "Desktop" = " ";
        };
        
        home_symbol = " ~";
        read_only = " 🔒";
      };

      # --- GIT ---
      git_branch = {
        style = "bold #a6e3a1"; # Vert
        symbol = " ";
        format = "via [$symbol$branch]($style) ";
      };

      git_status = {
        style = "bold #fab387"; # Orange
        format = "[$all_status$ahead_behind]($style) ";
      };

      # --- LE PROMPT (La flèche) ---
      character = {
        success_symbol = "[❯](bold #cba6f7)"; # Violet
        error_symbol = "[❯](bold #f38ba8)";   # Rouge
        vimcmd_symbol = "[❮](bold #a6e3a1)";
      };
      
      # --- TEMPS D'EXÉCUTION ---
      cmd_duration = {
        min_time = 2000;
        format = "took [$duration](bold #f9e2af) "; # Jaune
      };

      # --- L'HEURE (À Droite) ---
      time = {
        disabled = false;
        time_format = "%R"; # Format 24h (ex: 16:30)
        style = "bold #6c7086"; # Gris (Overlay0)
        format = "at [$time]($style)";
      };
    };
  };
}
