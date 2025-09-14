{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.forgejo;
in {
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    settings = let
      initList = l: (lib.strings.concatStringsSep "," l);
    in {
      DEFAULT = {
        APP_NAME = "Capytal Code";
      };
      server = rec {
        HTTP_PORT = 9960;
        DOMAIN = "forge.capytal.company";
        ROOT_URL = "https://${DOMAIN}";
      };
      repository = {
        DEFAULT_REPO_UNITS = initList [
          "repo.code"
          "repo.issues"
          "repo.pulls"
        ];
      };
      admin = {
        DISABLE_REGULAR_ORG_CREATION = true;
        USER_DISABLED_FEATURES = "deletion manage_ssh_keys manage_gpg_keys";
        EXTERNAL_USER_DISABLED_FEATURES = "deletion manage_ssh_keys manage_gpg_keys";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      security = {
        REVERSE_PROXY_TRUSTED_PROXIES = "127.0.0.0/8,::1/128";
      };
      ui = {
        # DEFAULT_THEME = "capytal-dark";
      };
    };
  };

  services.anubis.instances."forgejo" = {
    settings = {
      BIND = ":${toString (cfg.settings.server.HTTP_PORT + 2)}";
      BIND_NETWORK = "tcp";
      METRICS_BIND = ":${toString (cfg.settings.server.HTTP_PORT + 3)}";
      METRICS_BIND_NETWORK = "tcp";
      SERVE_ROBOTS_TXT = true;
      TARGET = "http://localhost:${toString cfg.settings.server.HTTP_PORT}";
      ED25519_PRIVATE_KEY_HEX_FILE = config.sops.secrets."forgejo/anubis/hexFile".path;
    };
  };

  services.caddy.virtualHosts.":${toString (cfg.settings.server.HTTP_PORT + 1)}" = {
    extraConfig = ''
      reverse_proxy http://localhost${config.services.anubis.instances."forgejo".settings.BIND} {
        header_up X-Real-Ip {remote_host}
      }
    '';
  };
}
