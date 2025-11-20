{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket = {
        enable = true;
      };
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
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podman-compose
  ];
}
