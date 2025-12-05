{ config, pkgs, ... }:

let
  clamshell-script = pkgs.writeShellScriptBin "clamshell" ''
    #!/bin/sh
    
    # Compte les écrans externes (Tout sauf eDP-1)
    EXTERNAL_COUNT=$(hyprctl monitors | grep "Monitor" | grep -v "eDP-1" | wc -l)

    # Fonction FERMETURE
    if [ "$1" == "close" ]; then
        if [ $EXTERNAL_COUNT -gt 0 ]; then
            # DOCK : On éteint l'écran interne
            hyprctl keyword monitor "eDP-1, disable"
        else
            # TRAIN : On dort
            systemctl suspend
        fi
    fi

    # Fonction OUVERTURE
    if [ "$1" == "open" ]; then
        # On rallume l'écran interne, placé en bas (0x2160) pour éviter les bugs
        hyprctl keyword monitor "eDP-1, preferred, 0x2160, 1.25"
        hyprctl reload
    fi
    
    # Fonction VÉRIFICATION AU DÉMARRAGE
    if [ "$1" == "check" ]; then
        # Regarde si le fichier système dit "closed"
        if grep -q "closed" /proc/acpi/button/lid/*/state; then
            $0 close
        else
            $0 open
        fi
    fi
  '';
in
{
  home.packages = [ clamshell-script ];
}
