{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.forgejo.users;
  forgejo = config.services.forgejo;
in {
  imports = [];
  options.services.forgejo.users = with lib;
  with lib.types; {
    enable = mkOption {
      type = bool;
      default = true;
    };
    handleUndeclaredUsers = mkOption {
      type = bool;
      default = false;
    };
    users = mkOption {
      type = attrsOf (submodule ({
        config,
        lib,
        ...
      }:
        with lib;
        with lib.types; {
          options = {
            name = mkOption {
              type = nullOr (either str path);
              default = null;
            };
            password = mkOption {
              type = either str path;
            };
            email = mkOption {
              type = either str path;
            };
            admin = mkOption {
              type = bool;
              default = false;
            };
          };
        }));
      default = {};
    };
  };
  config = with lib;
    mkIf cfg.enable {
      systemd.services."forgejo-users-setup" = with builtins; let
        users = builtins.attrValues (builtins.mapAttrs
          (username: info: {
            name =
              if isNull info.name
              then username
              else info.name;
            email = info.email;
            password = info.password;
            admin = info.admin;
          })
          cfg.users);
      in {
        script = ''
          function gum() { ${pkgs.gum}/bin/gum "$@"; }
          function forgejo() {
            # local config_file="${toString forgejo.stateDir}/custom/conf/app.ini";
            # touch $config_file
            ${forgejo.package}/bin/gitea \
              --work-path ${forgejo.stateDir} \
              "$@"
          }
          function fjuser() { forgejo admin user "$@"; }
          function awk() { ${pkgs.gawk}/bin/awk "$@"; }

          handle_undeclared_users="${
            if cfg.handleUndeclaredUsers
            then "true"
            else "false"
          }";

          declared_users=(${toString (map (user: "${
              if isPath user.name
              then "$(cat ${toString user.name})"
              else user.name
            }")
            users)});

          ${readFile ./users.sh}

          ${toString (map (user: ''
              set-user "${
                if isPath user.name
                then "$(cat ${toString user.name})"
                else user.name
              }" "${
                if isPath user.email
                then "$(cat ${toString user.email})"
                else user.email
              }" "${
                if isPath user.password
                then "$(cat ${toString user.password})"
                else user.password
              }" \
                       "${
                if user.admin
                then "true"
                else "false"
              }"
            '')
            users)}
        '';
        wantedBy = ["multi-user.target"];
        after = ["forgejo.service"];
        serviceConfig = {
          Type = "oneshot";
          User = forgejo.user;
          Group = forgejo.group;
        };
      };
    };
}
