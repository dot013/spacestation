{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
  garageCfg = secrets.capytal.services.garage;
in {
  imports = [];

  services.garage.enable = true;
  services.garage.package = pkgs.garage_1_x;
  services.garage.settings = {
    db_engine = "sqlite";

    replication_factor = 1;

    rpc_bind_addr = "[::]:${toString garageCfg.rpc.port}";
    rpc_public_addr = "127.0.0.1:${toString garageCfg.rpc.port}";
    rpc_secret = garageCfg.rpc.token;

    s3_api = {
      s3_region = "garage";
      api_bind_addr = "[::]:${toString garageCfg.api.port}";
      root_domain = ".s3.garage.localhost";
    };

    s3_web = {
      bind_addr = "[::]:${toString garageCfg.web.port}";
      root_domain = ".web.garage.localhost";
      index = "index.html";
    };

    k2v_api = {
      api_bind_addr = "[::]:${toString garageCfg.k2v.port}";
    };

    admin = {
      api_bind_addr = "[::]:${toString garageCfg.admin.port}";
      admin_token = garageCfg.admin.token;
      metrics_token = garageCfg.admin.metrics_token;
    };
  };

  networking.firewall.allowedTCPPorts = [
    garageCfg.rpc.port
    garageCfg.api.port
    garageCfg.web.port
    garageCfg.k2v.port
    garageCfg.admin.port
  ];

  environment.systemPackages = with pkgs; [awscli2];
}
