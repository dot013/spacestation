{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.forgejo.customization;
  forgejo = config.services.forgejo;

  fileType = with lib.types; either str (either lines path);
in {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  options.services.forgejo.customization = with lib;
  with lib.types; {
    enable = mkOption {
      type = bool;
      default = true;
    };
    assets = mkOption {
      type = attrsOf anything;
      default = {};
    };
    options = {
      label = mkOption {
        type = attrsOf (attrsOf (submodule ({
          config,
          lib,
          ...
        }:
          with lib;
          with lib.types; {
            options = {
              name = mkOption {
                type = nullOr str;
                default = null;
              };
              exclusive = mkOption {
                type = bool;
                default = false;
              };
              color = mkOption {
                type = str;
              };
              description = mkOption {
                type = str;
                default = "";
              };
              priority = mkOption {
                type = nullOr (enum ["low" "medium" "high" "critical"]);
                default = null;
              };
            };
          })));
        default = {};
      };
    };
    templates = {
      header = mkOption {
        type = nullOr fileType;
        default = null;
      };
      home = mkOption {
        type = nullOr fileType;
        default = null;
      };
    };
    logo.svg = mkOption {
      type = nullOr fileType;
      default = null;
    };
    logo.png = mkOption {
      type = nullOr fileType;
      default = null;
    };
    favicon.svg = mkOption {
      type = nullOr fileType;
      default = null;
    };
    favicon.png = mkOption {
      type = nullOr fileType;
      default = null;
    };
    theme = mkOption {
      type = nullOr (either (attrsOf fileType) fileType);
      default = null;
    };
  };
  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${forgejo.user}" = let
        home = {
          lib,
          forgejoConfig,
          customization,
          ...
        }:
          with lib;
          with builtins; {
            imports = [];

            programs.home-manager.enable = true;

            home.username = "${forgejoConfig.user}";
            home.homeDirectory = "${forgejoConfig.stateDir}";

            home.file = let
              fileTypeToHomeFile = theme:
                if (isString theme)
                then {
                  text = theme;
                }
                else {source = theme;};
              assetsDir = "${forgejoConfig.customDir}/public/assets";
              templatesDir = "${forgejoConfig.customDir}/templates";
              optionsDir = "${forgejoConfig.customDir}/options";
            in
              {
                "${assetsDir}/img/logo.svg" =
                  mkIf (!(isNull customization.logo.svg))
                  (fileTypeToHomeFile customization.logo.svg);

                "${assetsDir}/img/logo.png" =
                  mkIf (!(isNull customization.logo.png))
                  (fileTypeToHomeFile customization.logo.png);

                "${assetsDir}/img/favicon.svg" =
                  mkIf (!(isNull customization.favicon.svg))
                  (fileTypeToHomeFile customization.favicon.svg);

                "${assetsDir}/img/favicon.png" =
                  mkIf (!(isNull customization.favicon.png))
                  (fileTypeToHomeFile customization.favicon.png);

                "${templatesDir}/custom/header.tmpl" =
                  mkIf (!(isNull customization.templates.header))
                  (fileTypeToHomeFile customization.templates.header);

                "${templatesDir}/home.tmpl" =
                  mkIf (!(isNull customization.templates.home))
                  (fileTypeToHomeFile customization.templates.home);
              }
              // (lib.attrsets.mapAttrs'
                (ln: lv:
                  lib.attrsets.nameValuePair "${optionsDir}/label/${ln}.yaml" {
                    text = toJSON {
                      labels = attrValues (mapAttrs
                        (n: v: {
                          name =
                            if isNull v.name
                            then n
                            else v.name;
                          exclusive = v.exclusive;
                          color = v.color;
                          description = v.description;
                          priority = v.priority;
                        })
                        lv);
                    };
                  })
                customization.options.label)
              // (lib.attrsets.mapAttrs'
                (n: v: lib.attrsets.nameValuePair "${assetsDir}/${n}" v)
                customization.assets)
              // (
                if (!(isNull customization.theme))
                then
                  if isAttrs customization.theme
                  then
                    (lib.attrsets.mapAttrs'
                      (n: v:
                        lib.attrsets.nameValuePair "${assetsDir}/css/theme-${n}.css" (fileTypeToHomeFile v))
                      customization.theme)
                  else {
                    "${assetsDir}/css/theme-custom.css" = fileTypeToHomeFile customization.theme;
                  }
                else {}
              );
            home.stateVersion = "23.11"; # DO NOT CHANGE
          };
      in
        home {
          inherit lib;
          forgejoConfig = forgejo;
          customization = cfg;
        };
    };
}
