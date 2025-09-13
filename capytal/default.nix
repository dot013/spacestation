{config, ...}: {
  imports = [
    ./analytics.nix
    ./forgejo.nix
    ./websites.nix
  ];

  services.caddy.enable = true;

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

  # Caddy Ports
  networking.firewall.allowedTCPPorts = [80 433];
}
