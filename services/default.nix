{...}: {
  imports = [
    ./adguardhome.nix
    ./caddy.nix
    ./containers
    ./tailscale.nix
  ];
}
