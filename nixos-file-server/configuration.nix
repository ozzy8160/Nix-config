{ config, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./../modules/common.nix
      ./../modules/terminal
      ./../modules/nas.nix
      ./../modules/services/podman.nix
      ./../modules/services/containers
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking and set host name
  networking.networkmanager.enable = true;
  networking.hostName = "nixos-file-server"; # Define your hostname.

  nixpkgs.config.packageOverrides = pkgs: {
  intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  # enable opengl
  hardware.graphics = {
      # Opengl
      enable = true;
      extraPackages = with pkgs; [
      # intel-media-driver # LIBVA_DRIVER_NAME=iHD
      #intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      # vaapiVdpau
      #intel-compute-runtime
      # libvdpau-va-gl
      vpl-gpu-rt
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "ryan";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    openssh.authorizedKeys.keys = ["AAAAC3NzaC1lZDI1NTE5AAAAIL2hdyohgome0xN7k3IKGVxVvWtq1i8hKQ0QrqbWciHO"];
    packages = with pkgs; [
      floorp-bin
    ];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  # bash stuff here
  programs = {
    command-not-found.enable = false;
    bash = {
      completion.enable = true;
      #set bash aliases here
      shellAliases = {
        b = "cd ..";
      #	ls = "lsd";
        sj = "ssh ryan@192.168.1.58";
        # Search command line history
        h = "history | grep ";
        #vim
        v = "nvim";
        sv = "sudo nvim";
        #nixos
        rebuild = "sudo nixos-rebuild switch --flake $(readlink -f /etc/nixos/)";
        updt = "cd /etc/nixos/ && sudo nix flake update";
        #git
        add = "git add ."; 
      };
    };
  };
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
  #  #jellyfin
  #  services.jellyfin = {
  #  enable = true;
  #  openFirewall = true;
  #  };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
    };
  };
  #enable ftp
  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
    userlistEnable = true;
    userlist = [ "ryan" ];
    # chrootLocalUser = true;
    allowWriteableChroot = true;
    # forceLocalDataSSL = true;
    # forceLocalLoginSSL = true;
    # rsaCertFile = "/etc/ssl/vsftpd.pem";
    extraConfig = ''
      #   secomp_sandBox=NO
      pasv_enable=YES
      pasv_min_port=56250
      pasv_max_port=56250
      '';
  };
  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 21 22 80 81 443 8096 ];
    allowedTCPPortRanges = [ { from = 56250; to = 56250;} ];
    connectionTrackingModules = [ "ftp" ];
  };
  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
