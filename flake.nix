# This can be built with nixos-rebuild --flake .#myhost build
{
  description = "ryan's multi-host flake with custom neovim, iso/qcow img generator w/disko";
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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, systems, nvim-config, nixos-generators, chaotic-nyx, ... }@ inputs:
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
          ./hosts/LT1/configuration.nix
          ./modules/common.nix
          ./modules/terminal
          ./modules/hyprland.nix
          ./modules/services/vms.nix
          ./modules/gaming.nix
          ./modules/media.nix
          ./modules/hardware/gpu/igpu8.nix
          ./modules/hardware/network_drives/vault3.nix
        ];
      };
    };
    nixosConfigurations = {
      LT2 = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./hosts/LT2/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      GamingPC = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./hosts/GamingPC/configuration.nix
          ./modules/hardware/network_drives/vault3.nix
          ./modules/terminal
          ./modules/common.nix
          ./modules/gaming.nix
          ./modules/media.nix
        ];
      };
    };
    nixosConfigurations = {
      Bobby = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./hosts/Bobby/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      nixos-file-server = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = { inherit nvim-config; };
        modules = [
          ./hosts/nixos-file-server/configuration.nix
          ./modules/common.nix
          ./modules/terminal
          ./modules/services/podman.nix
          ./modules/services/containers
          ./modules/hardware/gpu/igpu8.nix
          ./modules/hardware/drives/vault3.nix
        ];
      };
    };
    nixosConfigurations = {
      jellyfin3 = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = { inherit nvim-config; };
        modules = [
          ./vms/jellyfin3/configuration.nix
          ./modules/common.nix
          ./modules/terminal
          ./modules/services/podman.nix
          ./modules/services/containers/jellyfin.nix
          ./modules/disko-config.nix
          # ./modules/hardware/gpu/igpu8.nix
          # inputs.disko.nixosModules.disko
        ];
      };
    };
      packages.x86_64-linux = {
        iso = nixos-generators.nixosGenerate {
          system = "${system}";
          modules = [
            ./vms/jellyfin3/configuration.nix
          ];
          format = "iso";
        };
        qcow = nixos-generators.nixosGenerate {
          system = "${system}";
          modules = [
            ./vms/jellyfin3/configuration.nix
          ];
          format = "qcow";
        };
      };
    };
}
