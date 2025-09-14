{config, ...}: {
  imports = [
    ./analytics.nix
    ./forgejo.nix
    ./websites.nix
  ];
}
