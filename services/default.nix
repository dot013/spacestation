{...}: {
  imports = [
    ./adguardhome.nix
    ./caddy.nix
    ./containers
    ./forgejo.nix
    ./tailscale.nix
  ];
}
