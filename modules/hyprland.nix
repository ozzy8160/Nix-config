{  pkgs, chaotic-nyx, ... }:
  {
    imports = [ 
      chaotic-nyx.nixosModules.default 
    ];
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
    environment.systemPackages = with pkgs; [
      blueman
      brightnessctl
      dunst
      firedragon-bin
      gearlever
      grim
      hyprcursor
      hyprlock
      hypridle
      hyprpolkitagent
      kdePackages.kdenlive
      nemo
      networkmanagerapplet
      pywal
      rofi
      searxng
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
