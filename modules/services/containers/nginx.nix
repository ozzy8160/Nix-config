{ config, pkgs, ... }:
{
  # Enable the OCI containers backend (Podman)
  virtualisation.oci-containers.backend = "podman";

  # Define the services
  virtualisation.oci-containers.containers = {

    # MariaDB container for NPM's database
    mariadb = {
      image = "lscr.io/linuxserver/mariadb:latest"; # Or a specific version
      environment = {
        MYSQL_ROOT_PASSWORD = "your_strong_root_password";
        MYSQL_DATABASE = "nginx_proxy_manager";
        MYSQL_USER = "npm_user";
        MYSQL_PASSWORD = "boomgoesthedynamite";
      };
      volumes = [
        "/var/lib/mysql:/var/lib/mysql" # Mount a volume for persistent data
      ];
      # Set up port for internal container communication (optional if using internal network)
      # ports = [ "3306:3306" ];
      autoStart = true;
    };

    # NGINX Proxy Manager container
    nginx-proxy-manager = {
      image = "jc21/nginx-proxy-manager:latest"; # Or a specific version
      ports = [
        "80:80"   # HTTP port
        "443:443" # HTTPS port
        "81:81"   # NPM Admin UI port
      ];
      environment = {
        DB_MYSQL_HOST = "mariadb"; # The hostname matches the container name
        DB_MYSQL_PORT = "3306";
        DB_MYSQL_USER = "npm_user";
        DB_MYSQL_PASSWORD = "boomgoesthedynamite";
        DB_MYSQL_NAME = "nginx_proxy_manager";
      };
      volumes = [
        "/var/lib/nginx-proxy-manager/data:/data"
        "/var/lib/nginx-proxy-manager/ssl:/etc/letsencrypt"
      ];
      autoStart = true;
      dependsOn = [ "mariadb" ]; # Ensure the database starts first
    };
  };

  # Optional: Expose ports in the NixOS firewall
  networking.firewall.allowedTCPPorts = [ 80 81 443 ];

  # Persist container data outside the Nix store
  # Ensure these directories exist and have correct permissions
  systemd.services.mariadb.serviceConfig.StateDirectory = "mariadb";
  systemd.services.nginx-proxy-manager.serviceConfig.StateDirectory = "nginx-proxy-manager";
}
  # Link to the official Nginx Proxy Manager setup instructions for initial login details
  # [Nginx Proxy Manager Setup](
