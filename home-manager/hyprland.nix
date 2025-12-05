{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true; # Garde ça, c'est important pour les services

    # Config Hyprland complète
    extraConfig = ''
      
      # --- CONFIGURATION ÉCRANS SÉCURISÉE ---
      # Écran du HAUT (Principal)
      monitor = DP-9, preferred, 0x0, 1

      # Écran de DROITE (Vertical)
      monitor = DP-10, preferred, 1920x0, 1, transform, 1

      # Écran du LAPTOP (Le fautif)
      # Placé très bas pour éviter l'erreur jaune au démarrage
      monitor = eDP-1, preferred, 0x2160, 1.25


      # --- GESTION DU CAPOT (Lid Switch) ---
      # Vérification immédiate au démarrage
      exec-once = clamshell check
      # Événements
      bindl = , switch:on:Lid Switch, exec, clamshell close
      bindl = , switch:off:Lid Switch, exec, clamshell open


      # --- PROGRAMMES ---
      $terminal = kitty
      $fileManager = thunar
      $menu = wofi --show drun


      # --- AUTOSTART ---
      exec-once = waybar
      exec-once = nm-applet --indicator
      exec-once = blueman-applet
      exec-once = swayosd-server
      exec-once = dunst
      exec-once = hyprpaper
      exec-once = hypridle


      # --- VARIABLES D'ENVIRONNEMENT ---
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24


      # --- APPARENCE ---
      general {
          gaps_in = 3
          gaps_out = 5
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
      }

      decoration {
          rounding = 10
          active_opacity = 1.0
          inactive_opacity = 1.0
          
          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

          blur {
              enabled = true
              size = 3
              passes = 1
              vibrancy = 0.1696
          }
      }

      animations {
          enabled = yes
          bezier = easeOutQuint,    0.23, 1,    0.32, 1
          bezier = easeInOutCubic, 0.65, 0.05, 0.36, 1
          bezier = linear,          0,    0,    1,    1
          bezier = almostLinear,    0.5,  0.5,  0.75, 1
          bezier = quick,           0.15, 0,    0.1,  1

          animation = global,        1,    10,    default
          animation = border,        1,    5.39,  easeOutQuint
          animation = windows,       1,    4.79,  easeOutQuint
          animation = windowsIn,     1,    4.1,   easeOutQuint, popin 87%
          animation = windowsOut,    1,    1.49,  linear,       popin 87%
          animation = fadeIn,        1,    1.73,  almostLinear
          animation = fadeOut,       1,    1.46,  almostLinear
          animation = fade,          1,    3.03,  quick
          animation = layers,        1,    3.81,  easeOutQuint
          animation = layersIn,      1,    4,     easeOutQuint, fade
          animation = layersOut,     1,    1.5,   linear,       fade
          animation = fadeLayersIn,  1,    1.79,  almostLinear
          animation = fadeLayersOut, 1,    1.39,  almostLinear
          animation = workspaces,    1,    1.94,  almostLinear, fade
          animation = workspacesIn,  1,    1.21,  almostLinear, fade
          animation = workspacesOut, 1,    1.94,  almostLinear, fade
      }

      dwindle {
          pseudotile = true
          preserve_split = true
      }

      master {
          new_status = master
      }

      misc {
          force_default_wallpaper = -1
          disable_hyprland_logo = false
      }


      # --- CLAVIER & SOURIS ---
      input {
          kb_layout = "us,fr"
          kb_variant = "alt-intl,"
          kb_model =
          kb_rules =
          follow_mouse = 1
          sensitivity = 0
          touchpad {
              natural_scroll = false
          }
      }

      gestures {
          workspace_swipe = true
      }


      # --- RACCOURCIS ---
      $mainMod = SUPER

      bind = $mainMod, RETURN, exec, $terminal
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, SPACE, exec, $menu
      bind = $mainMod, P, pseudo,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, W, exec, zen
      bind = $mainMod, Z, exec, zen
      bind = SUPER, L, exec, hyprlock

      #Pour faire un screen
      bind = SUPER SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy

      # Changer de langue clavier (Super + Alt Gauche)
      bind = SUPER, Alt_L, exec, hyprctl switchxkblayout all next

      # Alt-Tab 
      bind = ALT, Tab, cyclenext,
      bind = ALT, Tab, bringactivetotop,

      # Déplacer fenêtres (Swap)
      bind = SUPER SHIFT, left, movewindow, l
      bind = SUPER SHIFT, right, movewindow, r
      bind = SUPER SHIFT, up, movewindow, u
      bind = SUPER SHIFT, down, movewindow, d

      # Focus
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move to Workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll Workspaces
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Souris Move/Resize
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # --- VOLUME & LUMINOSITÉ (OSD) ---
      bindel = , XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise
      bindel = , XF86AudioLowerVolume, exec, swayosd-client --output-volume lower
      bindel = , XF86AudioMute, exec, swayosd-client --output-volume mute-toggle
      bindel = , XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle
      bindel = , XF86MonBrightnessUp, exec, swayosd-client --brightness raise
      bindel = , XF86MonBrightnessDown, exec, swayosd-client --brightness lower

      # Media Player
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      # --- RÈGLES FENÊTRES ---
      windowrule = suppressevent maximize, class:.*
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';
  };
}
