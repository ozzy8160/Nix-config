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
  };
  outputs = { self, nixpkgs, systems, nvim-config, ... }@ inputs:
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
          ./modules/nvim.nix
        ];
      };
    };
    nixosConfigurations = {
      LT1 = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./LT1/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      LT2 = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./LT2/configuration.nix
          ./modules/nvim.nix
        ];
      };
    };
    nixosConfigurations = {
      GamingPC = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./GamingPC/configuration.nix
          ./modules/nvim.nix
        ];
      };
    };
    nixosConfigurations = {
      Bobby = nixpkgs.lib.nixosSystem {
        system = "${system}";
        specialArgs = inputs;
        modules = [
          ./Bobby/configuration.nix
          ./modules/nvim.nix
        ];
      };
    };
  };
}
