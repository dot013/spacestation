{
  config,
  lib,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [];

  services.caddy.enable = true;
  services.caddy.xcaddy.enable = true;
  services.caddy.email = secrets.capytal.caddy.email;
  services.caddy.extraConfig = ''
    (capytal_tls) {
      tls {
        dns cloudflare {
          zone_token {env.CAPYTAL_CF_ZONE_TOKEN}
          api_token {env.CAPYTAL_CF_API_TOKEN}
        }
      }
    }
  '';
  services.caddy.virtualHosts = let
    caddyCfg = secrets.capytal.caddy;
    setConfig = c: let
      reverse_proxy =
        if (c ? ip && c ? port)
        then "reverse_proxy ${c.ip}:${toString c.port}"
        else if c ? port
        then "reverse_proxy ${caddyCfg.defaultIp}:${toString c.port}"
        else "";

      redir =
        if c ? redir
        then "redir ${c.redir}"
        else "";
    in {
      extraConfig = ''
        ${reverse_proxy}
        ${redir}
        import capytal_tls
      '';
    };
    hosts = lib.attrsets.mapAttrs (n: v: setConfig v) caddyCfg.hosts;
  in
    hosts;
  systemd.services.caddy.serviceConfig = {
    AmbientCapabilities = "CAP_NET_BIND_SERVICE";
    EnvironmentFile = config.sops.secrets."caddy/capytal/env".path;
  };

  networking.firewall.allowedTCPPorts = [
    80
    433
  ];
}
