{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.capytalcc.nixosModules.default
    inputs.keikoswork.nixosModules.default
  ];

  services.capytalcc.web = {
    enable = true;
    port = 7010;
  };
  services.caddy.virtualHosts.":${toString (config.services.capytalcc.web.port + 1)}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.capytalcc.web.port}
    '';
  };

  services.keikos.web = {
    enable = true;
    port = 7030;
    envFile = config.sops.secrets."keiko/env-file".path;
  };
  services.caddy.virtualHosts.":${toString (config.services.keikos.web.port + 1)}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.keikos.web.port}
    '';
  };
}
