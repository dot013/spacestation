{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [
    ../modules/tailscale.nix
  ];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    exitNode = true;
    tailnetName = secrets.tailnet-name;
    deviceIp = secrets.device-ip;
  };
}
