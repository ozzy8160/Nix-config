{ config, pkgs, ... }: {
  virtualisation.oci-containers.containers."jellyfin" = {
      autoStart = true;
      image = "jellyfin/jellyfin";
      volumes = [
        "/path/to/your/jellyfin/config:/config" # Host path : Container path
        "/path/to/your/jellyfin/cache:/cache"
        "/mnt/vault3:/vault3"
      ];
      ports = [
        "8096:8096" # Main web interface port
        "8920:8920" # Optional: HTTPS port
        # Add other ports for DLNA, etc. if needed
      ];
      environment = {
        # Optional: set user/group IDs for permission control
        PUID = "1000"; 
        PGID = "1000";
      };
    };
}
