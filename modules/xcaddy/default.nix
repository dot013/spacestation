{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.caddy.xcaddy;
  xcaddy = pkgs.buildGoModule {
    pname = "xcaddy";
    version = "2024-10-03";

    src = ./.;
    runVend = true;
    vendorHash = "sha256-dEuxEG6mW2V7iuSXvziR82bmF+Hwe6ePCfdNj5t3t4c=";
    meta = {
      mainProgram = "caddy";
    };
  };
in {
  options.services.caddy = with lib;
  with lib.types; {
    xcaddy.enable = mkOption {
      type = bool;
      default = false;
    };
  };
  config = with lib;
    mkIf cfg.enable {
      services.caddy.package = xcaddy;
    };
}
