{
  config,
  lib,
  ...
}: let
  cfg = config.services.ghostfolio;
in
  with lib; {
    imports = [];
    options.services.ghostfolio = with lib.types; {
      enable = mkEnableOption "";
    };
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        (callPackage ./derivation {inherit lib pkgs;})
      ];
    };
  }
