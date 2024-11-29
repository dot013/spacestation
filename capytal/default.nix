{inputs, ...}: {
  imports = [
    ./caddy.nix
    ./cloudflare.nix
    ./forgejo
    ./garage.nix
    ./music-bot.nix
    ./sqld.nix
  ];

}
