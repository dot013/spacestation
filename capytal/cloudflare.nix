{config, ...}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [];

  virtualisation.oci-containers.containers.cloudflare-funnel = {
    image = "cloudflare/cloudflared:latest";
    autoStart = true;
    extraOptions = [
      "--network=host"
    ];
    cmd = [
      "tunnel"
      "--no-autoupdate"
      "run"
      "--token"
      secrets.capytal.cloudflare-funnel
    ];
    environment = {};
  };
}
