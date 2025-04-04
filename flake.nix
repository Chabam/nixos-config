{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
      inherit (self) outputs;
  in {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs;
        };
        modules = [
          ./hosts/vm/configuration.nix
        ];
      };
      chungus = nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs;
        };
        modules = [
          ./hosts/chungus/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      chabam = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [./users/chabam.nix];
      };
    };
  };
}
