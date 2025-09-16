{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.secrets = {
    "cloudflared/tunnel-env" = {};

    "forgejo/user1/name" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    "forgejo/user1/password" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    "forgejo/user1/email" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    "forgejo/git-password" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    "forgejo/anubis/hexFile" = {
      owner = config.services.anubis.instances."forgejo".user;
    };

    "garage/admin_key" = mkIf config.services.garage.enable {
      owner = config.systemd.services.garage.serviceConfig.User;
    };
    "garage/admin_secret" = mkIf config.services.garage.enable {
      owner = config.systemd.services.garage.serviceConfig.User;
    };
    "garage/admin_token" = mkIf config.services.garage.enable {
      owner = config.systemd.services.garage.serviceConfig.User;
    };
    "garage/metrics_token" = mkIf config.services.garage.enable {
      owner = config.systemd.services.garage.serviceConfig.User;
    };
    "garage/rpc_secret" = mkIf config.services.garage.enable {
      owner = config.systemd.services.garage.serviceConfig.User;
    };

    "guz/password" = {
      owner = config.users.users."guz".name;
    };

    "keiko/env-file" = {
      owner = config.services.keikos.web.user;
    };

    "nextcloud/adminpass" = mkIf config.services.nextcloud.enable {
      owner = "nextcloud";
    };
    "nextcloud/s3/secret" = mkIf config.services.nextcloud.enable {
      owner = "nextcloud";
    };
    "nextcloud/s3/sseC" = mkIf config.services.nextcloud.enable {
      owner = "nextcloud";
    };

    "pgadmin/password" = mkIf config.services.pgadmin.enable {
      owner = config.systemd.services.pgadmin.serviceConfig.User;
    };

    "medama/anubis/hexFile" = {
      owner = config.services.anubis.instances."medama".user;
    };
  };

  sops.age.keyFile = "/home/guz/.config/sops/age/keys.txt";
}
