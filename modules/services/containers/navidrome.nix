{ config, pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    navidrome = {
      image = "docker.io/deluan/navidrome:latest";
      ports = [ "4533:4533" ];
      user = "1000:1000";
      autoStart = true;
      volumes = [
        "/podman/navidrome/:/data"
        "/mnt/vault3/music/:/music:ro"
      ];
      environment = {
        # Optional: put your config options customization here. Examples:
        ND_LOGLEVEL = "debug";
      };
    };
  };
}
