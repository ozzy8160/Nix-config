# This can be built with nixos-rebuild --flake .#myhost build
{
  description = "ryan's custom flake W.I.P";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };
  outputs = { self, nixpkgs, systems, ... }@ inputs: {
    nixosConfigurations = {
      LT1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      LT2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
