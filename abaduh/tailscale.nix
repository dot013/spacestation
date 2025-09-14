{
  config,
  lib,
  ...
}:
with lib; {
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--advertise-exit-node"
    ];
    useRoutingFeatures = "both";
    permitCertUid = mkIf config.services.caddy.enable "caddy";
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = mkDefault 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = mkDefault 1;
}
