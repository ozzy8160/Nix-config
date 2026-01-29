{ config, pkgs, inputs, ... }:
{
# imports =
#     [
#       ./hardware-configuration.nix
#     ];
  boot.initrd.availableKernelModules = [
      "virtio_net" # For virtual network devices
      "virtio_pci" # For various virtio devices
      "vfio-pci"   # For PCI passthrough
      "virtio_blk" # For virtio block devices
    ];

    # Optional: Force some modules to load
    boot.initrd.kernelModules = [
      "virtio_balloon" # Helps with memory ballooning
      "virtio_console"
      "virtio_rng"     # For random number generation
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking and set host name
  networking.networkmanager.enable = false;
  networking.hostName = "jellyfin3"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "ryan";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvbnsGi5apMZqNfL7Ml4Zo7uExmTub9PXYGyuUJj1LJ ryanpctech81@gmail.com"];
    initialPassword = "password";
    packages = with pkgs; [
      floorp-bin
    ];
  };
  security.sudo.wheelNeedsPassword = false;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nvtopPackages.intel
  ];
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
  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 21 22 80 81 443 8096 ];
  };
  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
