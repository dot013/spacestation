{...}: {
  services.caddy.enable = true;

  # Some services try to enable nginx as their reverse proxy
  services.nginx.enable = false;

  # Caddy Ports
  networking.firewall.allowedTCPPorts = [80 433];
}
