{ config, pkgs, inputs, ... }:
{
# imports =
  #   [
  #     ./hardware-configuration.nix
  #   ];

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
    openssh.authorizedKeys.keys = ["AAAAC3NzaC1lZDI1NTE5AAAAIL2hdyohgome0xN7k3IKGVxVvWtq1i8hKQ0QrqbWciHO"];
    packages = with pkgs; [
      floorp-bin
    ];
  };
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
    connectionTrackingModules = [ "ftp" ];
  };
  networking.firewall.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
