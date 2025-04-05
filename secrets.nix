{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  lesser-secrets = with builtins;
    fromJSON (readFile ./secrets/spacestation.lesser.decrypted.json);
  jsonType = pkgs.formats.json {};
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  options.spacestation-secrets = with lib;
  with lib.types; {
    lesser = mkOption {
      type = submodule ({...}: {
        freeformType = jsonType.type;
        options = {};
      });
      default = lesser-secrets;
    };
  };
  config = with lib; {
    environment.systemPackages = with pkgs; [
      sops
    ];

    sops.defaultSopsFile = ./secrets/spacestation.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.secrets."guz/password" = {
      owner = config.users.users."guz".name;
    };

    sops.secrets."keiko/env-file" = {
      owner = config.services.keikos.web.user;
    };

    sops.secrets."forgejo/user1/name" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    sops.secrets."forgejo/user1/password" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    sops.secrets."forgejo/user1/email" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    sops.secrets."forgejo/git-password" = mkIf config.services.forgejo.enable {
      owner = config.services.forgejo.user;
    };
    sops.secrets."forgejo/anubis/hexFile" = {
      owner = config.services.anubis.instances."forgejo".user;
    };

    sops.secrets."medama/anubis/hexFile" = {
      owner = config.services.anubis.instances."medama".user;
    };

    sops.secrets."cloudflared/tunnel-env" = {};

    sops.age.keyFile = "/home/guz/.config/sops/age/keys.txt";
  };
}
