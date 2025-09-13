{
  config,
  inputs,
  ...
}: let
  cfg-capytal = config.services.capytalcc.web;
  cfg-keikos = config.services.keikos.web;
in {
  imports = [
    inputs.capytalcc.nixosModules.default
    inputs.keikoswork.nixosModules.default
  ];

  services.capytalcc.web = {
    enable = true;
    port = 9900;
  };
  services.caddy.virtualHosts.":${toString (cfg-capytal.port + 1)}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString cfg-capytal.port}
    '';
  };

  services.keikos.web = {
    enable = true;
    port = 9910;
    envFile = config.sops.secrets."keiko/env-file".path;
  };
  services.caddy.virtualHosts.":${toString (cfg-keikos.port + 1)}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString cfg-keikos.port}
    '';
  };
}
