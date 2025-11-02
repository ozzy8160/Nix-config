# This can be built with nixos-rebuild --flake .#myhost build
{
  description = "ryan's multi-user flake";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };
  outputs = { self, nixpkgs, systems, ... }@ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      LT1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./LT1/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      LT2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./LT2/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      GamingPC = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./GamingPC/configuration.nix
        ];
      };
    };
  };
}
