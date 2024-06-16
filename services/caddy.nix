{
  config,
  lib,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
  deviceIp = config.services.tailscale.deviceIp;
in {
  imports = [];

  services.caddy.enable = true;
  services.caddy.virtualHosts =
    lib.attrsets.mapAttrs'
    (name: service: {
      name = service.domain;
      value = {extraConfig = "reverse_proxy ${deviceIp}:${toString service.port}";};
    })
    secrets.services;
  networking.firewall.allowedTCPPorts = [80 433];
}
