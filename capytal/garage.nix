{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [];

  services.garage.enable = true;
  services.garage.package = pkgs.garage_1_x;
  services.garage.settings = {
    db_engine = "sqlite";

    replication_factor = 1;

    rpc_bind_addr = "[::]:${toString secrets.services.garage-rpc.port}";
    rpc_public_addr = "127.0.0.1:${toString secrets.services.garage-rpc.port}";
    rpc_secret = secrets.services.garage-rpc.token;

    s3_api = {
      s3_region = "garage";
      api_bind_addr = "[::]:${toString secrets.services.garage-api.port}";
      root_domain = ".s3.garage.localhost";
    };

    s3_web = {
      bind_addr = "[::]:${toString secrets.services.garage-web.port}";
      root_domain = ".web.garage.localhost";
      index = "index.html";
    };

    k2v_api = {
      api_bind_addr = "[::]:${toString secrets.services.garage-k2v.port}";
    };

    admin = {
      api_bind_addr = "[::]:${toString secrets.services.garage-admin.port}";
      admin_token = secrets.services.garage-admin.token;
      metrics_token = secrets.services.garage-admin.metrics_token;
    };
  };

  networking.firewall.allowedTCPPorts = [
    secrets.services.garage-rpc.port
    secrets.services.garage-api.port
    secrets.services.garage-web.port
    secrets.services.garage-k2v.port
    secrets.services.garage-admin.port
  ];

  environment.systemPackages = with pkgs; [awscli2];
}
