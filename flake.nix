{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

    base16 = {
      url = "github:SenchoPens/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    capytalcc = {
      url = "git+https://forge.capytal.company/capytal/capytal.cc";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    keikoswork = {
      url = "git+https://forge.capytal.company/guz013/keikos.work";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    dot013-nix = {
      url = "git+https://forge.capytal.company/dot013/nix";
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
    homeConfigurations.worm = inputs.dot013-nix.homeConfigurations."x86_64-linux".worm;
  };
}
