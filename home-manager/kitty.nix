{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 14;
    
    settings = {
      foreground = "#cdd6f4";
      background = "#1e1e2e";
      background_opacity = "0.8";
      confirm_os_window_close = 0;
    };
  };
}
