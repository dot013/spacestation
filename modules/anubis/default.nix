{
  config,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.services.anubis;
in {
  options.services.anubis = with lib; {
    enable = mkEnableOption "Enable anubis systemd services";
    user = mkOption {
      type = with types; str;
      default = "anubis";
    };
    group = mkOption {
      type = with types; str;
      default = cfg.user;
    };
    package = mkOption {
      type = with types; package;
      default = pkgs-unstable.callPackage ./derivation.nix {}; # it uses Golang 1.24.1
    };
    instances = mkOption {
      type = with types;
        attrsOf (submodule ({
          config,
          lib,
          ...
        }: {
          options = with lib; {
            user = mkOption {
              type = with types; str;
              default = cfg.user;
            };
            group = mkOption {
              type = with types; str;
              default = cfg.group;
            };
            bind = mkOption {
              type = with types; str;
              default = ":8923";
            };
            bindNetwork = mkOption {
              type = with types; (enum ["tcp" "tcp4" "tcp6" "unix" "unixpacket"]);
              default = "tcp";
            };
            cookieDomain = mkOption {
              type = with types; str;
              default = "";
            };
            cookiePartitioned = mkOption {
              type = with types; bool;
              default = false;
            };
            difficulty = mkOption {
              type = with types; ints.unsigned;
              default = 5;
            };
            ed25519PrivateKeyHex = mkOption {
              type = with types; str;
              default = "";
            };
            ed25519PrivateKeyHexFile = mkOption {
              type = with types; (either str path);
              default = "";
            };
            metricsBind = mkOption {
              type = with types; str;
              default = ":9090";
            };
            metricsBindNetwork = mkOption {
              type = with types; (enum ["tcp" "tcp4" "tcp6" "unix" "unixpacket"]);
              default = "tcp";
            };
            socketMode = mkOption {
              type = with types; nullOr ints.unsigned;
              default = null;
            };
            policyFName = mkOption {
              type = with types; str;
              default = "";
            };
            serveRobotsTxt = mkOption {
              type = with types; bool;
              default = false;
            };
            target = mkOption {
              type = with types; str;
              default = "http://localhost:3923";
            };
            useRemoteAddress = mkOption {
              type = with types; bool;
              default = false;
            };
          };
        }));
      default = {};
    };
  };
  config = lib.mkIf cfg.enable {
    systemd.services = with lib;
    with lib.attrsets;
      mapAttrs' (n: v:
        nameValuePair "anubis-${n}" {
          after = ["network.target"];
          wantedBy = ["multi-user.target"];
          environment = {
            BIND = toString v.bind;
            BIND_NETWORK = toString v.bindNetwork;
            COOKIE_DOMAIN = toString v.cookieDomain;
            COOKIE_PARTITIONED = toString v.cookiePartitioned;
            DIFFICULTY = toString v.difficulty;
            ED25519_PRIVATE_KEY_HEX = toString v.ed25519PrivateKeyHex;
            ED25519_PRIVATE_KEY_HEX_FILE = toString v.ed25519PrivateKeyHexFile;
            METRICS_BIND = toString v.metricsBind;
            METRICS_BIND_NETWORK = toString v.metricsBindNetwork;
            SOCKET_MODE = mkIf (!isNull v.socketMode) (toString v.socketMode);
            POLICY_FNAME = toString v.policyFName;
            SERVE_ROBOTS_TXT = toString v.serveRobotsTxt;
            TARGET = toString v.target;
            USE_REMOTE_ADDRESS = toString v.useRemoteAddress;
          };
          serviceConfig = {
            Type = "simple";
            User = v.user;
            Group = v.user;
            ExecStart = "${escapeShellArg (getExe cfg.package)}";
            Restart = "on-success";
          };
        })
      cfg.instances;

    users.users = with lib.attrsets;
      (mapAttrs' (n: v:
        nameValuePair (v.user) {
          isSystemUser = true;
          group = v.group;
        })
      cfg.instances)
      // {
        "${cfg.user}" = {
          isSystemUser = true;
          group = cfg.group;
        };
      };

    users.groups = with lib.attrsets;
      (mapAttrs' (n: v:
        nameValuePair (v.user) {})
      cfg.instances)
      // {
        "${cfg.group}" = {};
      };
  };
}
