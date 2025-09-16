{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.postgresql;
  cfgadm = config.services.pgadmin;
in {
  services.postgresql = {
    authentication = lib.mkForce ''
      #type database DBuser origin-address auth-method
      local all      all    trust
      # ipv4
      host  all      all    172.0.0.1/32   trust
      # ipv6
      host  all      all    ::1/128        trust
    '';
    enable = true;
    ensureDatabases = [
      "nextcloud"
    ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
    enableTCPIP = true;
    settings = {
      port = 3245;
    };
  };

  services.caddy.virtualHosts = {
    "db.local".extraConfig = ''
      reverse_proxy http://localhost:${toString cfg.settings.port}
      tls internal
    '';
  };
}
