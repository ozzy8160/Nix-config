{ config, pkgs, inputs, ... }:
  {
    environment.systemPackages = with pkgs; [
      dsda-doom
      mangohud
    ];
}
