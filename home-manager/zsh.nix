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
      update = "sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos/";
      
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

 
# --- STARSHIP (Style Powerlevel10k) ---
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      
      # Ligne de gauche (OS, Dossier, Git)
      format = "$os$directory$git_branch$git_status$character";
      
      # Ligne de droite (L'heure et le temps d'exécution)
      right_format = "$cmd_duration$time";

      # --- MODULES ---

      # Le petit logo de ton OS (NixOS)
      os = {
        disabled = false;
        style = "bg:#89b4fa fg:#1e1e2e";
        symbols = {
          NixOS = " ";
        };
        format = "[ $symbol ]($style)";
      };

      # Le dossier actuel (Fond bleu)
      directory = {
        style = "bg:#89b4fa fg:#1e1e2e";
        format = "[ $path ]($style)[](fg:#89b4fa bg:#313244)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      # Git (Fond gris)
      git_branch = {
        style = "bg:#313244";
        format = "[[ $symbol $branch ](fg:#a6e3a1 bg:#313244)]($style)";
        symbol = "";
      };

      git_status = {
        style = "bg:#313244";
        format = "[[($all_status$ahead_behind )](fg:#a6e3a1 bg:#313244)[](fg:#313244)]($style)";
      };

      # Le curseur final
      character = {
        success_symbol = "[ ➜](bold green)";
        error_symbol = "[ ✗](bold red)";
      };

      # L'heure (à droite)
      time = {
        disabled = false;
        time_format = "%R"; # Format 24h (ex: 14:30)
        style = "bg:#1e1e2e";
        format = "[[  $time ](fg:#a6adc8 bg:#1e1e2e)]($style)";
      };
      
      # Temps d'exécution (si une commande est lente)
      cmd_duration = {
        min_time = 500;
        format = "[ ⏱ $duration ](fg:#f9e2af)";
      };
    };
  };
