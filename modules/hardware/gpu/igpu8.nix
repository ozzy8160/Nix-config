{ pkgs, ... }:
{
  # enable bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false; 
    };
    # enable opengl
    graphics = {
      # Opengl
      enable = true;
      extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libva-vdpau-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      intel-compute-runtime-legacy1
      #intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      #libvdpau-va-gl
      #vpl-gpu-rt #11th gen+
      ];
    };
  };
}
