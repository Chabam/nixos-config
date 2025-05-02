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

    openmw-nix = {
      url = "git+https://codeberg.org/PopeRigby/openmw-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      templates = {
        generic = {
          path = ./templates/generic;
          description = "Basic extensible flake config";
        };
        python = {
          path = ./templates/python;
          description = "A basic Python pip flake";
        };
        pandoc = {
          path = ./templates/pandoc;
          description = "A basic pandoc flake";
        };
        default = self.templates.generic;
      };

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

        gamer = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/gamer/configuration.nix
          ];
        };

        uni = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/uni/configuration.nix
          ];
        };
      };
    };
}
