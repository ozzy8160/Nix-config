# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./terminal/fonts.nix
#      ./terminal/starship.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #kernel version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Enable networking and set host name
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

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
  
  #hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
 };


  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  # enable opengl
  hardware.opengl = {
      # Opengl
      enable = true;
      extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
      vpl-gpu-rt
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
  
  # startship
  programs.starship = {
    enable = true;
   # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

#  # Configure keymap in X11
#  services.xserver = {
#    layout = "us";
#    xkbVariant = "";
#  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "ryan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      floorp
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    brightnessctl
    btop
    cmatrix
    dunst
    fastfetch
    ffmpeg
    fzf
    gparted
    git
    grim
    hyprcursor
    hyprlock
    hypridle
    hyprpolkitagent
    kitty
    waybar
    libnotify
    rofi-wayland
    ripgrep
    networkmanagerapplet
    slurp
    starship
    swww
    sway
    pavucontrol
    mpd
    mpv
    pulseaudio
    pipewire
    wf-recorder
    wget	
    tldr
    timeshift
    xclip
    zip
    zoxide
  ];

  # bash stuff here
  programs = {
    command-not-found.enable = false;

    bash = {
      completion.enable = true;
    #  cdls = { cd "$@" && ls; };

      #set bash aliases here
      shellAliases = {
	v = "nvim";
	sv = "sudo nvim";
#	.. = "cd ..";
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
