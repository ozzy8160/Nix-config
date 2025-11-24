{  pkgs, ... }:
  {
    nixpkgs.config.allowUnfree = true;
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
      gamemode.enable = true;
#      sunshine.enable = true;
    };
    environment.systemPackages = with pkgs; [
      dsda-doom
      mangohud
    ];
  hardware.amdgpu.overdrive.enable = true;
}
