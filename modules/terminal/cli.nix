{ pkgs, lib, ... }:
  {
    # startship
    programs ={
      starship = {
        enable = true;
        # Configuration written to ~/.config/starship.toml
        settings = lib.importTOML ./starship.toml;
      # settings = {
      #    add_newline = false;
      #  };
      };
      fuse = {
        userAllowOther = true;
      };
    };
    environment.systemPackages = with pkgs; [
      bash-completion
      bat
      btop
      ctop
      dysk
      fastfetch
      fd
      ffmpeg
      fzf
      gcc
      git
      jq
      lazydocker
      lazygit
      lsd
      kitty
      ncdu
      neovim
      nix-bash-completions
      pay-respects
      rclone
      ripgrep
      sftpman
      smartmontools
      sshfs
      starship
      tree
      wget
      tldr
      tmux
      zip
      unzip
      zoxide
    ];
  }
