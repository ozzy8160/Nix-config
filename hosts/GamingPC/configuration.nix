{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../modules/terminal
      ./../modules/common.nix
      ./../modules/gaming.nix
      ./../modules/meida.nix
#      ./../../modules/hyprland.nix
#      ./../../modules/vms.nix
    ];
  #power managament
  powerManagement.enable = false;
  # Bootloader.
  #  boot.loader = {
  #    efi = { 
  #      canTouchEfiVariables = true;
  #    };
  #    systemd-boot = {
  #      enable = true;
  #      configurationLimit = 10;
  #    };
  #  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable networking and set host name
 networking = {
    hostName = "GamingPC";
    networkmanager = {
      enable = true;
    };
  };
  # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/nvme0n1";
    boot.loader.grub.useOSProber = true;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; # Same as production
  # Enable automatic login for the user.
  #  services.xserver.displayManager.autoLogin.enable = true;
  #  services.xserver.displayManager.autoLogin.user = "ryan";

  # Enable the X11 windowing system.
  #  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #  services.xserver.displayManager.sddm.enable = true;
  #  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      Variant = "";
    };
  };
  
  #  nixpkgs.config.packageOverrides = pkgs: {
  #    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };

  
  # enable bluetooth
  #  hardware = {
  #    bluetooth = {
  #      enable = true;
  #      powerOnBoot = false; 
  #    };
  #    # enable opengl
  #    graphics = {
  #      enable = true;
  #    };
  #  };
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "ryan";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
  ];
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
    };
  };
  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 22 ];
  };
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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #all services enable:
#  services = {
#    blueman = {
#      enable = true;
#    };
#    getty = {
#      autologinUser = "ryan";
#    };
#    printing = {
#      enable = true;
#    };
#  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11"; # Did you read the comment?
}
