{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../terminal/fonts.nix
      ./../../modules/cli.nix
      ./../../modules/hyprland.nix
      ./../../modules/vms.nix
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
      configurationLimit = 5;
    };
  };
  #auto
  nix = {
    settings = {
      auto-optimise-store = true;
      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];
    };
    #garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
  };
  #kernel version
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable networking and set host name
  networking = {
    networkmanager = {
      enable = true;
      hostName = "LT1";
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  programs ={
    starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        add_newline = false;
      };
    };
    fuse = {
      userAllowOther = true;
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
#  # Enable sound with pipewire.
#  sound.enable = true;
#  hardware.pulseaudio.enable = false;
#  security.rtkit.enable = true;
#  services.pipewire = {
#    enable = true;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
#    # If you want to use JACK applications, uncomment this
#    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
#  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #all services enable:
  services = {
    blueman = {
      enable = true;
    };
    getty = {
      autologinUser = "ryan";
    };
    printing = {
      enable = true;
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11"; # Did you read the comment?
}
