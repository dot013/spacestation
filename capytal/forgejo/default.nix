{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
with builtins; let
  secrets = config.spacestation-secrets.lesser;
  forgejoCfg = secrets.capytal.services.forgejo;
in {
  imports = [
    ../../modules/forgejo
    ./customization.nix
  ];
  services.forgejo = {
    enable = true;
    package = pkgs-unstable.forgejo;
    actions = {
      enable = true;
      token = forgejoCfg.actions.token;
      url = "https://forge.capytal.company";
      labels = forgejoCfg.actions.labels;
    };
    users = {
      enable = true;
      users = {
        user1 = {
          name = /. + config.sops.secrets."forgejo/user1/name".path;
          password = /. + config.sops.secrets."forgejo/user1/password".path;
          email = /. + config.sops.secrets."forgejo/user1/email".path;
          admin = true;
        };
      };
    };
    settings = {
      DEFAULT = {
        APP_NAME = "Capytal Code";
      };
      server = rec {
        HTTP_PORT = forgejoCfg.port;
        DOMAIN = "forge.capytal.company";
        ROOT_URL = "https://${DOMAIN}";
      };
      project = {
        PROJECT_BOARD_BASIC_KANBAN_TYPE = [
        ];
      };
      repository = {
        DEFAULT_REPO_UNITS = [
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
      ui = {
        DEFAULT_THEME = "frappurccino";
      };
    };
  };
}
