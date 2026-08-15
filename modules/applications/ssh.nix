{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.applications.ssh;
  sshKeyFramework ="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+94jQUGWbqrlRL/OBlurEbs5ttgu+3V0fadvM6WAIi raph@framework";
  sshKeyMac = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2wcAfGuJ9zXIhQANVrM7s48pbQQWwaUqPwqUuds2Lr raph@MacBookPro.lan";
  #ajouter la clé ssh des servers 1, 2, 3
in

{
  config = lib.mkIf cfg {
    users.users.raph.openssh.authorizedKeys.keys = [
      sshKeyMac
      sshKeyFramework
    ];

    services.openssh = {
      enable = true;
      ports = [ 23305 ];
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "raph" ];
        MaxAuthTries = 3;
        MaxSessions = 5;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
      };
    };
    networking.firewall.allowedTCPPorts = [
      23305
    ];
  };
}
