{inputs, ...}: {
  imports = [
    ./analytics.nix
    ./network.nix
    ./websites.nix

    ./forgejo
    ./garage.nix
    ./sqld.nix
  ];
}
