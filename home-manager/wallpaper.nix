{ config, pkgs, ... }:

let
  # Change le chemin ici si ton image a un autre nom !
  image = "/etc/nixos/home-manager/wallpaper.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    
    settings = {
      ipc = "on";
      splash = false;      # Pas de logo au démarrage
      preload = [ image ]; # Charger l'image en mémoire
      
      # On applique l'image sur tous tes écrans
      wallpaper = [
        "DP-9,${image}"
        "DP-10,${image}"
        "eDP-1,${image}"
        
        # Sécurité au cas où tu branches un autre écran
        ",${image}" 
      ];
    };
  };
}
