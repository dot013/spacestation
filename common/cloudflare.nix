{config, ...}: {
  virtualisation.oci-containers.containers.cloudflare-tunnel = {
    image = "cloudflare/cloudflared:latest";
    autoStart = true;
    extraOptions = [
      "--network=host"
    ];
    cmd = [
      "tunnel"
      "--no-autoupdate"
      "run"
    ];
    environmentFiles = [
      config.sops.secrets."cloudflared/tunnel-env".path
    ];
  };
}
