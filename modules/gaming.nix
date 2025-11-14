{ config, pkgs, inputs, ... }:
  {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
      gamemode.enable = true;
#      sunshine.enable = true;
      corectrl = {
        enable = true;
        gpuOverclock.enable = true;
      };
    };
    environment.systemPackages = with pkgs; [
      dsda-doom
      mangohud
    ];
}
