{ config, pkgs, inputs, ... }:
  {
    environment.systemPackages = with pkgs; [
      bash-completion
      bat
      btop
      fastfetch
      fd
      ffmpeg
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
    ];
}
