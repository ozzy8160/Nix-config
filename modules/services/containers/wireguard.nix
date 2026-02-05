{
  # 1. Enable Podman and OCI backend
  virtualisation = {
    containers.enable = true;
    podman = {
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers.backend = "podman";
  };
  # 2. Define the wg-easy container
  virtualisation.oci-containers.containers.wireguard = {
    image = "ghcr.io/wg-easy/wg-easy:latest";
    ports = [ 
      "51820:51820/udp" 
      "51821:51821/tcp" 
    ];
    environment = {
      WG_HOST = "47.231.219.6";
      PASSWORD = "$6$q1q5t39KE4B0yRl2$l/Cb6Wy5EdPtUfaCFbieBThYvtTcWA5VplRaxUbb0fLtZwMtAgusqkXEyyUIchF26GnNt/T/s6buQN57D59Ps0"; # Recommended: Use environmentFiles for secrets
    };
    volumes = [ 
      "/var/lib/wg-easy:/etc/wireguard" 
    ];
    extraOptions = [ 
      "--cap-add=NET_ADMIN" 
      "--cap-add=SYS_MODULE" # Often required for WireGuard kernel modules
      "--sysctl=net.ipv4.conf.all.src_valid_mark=1" 
    ];
  };
  # 3. Networking and Kernel settings
  boot.kernel.sysctl = { 
    "net.ipv4.ip_forward" = 1; 
    "net.ipv6.conf.all.forwarding" = 1;
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # External VPN access
    allowedTCPPorts = [ 51821 ]; # Web UI access
  };
}
#{
#  virtualisation = {
#      # Required for containers in a pod to communicate (e.g., via podman-compose)
#      defaultNetwork.settings.dns_enabled = true;
#    };
#    oci-containers.containers = {
#      backend = "podman";
#    };
#    oci-containers.containers."wireguard" = {
#      image = "ghcr.io/wg-easy/wg-easy:latest";
#      ports = [
#        "51820:51820/udp"
#        "51821:51821/tcp"
#      ];
#      environment = {
#        WG_HOST = " 47.231.219.6";
#        PASSWORD = "test";
#      };
#      volumes = [
#        "/var/lib/wg-easy:/etc/wireguard"
#      ];
#      extraOptions = [
#        "--cap-add=NET_ADMIN"
#        "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
#      ];
#    };
#  # Enable IP forwarding for VPN routing
#  boot.kernel.sysctl = {
#    "net.ipv4.ip_forward" = 1;
#    "net.ipv6.conf.all.forwarding" = 1;
#  };
#}

#virtualisation.oci-containers.containers."wireguard" = {
#      image = "ghcr.io/wg-easy/wg-easy:latest";
#      ports = [
#        "51820:51820/udp"
#        "51821:51821/tcp"
#      ];
#      environment = {
#        WG_HOST = " 47.231.219.6";
#        PASSWORD = "test";
#      };
#      volumes = [
#        "/var/lib/wg-easy:/etc/wireguard"
#      ];
#      extraOptions = [
#        "--cap-add=NET_ADMIN"
#        "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
#      ];
#    };
#{ pkgs, ... }: {
#  # 1. Pre-load the WireGuard kernel module (Rootless cannot do this)
#  boot.kernelModules = [ "wireguard" ];
#
#  # 2. Open UDP port 51820 on the host firewall
#  networking.firewall.allowedUDPPorts = [ 51820 ];
#
#  # 3. Enable Podman and standard rootless requirements
#  virtualisation.podman.enable = true;
#  
#  # Enable "Linger" for your user so containers stay running after logout
#  users.users.YOUR_USERNAME = {
#    isNormalUser = true;
#    extraGroups = [ "podman" ];
#  };
#}
