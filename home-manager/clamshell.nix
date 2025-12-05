{ config, pkgs, ... }:

let
  # On crée un script "clamshell" qui sera disponible partout
  clamshell-script = pkgs.writeShellScriptBin "clamshell" ''
    #!/bin/sh
    
    # 1. On vérifie s'il y a des écrans AUTRES que eDP-1 (le portable)
    # On liste les moniteurs, et on enlève la ligne qui contient "eDP-1"
    EXTERNAL_COUNT=$(hyprctl monitors | grep "Monitor" | grep -v "eDP-1" | wc -l)

    if [ "$1" == "close" ]; then
        if [ $EXTERNAL_COUNT -gt 0 ]; then
            # S'il reste des écrans (donc externes), on coupe juste le portable
            hyprctl keyword monitor "eDP-1, disable"
        else
            # Sinon, on dort
            systemctl suspend
        fi
    fi

    if [ "$1" == "open" ]; then
        # On rallume le portable (Scale 1.25)
        hyprctl keyword monitor "eDP-1, preferred, auto, 1.25"
        hyprctl reload
    fi
  '';
in
{
  # On installe ce script dans tes paquets
  home.packages = [ clamshell-script ];
}
