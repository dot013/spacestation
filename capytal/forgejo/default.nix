{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
with builtins; let
  secrets = config.spacestation-secrets.lesser;

  frappurccino-theme =
    readFile
    "${inputs.frappurccino-forgejo.packages.${pkgs.system}.default}/css/theme-frappurccino-mocha-sky.css";

  cal-sans = pkgs.fetchzip {
    url = "https://github.com/calcom/font/releases/download/v1.0.0/CalSans_Semibold_v1.0.0.zip";
    stripRoot = false;
    hash = "sha256-JqU64JUgWimJgrKX3XYcml8xsvy//K7O5clNKJRGaTM=";
  };
  fonts-css = pkgs.writeText "custom.css" ''
    @font-face {
      family: 'Cal Sans';
      src:
        url('assets/fonts/CalSans-SemiBold.woff2') format('woff2'),
        url('assets/fonts/CalSans-SemiBold.woff') format('woff'),
        url('assets/fonts/CalSans-SemiBold.ttf') format('truetype');
    };
  '';
in {
  imports = [
    ../../modules/forgejo
  ];
  services.forgejo = {
    enable = true;
    package = pkgs-unstable.forgejo;
    actions = {
      enable = true;
      token = secrets.services.forgejo.actions-token;
      url = "https://forgejo.capytal.company";
      labels = secrets.services.forgejo.actions-labels;
    };
    customization = {
      assets = {
        "fonts" = {
          source = "${cal-sans}/fonts/webfonts";
          recursive = true;
        };
        "fonts.css" = {
          source = fonts-css;
        };
        "img/home-logo.png" = {
          source = ./assets/logo.png;
        };
        "img/home-logo.svg" = {
          source = ./assets/logo.svg;
        };
      };
      templates = {
        header = ''
          <link rel="stylesheet" type="text/css" href="assets/fonts.css">
          ${readFile ./templates/custom/header.tmpl}
        '';
        home = ./templates/home.tmpl;
      };
      theme = {
        "frappurccino" = frappurccino-theme;
      };
      favicon.png = ./assets/icon.png;
      favicon.svg = ./assets/icon.svg;
      logo.png = ./assets/icon.png;
      logo.svg = ./assets/icon.svg;
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
        HTTP_PORT = secrets.services.forgejo.port;
        DOMAIN = "forgejo.capytal.company";
        ROOT_URL = "https://${DOMAIN}";
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
