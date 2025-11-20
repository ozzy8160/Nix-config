{
  virtualisation.oci-containers.containers."nginx" = {
    image = "jc21/nginx-proxy-manager:latest";
    autoStart = true;
    ports = [ 
      "80:80"
      "81:81"
      "443:443"
    ];
    volumes = [
      "/var/lib/nginx-proxy-manager/data:/data"
      "/var/lib/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
    ];
  };
}
