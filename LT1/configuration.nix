{ config, pkgs, inputs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../modules/common.nix
      ./../modules/terminal
      ./../modules/hyprland.nix
      ./../modules/services/vms.nix
      ./../modules/gaming.nix
    ];
  #power managament
  powerManagement.enable = true;
  # Bootloader.
  boot.loader = {
    efi = { 
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
  # Enable networking and set host name
  networking = {
    hostName = "LT1";
    networkmanager = {
      enable = true;
    };
  };
  #  nixpkgs.config.packageOverrides = pkgs: {
  #    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  #  };
  
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
      #vpl-gpu-rt
      ];
    };
  };
  users.users.ryan = {
    isNormalUser = true;
    description = "ryan";
    extraGroups = [ "networkmanager" "wheel" "dialout" "qemu-libvirtd" "libvirtd"];
    packages = with pkgs; [
      floorp-bin
    ];
  };
  environment.systemPackages = with pkgs; [
    kitty
    mpd
    mpv
    timeshift
  ];
  #all services enable:
  services = {
    blueman = {
      enable = true;
    };
    getty = {
      autologinUser = "ryan";
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11"; # Did you read the comment?
}
