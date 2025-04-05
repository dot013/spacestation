{config, ...}: let
  port = config.services.medama.port;
in {
  services.medama.enable = true;
  services.medama.port = 6010;
  services.medama.cors = [
    "forge.capytal.company"
  ];

  services.caddy.virtualHosts.":${toString (port + 1)}" = {
    extraConfig = ''
      reverse_proxy /api/* http://localhost:${toString port}

      reverse_proxy http://localhost:${toString (port + 2)} {
        header_up X-Real-Ip {remote_host}
      }
    '';
  };

  services.anubis.instances."medama" = {
    bind = ":${toString (port + 2)}";
    metricsBind = ":${toString (port + 3)}";
    serveRobotsTxt = true;
    target = "http://localhost:${toString port}";
    ed25519PrivateKeyHexFile = config.sops.secrets."medama/anubis/hexFile".path;
  };
}
