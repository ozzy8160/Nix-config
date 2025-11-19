{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--filter=until=24h"
          "--filter=label!=important"
          ];
      };
      defaultNetwork.settings.dns_enable = true;
    };
  };
  environment.systemPackage = with pkgs; [
    podman-compose
  ];
}
