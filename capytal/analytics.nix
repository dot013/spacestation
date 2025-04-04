{config, ...}: let
  port = config.services.medama.port;
in {
  services.medama.enable = true;
  services.medama.port = 6010;

  services.caddy.virtualHosts.":${toString (port + 1)}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString (port + 2)} {
        header_up X-Real-Ip {remote_host}
      }
    '';
  };
}
