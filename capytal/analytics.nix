{
  config,
  self,
  ...
}: let
  cfg = config.services.medama;
in {
  imports = [
    self.nixosModules.medama
  ];

  services.medama.enable = true;
  services.medama.port = 9840;
  services.medama.cors = [
    "capytal.cc"
    "forge.capytal.company"
  ];

  services.anubis.instances."medama" = {
    settings = {
      BIND = ":${toString (cfg.port + 2)}";
      BIND_NETWORK = "tcp";
      METRICS_BIND = ":${toString (cfg.port + 3)}";
      METRICS_BIND_NETWORK = "tcp";
      SERVE_ROBOTS_TXT = true;
      TARGET = "http://localhost:${toString cfg.port}";
      ED25519_PRIVATE_KEY_HEX_FILE = config.sops.secrets."medama/anubis/hexFile".path;
    };
  };

  services.caddy.virtualHosts.":${toString (cfg.port + 1)}" = {
    extraConfig = ''
      reverse_proxy /api/* http://localhost:${toString cfg.port}

      reverse_proxy http://localhost:${toString (cfg.port + 2)} {
        header_up X-Real-Ip {remote_host}
      }
    '';
  };
}
