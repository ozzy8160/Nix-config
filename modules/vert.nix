{
  virtualisation.oci-containers.containers."vert" = {
    image = "ghcr.io/vert-sh/vert:latest";
    ports = [ "3600:80" ];
  };
}
