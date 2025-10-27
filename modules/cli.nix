{ config, pkgs, inputs, ... }:
  {
    environment.systemPackages = with pkgs; [
      bash-completion
      btop
      fastfetch
      fd
      fzf
      gcc
      git
      jq
      lazygit
      lsd
      neovim
      rclone
      ripgrep
      sftpman
      sshfs
      starship
      wget
      tldr
      zip
      zoxide
  ]
};
