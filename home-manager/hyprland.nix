{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true; # Important pour l'intégration système

    # On utilise 'settings' pour que Nix génère la config proprement
    # Cela évite les erreurs d'espaces invisibles ou de syntaxe.
    settings = {
      
      # --- VARIABLES ---
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      # --- ÉCRANS ---
      monitor = [
        "DP-9, preferred, 0x0, 1"
        "DP-10, preferred, 1920x0, 1, transform, 1"
        "eDP-1, preferred, 0x2160, 1.25"
      ];
	
      xwayland = {
 	 force_zero_scaling = true;
      };
      
      # --- ENVIRONNEMENT ---
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # --- AUTOSTART ---
      exec-once = [
        "clamshell check" # Ton script perso
        "waybar"
        "nm-applet --indicator"
        "blueman-applet"
        "swayosd-server"
        "dunst"
        "hyprpaper"
        "hypridle"
	"wl-paste --type text --watch cliphist store" # Historique Texte
	"wl-paste --type image --watch cliphist store" # Historique Images
      ];

      # --- INPUT (Clavier/Souris) ---
      input = {
        kb_layout = "us,fr";
        kb_variant = "alt-intl,";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      # --- GESTURES (Ce qui posait problème avant) ---
     # gestures = {
      #  workspace_swipe = true;
       # workspace_swipe_fingers = 3;
      #};

      # --- GENERAL ---
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
        # Les couleurs doivent être entre guillemets
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # --- DECORATION ---
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # --- ANIMATIONS ---
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # --- LAYOUTS ---
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # --- WINDOW RULES ---
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      # --- BINDS (Raccourcis) ---
      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating,"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, W, exec, zen"
        "$mainMod, Z, exec, zen"
        "SUPER, L, exec, hyprlock"

	# Super + V pour voir l'historique
	"$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

        # Screenshot
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"

        # Changer langue clavier (Super + Alt Gauche)
        "SUPER, Alt_L, exec, hyprctl switchxkblayout all next"

        # Alt-Tab
        "ALT, Tab, cyclenext,"
        "ALT, Tab, bringactivetotop,"

        # Move Windows (Swap)
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        # Focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspaces (1-10)
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to Workspace (1-10)
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll Workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # --- BINDS SOURIS (Move/Resize) ---
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # --- BINDS SYSTEME (Lid Switch & Media) ---
      bindl = [
        # Lid Switch (Gestion Capot)
        ", switch:on:Lid Switch, exec, clamshell close"
        ", switch:off:Lid Switch, exec, clamshell open"
        
        # Media Player
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # --- BINDS REPETITIFS (Volume & Luminosité) ---
      bindel = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
      ];

    };
  };
}
