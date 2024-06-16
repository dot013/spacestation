{...}: {
  imports = [
    ./adguardhome.nix
    ./forgejo
    ./locales.nix
    ./nh
    ./tailscale.nix
  ];
}
