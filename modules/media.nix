{  pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      delfin
      finamp
      mpd
      mpv
    ];
}
