{ config, pkgs, ... }:

{
  # --- HYPRLOCK (L'écran de verrouillage) ---
  programs.hyprlock.enable = true;
  
  # On génère le fichier de config directement ici
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
        monitor =
        path = /etc/nixos/home-manager/wallpaper.jpg   # <--- Vérifie que ton image est toujours là !
        blur_passes = 2
        blur_size = 4
    }

    input-field {
        monitor =
        size = 250, 50
        outline_thickness = 2
        dots_size = 0.2
        dots_spacing = 0.2
        dots_center = true
        outer_color = rgba(0, 0, 0, 0)
        inner_color = rgba(255, 255, 255, 0.1)
        font_color = rgb(200, 200, 200)
        fade_on_empty = false
        placeholder_text = <i>Mot de passe...</i>
        hide_input = false
        position = 0, -100
        halign = center
        valign = center
    }

    label {
        monitor =
        text = cmd[update:1000] echo "$TIME"
        color = rgba(200, 200, 200, 1.0)
        font_size = 85
        font_family = FiraCode Nerd Font
        position = 0, 100
        halign = center
        valign = center
    }

    label {
        monitor =
        text = Salut $USER
        color = rgba(200, 200, 200, 1.0)
        font_size = 20
        font_family = FiraCode Nerd Font
        position = 0, -50
        halign = center
        valign = center
    }
  '';

  # --- HYPRIDLE (L'inactivité et la veille) ---
  services.hypridle.enable = true;

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
    }

#    listener {
#        timeout = 30000000000000000000000000000000000000000000000000000000000000000
#        on-timeout = loginctl lock-session
#    }

#    listener {
#        timeout = 6000000000000000000000000000000000000000000000000000000000000000
#        on-timeout = hyprctl dispatch dpms off
#        on-resume = hyprctl dispatch dpms on
#     }
  '';
}
