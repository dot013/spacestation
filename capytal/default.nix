{inputs, ...}: {
  imports = [
    ./caddy.nix
    ./cloudflare.nix
    ./websites.nix
    ./forgejo
    ./garage.nix
    ./music-bot.nix
    ./sqld.nix

  ];
}
