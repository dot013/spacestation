{
  config,
  inputs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
in {
  imports = [
    inputs.capytalcc.nixosModules.default
  ];

  services.capytalcc.web = {
    enable = true;
    port = secrets.guz.services."capytal.cc".port;
  };
}
