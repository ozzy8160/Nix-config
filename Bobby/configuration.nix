{ config, pkgs, inputs, lib, ... }:
let
  USER = "bobby";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../modules/fonts.nix
      ./../modules/common.nix 
      (import ./../modules/nvim.nix {
         USER = "${USER}";
         inherit config;
         inherit pkgs;
         inherit inputs;
         inherit lib;
      })
      ./../modules/cli.nix 
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
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
  #kernel version
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "${USER}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Enable networking
  networking.networkmanager.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users.bobby = {
    isNormalUser = true;
    description = "${USER}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      chromium
    ];
  };
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${USER}";
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    kitty
  ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
