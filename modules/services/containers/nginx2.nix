{ config, pkgs, ... }:

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
        "/var/lib/nginx-proxy-manager/data:/data"
        "/var/lib/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
      ];
      environment = {
         DB_MYSQL_HOST = "your_db_host";
         DB_MYSQL_PORT = "3306";
         DB_MYSQL_USER = "your_db_user";
         DB_MYSQL_PASSWORD = "your_db_password";
         DB_MYSQL_DATABASE = "your_db_name";
      };
    };
  };

  # Ensure Podman service is enabled
  virtualisation.podman.enable = true;
}
