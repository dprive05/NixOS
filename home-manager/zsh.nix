{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -l";
      # Alias mis à jour pour pointer vers le bon endroit
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/";
      conf = "sudo nano /etc/nixos/configuration.nix";
      home = "sudo nano /etc/nixos/home.nix";
    };
    history.size = 10000;
  };
  
  # On peut même mettre Starship ici pour regrouper "Terminal"
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$nix_shell$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };
}
