{inputs, ...}: let
  catppuccin-base16 = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/tinted-theming/schemes/spec-0.11/base16/catppuccin-mocha.yaml";
    sha256 = "1vmw5fqqsg8vsbg6pr44r61pxq1r8kycwd35j3ffmd9s3pxddcvf";
  };
in {
  imports = [
    inputs.base16.nixosModule
    ./forgejo
    ./garage.nix
    ./music-bot.nix
  ];

  scheme = catppuccin-base16;
}
