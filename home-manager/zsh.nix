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

  # 4. Configurer Starship (Le Prompt)
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = "$directory$git_branch$nix_shell$character";
      
      # Style des dossiers
      directory = {
        style = "bold lavender";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      
      # Symbole de la flèche
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[V](bold green)";
      };
      
      # Git
      git_branch = {
        style = "bold pink";
        symbol = " ";
      };
    };
  };
}
