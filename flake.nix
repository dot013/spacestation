{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    capytalcc = {
      url = "git+https://forge.capytal.company/capytal/capytal.cc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    keikoswork = {
      url = "git+https://forge.capytal.company/guz013/keikos.work";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    dot013-nix = {
      url = "github:dot013/nix";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    ...
  } @ inputs: {
    nixosConfigurations = {
      spacestation = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
            config.allowUnfreePredicate = _: true;
          };
          inherit inputs self;
        };
        modules = [
          inputs.home-manager.nixosModules.default
          ./configuration.nix
        ];
      };
    };
    nixosModules = {
      medama = ./modules/medama.nix;
    };
  };
}
