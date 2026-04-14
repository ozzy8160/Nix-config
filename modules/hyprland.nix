{  pkgs, ... }:
  {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
    environment.systemPackages = with pkgs; [
      blueman
      brightnessctl
      dunst
      gearlever
      grim
      hyprcursor
      hyprlock
      hypridle
      hyprpaper
      hyprpolkitagent
      kdePackages.kdenlive
      nemo
      networkmanagerapplet
      pywal
      rofi
      searxng
      slurp
      sway
      pavucontrol
      pulseaudio
      pipewire
      qimgv
      wf-recorder
      waybar
      xclip
    ];
}
