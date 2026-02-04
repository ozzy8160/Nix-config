{ pkgs, ... }:
  {
    # startship
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
      rclone
      ripgrep
      sftpman
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
