{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.forgejo;

  initList = l: (lib.strings.concatStringsSep "," l);

  customThemes = with builtins;
  with lib.attrsets;
    if !(isNull cfg.customization.theme)
    then
      (
        if (isAttrs cfg.customization.theme)
        then (mapAttrsToList (n: v: n) cfg.customization.theme)
        else ["custom"]
      )
    else [];
in {
  imports = [
    ./users.nix
    ./customization.nix
  ];
  options.services.forgejo = with lib;
  with lib.types; {
    settings = {
      DEFAULT = {
        APP_NAME = mkOption {
          type = str;
          default = "Forgejo: Beyond code. We forge.";
        };
      };
      actions = {
        ENABLED = mkOption {
          type = bool;
          default = cfg.actions.enable;
        };
        DEFAULT_ACTIONS_URL = mkOption {
          type = str;
          default = "https://localhost:${toString cfg.settings.server.HTTP_PORT}";
        };
      };
      project = {
        PROJECT_BOARD_BASIC_KANBAN_TYPE = mkOption {
          type = listOf str;
          defaut = ["To Do" "In Progress" "Done"];
          apply = t: initList t;
        };
        PROJECT_BOARD_BUG_TRIAGE_TYPE = mkOption {
          type = listOf str;
          defaut = ["Needs Triage" "High Priority" "Low Priority" "Closed"];
          apply = t: initList t;
        };
      };
      repository = {
        DEFAULT_REPO_UNITS = mkOption {
          type = listOf str;
          default = ["repo.code"];
          apply = t: initList t;
        };
        DISABLED_REPO_UNITS = mkOption {
          type = listOf str;
          default = [];
          apply = t:
            initList (t
              ++ (
                if !cfg.actions.enable
                then ["repo.actions"]
                else []
              ));
        };
      };
      ui = {
        DEFAULT_THEME = mkOption {
          type = str;
          default = with builtins;
            if (!(isNull cfg.customization.theme))
            then elemAt customThemes 0
            else "forgejo-auto";
        };
        THEMES = mkOption {
          type = listOf str;
          default = [
            "forgejo-auto"
            "forgejo-light"
            "forgejo-dark"
            "gitea-auto"
            "gitea-light"
            "gitea-dark"
            "forgejo-auto-deuteranopania-protanopia"
            "forgejo-light-deuteranopania-protanopia"
            "forgejo-dark-deuteranopania-protanopia"
            "forgejo-auto-tritanopia"
            "forgejo-light-tritanopia"
            "forgejo-dark-tritanopia"
          ];
          apply = t: let
            list = t ++ customThemes;
          in
            initList list;
        };
      };
    };
    actions = {
      enable = mkOption {
        type = bool;
        default = cfg.enable;
      };
      token = mkOption {
        type = str;
      };
      url = mkOption {
        type = str;
        default = "http://localhost:${toString cfg.settings.server.HTTP_PORT}";
      };
      labels = mkOption {
        type = listOf str;
        default = [
          /*
          Remember to install git on these images so actions/checkout can work,
          without it, the actions tries to use the /api/v3/repos/{user}/{repo}/tarball/{ref}
          api endpoint, which Gitea/Forgejo doesn't has.
          */
          "ubuntu-latest:docker://gitea/runner-images:ubuntu-latest-slim"
          "ubuntu-latest-full:docker://gitea/runner-images:ubuntu-latest"
        ];
      };
    };
  };
  config = with lib;
    mkIf cfg.enable {
      networking.firewall.allowedTCPPorts = mkIf cfg.settings.actions.ENABLED [
        cfg.settings.server.HTTP_PORT
      ];
      networking.firewall.allowedUDPPorts = mkIf cfg.settings.actions.ENABLED [
        cfg.settings.server.HTTP_PORT
      ];

      users.users."${cfg.user}" = {
        home = cfg.stateDir;
        useDefaultShell = true;
        group = cfg.group;
        isSystemUser = true;
        extraGroups = ["wheel" "networkmanager"];
      };
      users.groups."${cfg.group}" = {};

      services.forgejo = {
        user = mkDefault "git";
        group = cfg.user;
      };

      virtualisation.docker.enable = mkIf cfg.actions.enable (mkDefault true);
      services.gitea-actions-runner = mkIf cfg.actions.enable {
        package =
          if config.services.gitea.enable
          then pkgs.gitea-actions-runner
          else pkgs.forgejo-actions-runner;
        instances."forgejo${toString cfg.settings.server.HTTP_PORT}" = {
          enable = mkDefault true;
          token = mkDefault cfg.actions.token;
          name = mkDefault "${cfg.settings.DEFAULT.APP_NAME} - Actions";
          url = cfg.actions.url;
          labels = mkDefault cfg.actions.labels;
          settings = {
            runner = {
              insecure = true;
            };
          };
        };
      };
    };
}
