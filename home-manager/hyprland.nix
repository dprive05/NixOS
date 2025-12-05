{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    
    # 1. Configuration principale (Settings)
    settings = {
      
      # --- VARIABLES ---
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      # --- ECRANS (Correction du bandeau JAUNE) ---
      # On utilise "auto-right" pour que Hyprland calcule la place tout seul
      monitor = [
        "DP-9, preferred, 0x0, 1"
        "DP-10, preferred, auto-right, 1, transform, 1"
        "eDP-1, preferred, auto-down, 1.25"
      ];

      # --- CLAVIER & SOURIS ---
      input = {
        kb_layout = "us,fr";
        kb_variant = "alt-intl,";
        kb_options = "grp:alt_shift_toggle";
        
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # --- APPARENCE ---
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
            enabled = true;
            size = 3;
            passes = 1;
        };
      };

      # --- RACCOURCIS ---
      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        
        # Capture d'écran
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        ", Print, exec, grim ~/Pictures/Screen_$(date +'%Y%m%d_%H%M%S').png"
        
        # Gestion capot
        ", switch:on:Lid Switch, exec, clamshell close"
        ", switch:off:Lid Switch, exec, clamshell open"
      ];

      # --- DÉMARRAGE AUTO ---
      exec-once = [
        "waybar"
        "hypridle"
        "dunst"
        "swayosd-server"
        "nm-applet --indicator"
        "blueman-applet"
        "clamshell open"
      ];
    };

    # 2. Configuration "Brute" (Correction du bandeau ROUGE)
    # On écrit ça en texte pur pour éviter que tu fasses une faute de syntaxe Nix
    # ATTENTION : Ne touche pas aux deux apostrophes '' au début et à la fin !
    extraConfig = ''
      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }
    '';
  };
}
