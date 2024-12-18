{config, ...}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [];

  services.caddy.enable = true;
  services.caddy.xcaddy.enable = true;
  services.caddy.email = secrets.capytal.caddy.email;
  services.caddy.extraConfig = ''
    (capytal_env) {
      tls {
        dns cloudflare {
          zone_token {env.CAPYTAL_CF_ZONE_TOKEN}
          api_token {env.CAPYTAL_CF_API_TOKEN}
        }
      }
    }
    (home_env) {
      tls {
        dns cloudflare {
          zone_token {env.HOME_CF_ZONE_TOKEN}
          api_token {env.HOME_CF_API_TOKEN}
        }
      }
    }
  '';
  services.caddy.virtualHosts = with builtins; let
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

      auth =
        if c ? auth
        then ''
          basic_auth {
          ${
            concatStringsSep "\n" (map (v: "${v.user} ${v.passwd}") c.auth)
          }
          }
        ''
        else "";
    in {
      extraConfig = ''
        ${reverse_proxy}
        ${redir}
        ${auth}
        import ${
          if c ? env
          then c.env
          else "capytal_env"
        }
      '';
    };
    hosts = listToAttrs (map (v: {
        name = v.pattern;
        value = setConfig v.config;
      })
      caddyCfg.hosts);
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
