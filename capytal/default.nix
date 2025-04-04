{inputs, ...}: {
  imports = [
    ./caddy.nix
    ./cloudflare.nix
    ./websites.nix
    ./forgejo
    ./garage.nix
    ./sqld.nix
  ];
}
