{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.graphical.greetd;
in
{
  config = lib.mkIf cfg {
    security.pam.services = {
      greetd = {
        enableGnomeKeyring = true;
      };
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --remember --user-menu --remember-session --time";
        };
      };
      useTextGreeter = true;
    };
  };
}
