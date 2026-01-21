{ config, pkgs, inputs, chaotic-nyx, ... }:
{
  fileSystems."/mnt/vault3" = {
    device = "ryan@192.168.1.114:/mnt/vault3";
    fsType = "fuse.sshfs";
    options = [
      "nodev"
      "noatime"
      "allow_other"
      "_netdev"
      "x-systemd.automount"
      "nofail"
      # Essential: Ensure the root user can read this file
      "IdentityFile=/home/ryan/.ssh/id_ed25519"
      # Optional but recommended for stable mounts
      "reconnect"
      "ServerAliveInterval=15"
      "idmap=user"
    ];
  };
  # Ensure the fuse module and sshfs are available
  boot.supportedFilesystems = [ "fuse.sshfs" ];

  imports =
    [ 
      ./hardware-configuration.nix
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

  users.users.ryan = {
    isNormalUser = true;
    description = "ryan";
    extraGroups = [ "networkmanager" "wheel" "dialout" "qemu-libvirtd" "libvirtd" "corectrl" ];
    packages = with pkgs; [
      floorp-bin
    ];
  };
  environment.systemPackages = with pkgs; [
    timeshift
    nvtopPackages.intel
  ];
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
   networking.firewall.allowedTCPPorts = [ 8096 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
