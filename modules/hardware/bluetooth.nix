{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.config-hw.bluetooth;
in
{
  config = lib.mkIf cfg {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          KernelExperimental = true;
        };
      };
    };
    services = {
      blueman.enable = true;
      pipewire.wireplumber = {
        enable = true;
        extraConfig = {
          "bluetooth" = {
            "monitor.bluez.properties" = {
              "bluez5.enable-sbc-xq" = true;
              "bluez5.enable-msbc" = true;
              "bluez5.enable-hw-volume" = true;
              "bluez5.roles" = [
                "a2dp_sink"
                "a2dp_source"
                "bap_sink"
                "bap_source"
                "hfp_hf"
                "hfp_ag"
              ];
            };
          };
        };
      };
    };
  };
}
