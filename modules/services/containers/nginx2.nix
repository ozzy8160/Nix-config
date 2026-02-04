{
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers = {
    nginx-proxy-manager = {
      image = "jc21/nginx-proxy-manager:latest"; # Or a specific version
      autoStart = true;
      ports = [
        "80:80"
        "443:443"
        "81:81" # For NPM's admin interface
      ];
      volumes = [
        "/podman/nginx-proxy-manager/data:/data"
        "/podman/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
      ];
    };
  };

  # Ensure Podman service is enabled
  virtualisation.podman.enable = true;
}
