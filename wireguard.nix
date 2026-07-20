{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
      address = [ "10.0.99.2/32" ];
      privateKeyFile = "/etc/wireguard/private.key";

      peers = [
        {
          publicKey = "ECWQubbsVUjq50L5C8jbUWzKrmf7PoPGTixxMeKyhgw=";
          presharedKeyFile = "/etc/wireguard/preshared.key";
          allowedIPs = [ "10.0.10.0/24" "10.0.99.0/29" ];
          endpoint = "176.163.160.117:51555";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 51555 ];
}
