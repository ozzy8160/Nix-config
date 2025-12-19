{  pkgs, ... }:
  {
  #hyprland

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
    environment.systemPackages = with pkgs; [
      blueman
      brightnessctl
      delfin
      dunst
      finamp
      grim
      hyprcursor
      hyprlock
      hypridle
      hyprpolkitagent
      kdePackages.kdenlive
      networkmanagerapplet
      pywal
      rofi
      slurp
      swww
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
