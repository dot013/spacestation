{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.medama;
in {
  imports = [];
  options.services.medama = {
    enable = mkEnableOption "";
    ssl = mkEnableOption "";
    port = mkOption {
      type = with types; port;
      default = 8080;
    };
    cors = mkOption {
      type = with types; listOf str;
      default = [];
      apply = v: concatStringsSep "," v;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.medama = {
      image = "ghcr.io/medama-io/medama:v0.5.2";
      autoStart = true;
      extraOptions = ["--network=host"];
      volumes = [
        "/var/lib/medama/data:/app/data"
      ];
      environment = {
        AUTO_SLL = toString cfg.ssl;
        PORT = toString cfg.port;
        CORS_ALLOWED_ORIGINS = cfg.cors;
      };
    };
  };
}
