{
  config,
  inputs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [
    inputs.keikoswork.nixosModules.default
  ];

  services.keikos.web = {
    enable = true;
    port = secrets.guz.services."keikos.work".port;
    envFile = config.sops.secrets."keiko/envFile".path;
  };
}
