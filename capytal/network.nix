{
  config,
  pkgs-unstable,
  ...
}: {
  imports = [];

  services.caddy.enable = true;
  services.caddy.virtualHosts = let
    forgejo-port = config.services.forgejo.settings.server.HTTP_PORT;
  in {
    ":${toString (forgejo-port + 10)}" = {
      extraConfig = ''
        reverse_proxy http://localhost${config.services.anubis.instances."forgejo".bind} {
          header_up X-Real-Ip {remote_host}
        }
      '';
    };
  };
}
