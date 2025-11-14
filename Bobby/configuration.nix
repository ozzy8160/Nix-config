{ config, pkgs, inputs, lib, ... }:
let
  USER = bobby;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../modules/fonts.nix
      ./../modules/common.nix 
      ./../modules/nvim.nix 
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
  services.printing.enable = true;
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
  services.displayManager.autoLogin.user = "${USER}"
#  services = {
#   printing = {
#      enable = true;
#    };
#    xserver = {
#      enable = true;
#      layout = "us";
#      desktopManager.plasma5.enable = true;
#      displayManager = {
#        sddm = {
#	   enable = true;
#	 };
#        autoLogin = {
#          enable = true;
#          user = "bobby";
#        };
#      };
#    };
#  };
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    kitty
  ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  # bash stuff here
  environment.pathsToLink = [ "/share/bash-completion" ];
  programs = {
    command-not-found.enable = false;
    bash = {
      completion.enable = true;
      shellAliases = {
        b = "cd ..";
      #	ls = "lsd";
      	# Search command line history
      	h = "history | rp ";
        #vim
        v = "nvim";
        sv = "sudo nvim";
      #	rebuild = "sudo nixos-rebuild switch --flake $(readlink -f /home/ryan/.dotfiles/flakes)";
        updt = "sudo nix flake update && sudo nixos-rebuild switch";
        #git
        add = "git add ."; 
      };
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
