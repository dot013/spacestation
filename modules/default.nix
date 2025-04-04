{...}: {
  imports = [
    ./adguardhome.nix
    ./anubis
    ./forgejo
    ./locales.nix
    ./nh
    ./tailscale.nix
    ./xcaddy
  ];
}
