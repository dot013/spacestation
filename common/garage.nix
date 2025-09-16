{
  config,
  pkgs,
  ...
}: let
  port_admin = 3460;
  port_s3_api = 3461;
  port_web = 3462;
  port_k2v = 3463;
  port_rpc = 3464;
  domain_s3_api = "s3.garage.local";
  domain_web = "web.garage.local";

  cfg = config.services.garage;
in {
  services.garage = {
    enable = true;
    package = pkgs.garage_2;
    settings = {
      compression_level = 8;
      replication_factor = 1;

      db_engine = "sqlite";
      metadata_fsync = true;
      data_fsync = true;
      data_dir = [
        {
          capacity = "500G";
          path = "/var/lib/garage/data";
        }
        {
          capacity = "500G";
          path = "/hard/var/lib/garage/data";
        }
      ];

      admin = {
        api_bind_addr = "[::]:${toString port_admin}";
        admin_token_file = config.sops.secrets."garage/admin_token".path;
        metrics_token_file = config.sops.secrets."garage/metrics_token".path;
      };

      s3_api = {
        s3_region = "garage";
        api_bind_addr = "[::]:${toString port_s3_api}";
        root_domain = ".${domain_s3_api}";
      };

      s3_web = {
        index = "index.html";
        bind_addr = "[::]:${toString port_web}";
        root_domain = ".${domain_web}";
      };

      k2v_api = {
        api_bind_addr = "[::]:${toString port_k2v}";
      };

      rpc_bind_addr = "[::]:${toString port_rpc}";
      rpc_public_addr = "127.0.0.1:${toString port_rpc}";
      rpc_secret_file = config.sops.secrets."garage/rpc_secret".path;
    };
  };

  systemd.services.garage.serviceConfig = {
    User = "garage";
    Group = "garage";
  };
  users = {
    users.garage = {
      isSystemUser = true;
      group = "garage";
      packages = [
        (pkgs.symlinkJoin {
          name = "awscli";
          paths = [pkgs.awscli2];
          buildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram "$out/bin/aws" \
              --set-default 'AWS_ACCESS_KEY_ID' "$(cat ${config.sops.secrets."garage/admin_key".path})" \
              --set-default 'AWS_SECRET_ACCESS_KEY' "$(cat ${config.sops.secrets."garage/admin_secret".path})" \
              --set-default 'AWS_DEFAULT_REGION' '${config.services.garage.settings.s3_api.s3_region}' \
              --set-default 'AWS_ENDPOINT_URL' "http://localhost:${toString port_s3_api}"
          '';
        })
      ];
    };
    groups.garage = {};
  };

  services.caddy.virtualHosts = {
    "${domain_s3_api}".extraConfig = ''
      reverse_proxy http://localhost:${toString port_s3_api}
      tls internal
    '';
    "${domain_web}".extraConfig = ''
      reverse_proxy http://localhost:${toString port_web}
      tls internal
    '';
    "*.${domain_web}".extraConfig = ''
      reverse_proxy http://localhost:${toString port_web}
      tls internal
    '';
  };
}
