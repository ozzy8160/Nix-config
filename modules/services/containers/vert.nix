{
  virtualisation.oci-containers.containers."vert" = {
    image = "ghcr.io/vert-sh/vert:latest";
    autoStart = true;
    ports = [ "3600:80" ];
  };
}
