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

  services.keikos.web = {
    enable = true;
    port = 7030;
    envFile = config.sops.secrets."keiko/envFile".path;
  };
}
