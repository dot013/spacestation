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

  services.anubis.enable = true;
  services.anubis.instances = {
    "forgejo" = let
      forgejo-port = config.services.forgejo.settings.server.HTTP_PORT;
    in {
      bind = ":${toString (forgejo-port + 20)}";
      metricsBind = ":${toString (forgejo-port + 30)}";
      serveRobotsTxt = true;
      target = "http://localhost:${toString forgejo-port}";
    };
  };

  virtualisation.oci-containers.containers.cloudflare-tunnel = let
    secrets = config.spacestation-secrets.lesser;
  in {
    image = "cloudflare/cloudflared:latest";
    autoStart = true;
    extraOptions = [
      "--network=host"
    ];
    cmd = [
      "tunnel"
      "--no-autoupdate"
      "run"
      # secrets.capytal.cloudflare-funnel
    ];
    environmentFiles = [
      config.sops.secrets."cloudflared/tunnel-env".path
    ];
  };

  networking.firewall.allowedTCPPorts = [
    80
    433
  ];
}
