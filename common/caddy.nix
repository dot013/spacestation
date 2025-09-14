{...}: {
  services.caddy.enable = true;

  # Caddy Ports
  networking.firewall.allowedTCPPorts = [80 433];
}
