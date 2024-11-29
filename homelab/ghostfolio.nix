{
  config,
  lib,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
  ghostfolioSecrets = secrets.guz.services.ghostfolio;
in {
  imports = [];

  services.ghostfolio.enable = true;
  # virtualisation.oci-containers.containers = {
  #   ghostfolio = {
  #     image = "ghostfolio/ghostfolio:latest";
  #     autoStart = true;
  #     environmentFiles = [
  #       (/. + config.sops.secrets."ghostfolio/env".path)
  #     ];
  #     dependsOn = [
  #       "ghostfolio-postgres"
  #       "ghostfolio-redis"
  #     ];
  #     ports = [
  #       "${toString ghostfolioSecrets.port}:3333"
  #     ];
  #   };
  #   ghostfolio-postgres = {
  #     image = "docker.io/library/postgres:15";
  #     environmentFiles = [
  #       (/. + config.sops.secrets."ghostfolio/env".path)
  #     ];
  #     volumes = [
  #       "/var/lib/ghostfolio/postgresql/data:/var/lib/postgresql/data"
  #     ];
  #   };
  #   ghostfolio-redis = {
  #     image = "docker.io/library/redis:alpine";
  #     environmentFiles = [
  #       (/. + config.sops.secrets."ghostfolio/env".path)
  #     ];
  #     cmd = ["redis-server" "--requirepass" "$REDIS_PASSWORD"];
  #   };
  # };
}
