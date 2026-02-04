# common apps and settings across all machines
{  pkgs, ... }:
  {
    services.fstrim.enable = true;
    #install latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
    nix = {
      settings = {
        #increase download buffer
        download-buffer-size = 524288000;
        auto-optimise-store = true;
        # enable flakes
        experimental-features = [ "nix-command" "flakes" ];
      };
      #garbage collection
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
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
    # .bashrc
    environment.pathsToLink = [ "/share/bash-completion" ];
    programs = {
      command-not-found.enable = false;
      nix-index.enable = true;
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
  }
