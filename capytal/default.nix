{inputs, ...}: {
  imports = [
    ./cloudflare.nix
    ./network.nix
    ./websites.nix

    ./forgejo
    ./garage.nix
    ./sqld.nix
  ];
}
