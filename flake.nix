{
  description = ".homelab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dot013-environment = {
      url = "github:dot013/environment";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    base16 = {
      url = "github:SenchoPens/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    frappurccino-forgejo = {
      # url = "git+file:///home/guz/.projects/capytal/frappurccino-forgejo";
      url = "git+https://forgejo.capytal.company/capytal/frappurccino-forgejo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    ...
  } @ inputs: {
    nixosConfigurations = let
      systemSettings = {
        system = "x86_64-linux";
      };
      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    in {
      spacestation = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit pkgs-unstable;
        };
        modules = [
          inputs.home-manager.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
