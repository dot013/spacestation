{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [
    ../modules/forgejo
  ];
  services.forgejo = {
    enable = true;
    actions = {
      enable = true;
      token = secrets.services.forgejo.actions-token;
      url = "http://192.168.1.10:${toString secrets.services.forgejo.port}";
      labels = secrets.services.forgejo.actions-labels;
    };
    users = {
      user1 = {
        name = /. + config.sops.secrets."forgejo/user1/name".path;
        password = /. + config.sops.secrets."forgejo/user1/password".path;
        email = /. + config.sops.secrets."forgejo/user1/email".path;
        admin = true;
      };
    };
    settings = {
      server = {
        HTTP_PORT = secrets.services.forgejo.port;
        DOMAIN = "forgejo.capytal.company";
        ROOT_URL = "https://forgejo.capytal.company";
      };
      admin = {
        DISABLE_REGULAR_ORG_CREATION = true;
        USER_DISABLED_FEATURES = "deletion manage_ssh_keys manage_gpg_keys";
        EXTERNAL_USER_DISABLED_FEATURES = "deletion manage_ssh_keys manage_gpg_keys";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
    };
  };
}
