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
  };
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.medama = {
      image = "ghcr.io/medama-io/medama:v0.5.2";
      autoStart = true;
      ports = [
        "${cfg.port}:8080"
      ];
      volumes = [
        "/var/lib/medama/data:/app/data"
      ];
      environment = {
        AUTO_SLL = toString cfg.ssl;
        PORT = toString 8080;
      };
    };
  };
}
