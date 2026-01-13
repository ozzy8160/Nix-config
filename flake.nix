# This can be built with nixos-rebuild --flake .#myhost build
{
  description = "ryan's multi-host flake with custom neovim";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nvim-config = {
      url = "github:ozzy8160/neovim-config";
      flake = false;
    };
    chaotic-nyx = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
  };
  outputs = { self, nixpkgs, systems, nvim-config, chaotic-nyx, ... }@ inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      LT1 = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = { inherit chaotic-nyx; };
        modules = [
          ./LT1/configuration.nix
          ./../modules/common.nix
          ./../modules/terminal
          ./../modules/hyprland.nix
          ./../modules/services/vms.nix
          ./../modules/gaming.nix
          ./../modules/media.nix
        ];
      };
    };
    nixosConfigurations = {
      LT2 = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./LT2/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      GamingPC = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./GamingPC/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      Bobby = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./Bobby/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      nixos-file-server = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = { inherit nvim-config; };
        modules = [
          ./nixos-file-server/configuration.nix
          ./../modules/common.nix
          ./../modules/terminal
          ./../modules/terminal/nvim.nix
          ./../modules/drives/vault3.nix
          ./../modules/services/podman.nix
          ./../modules/services/containers

        ];
      };
    };
  };
}
