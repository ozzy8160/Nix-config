{ config, pkgs, ... }:
{
  # Enable the OCI containers backend (Podman)
  virtualisation.oci-containers.backend = "podman";
  users.users.mysql = {
    isSystemUser = true;
    group = "mysql";
    # You can specify a UID if you need a static one across different machines
    # uid = 200; 
  };
  systemd.tmpfiles.settings = {
    "d /var/lib/mysql 0700 mysql mysql - -" = {};
  };
users.groups.mysql = {
  # You can specify a GID if you need a static one
  # gid = 200;
};
  # Define the services
  virtualisation.oci-containers.containers = {

    # MariaDB container for NPM's database
    mariadb = {
      image = "lscr.io/linuxserver/mariadb:latest"; # Or a specific version
      environment = {
        MYSQL_ROOT_PASSWORD = "sabbath2";
        MYSQL_DATABASE = "nginx_proxy_manager";
        MYSQL_USER = "npm_user";
        MYSQL_PASSWORD = "sabbath2";
      };
      volumes = [
        "/var/lib/mysql:/var/lib/mysql:z" # Mount a volume for persistent data
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
        DB_MYSQL_PASSWORD = "sabbath2";
        DB_MYSQL_NAME = "nginx_proxy_manager";
      };
      volumes = [
        "/var/lib/nginx-proxy-manager/data:/data:z"
        "/var/lib/nginx-proxy-manager/ssl:/etc/letsencrypt:z"
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
