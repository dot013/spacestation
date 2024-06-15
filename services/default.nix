{ ... }: {
  imports = [
    ./adguardhome.nix
    ./containers
    ./forgejo.nix
    ./tailscale.nix
  ];
}
