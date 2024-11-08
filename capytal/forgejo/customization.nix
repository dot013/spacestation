{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
with builtins; let
  frappurccino-theme =
    readFile
    "${inputs.frappurccino-forgejo.packages.${pkgs.system}.default}/css/theme-frappurccino-mocha-sky.css";

  cal-sans = pkgs.fetchzip {
    url = "https://github.com/calcom/font/releases/download/v1.0.0/CalSans_Semibold_v1.0.0.zip";
    stripRoot = false;
    hash = "sha256-JqU64JUgWimJgrKX3XYcml8xsvy//K7O5clNKJRGaTM=";
  };
  fonts-css = pkgs.writeText "custom.css" ''
    @font-face {
      family: 'Cal Sans';
      src:
        url('assets/fonts/CalSans-SemiBold.woff2') format('woff2'),
        url('assets/fonts/CalSans-SemiBold.woff') format('woff'),
        url('assets/fonts/CalSans-SemiBold.ttf') format('truetype');
    };
  '';
in {
  services.forgejo.customization = {
    assets = ./assets;
    templates = ./templates;
    theme = {
      "frappurccino" = frappurccino-theme;
      "capytal-dark" = ./themes/theme-capytal-dark.css;
      "bthree-dark" = ./themes/theme-bthree-dark.css;
    };
    options.label."Default" = with config.scheme.withHashtag; {
      "scope/a11y" = {
        color = base06;
        description = "Accessibility issues and improvements";
        exclusive = true;
      };
      "scope/i18n" = {
        color = base0F;
        description = "Internationalization issues and improvements";
        exclusive = true;
      };
      "scope/security" = {
        color = base08;
        description = "Test suite changes";
        exclusive = true;
      };
      "scope/documentation" = {
        color = base0E;
        description = "Documentation changes";
        exclusive = true;
      };
      "scope/testing" = {
        color = base0E;
        description = "Test suite changes";
        exclusive = true;
      };
      "kind/enhancement" = {
        color = base0C;
        description = "Improvement on existing functionality";
        exclusive = true;
      };
      "kind/bug" = {
        color = base0D;
        description = "Something isn't working";
        exclusive = true;
      };
      "kind/feature" = {
        color = base07;
        description = "New functionality";
        exclusive = true;
      };
      "priority/low" = {
        color = base0B;
        description = "The priority is low";
        exclusive = true;
        priority = "low";
      };
      "priority/medium" = {
        color = base0A;
        description = "The priority is medium";
        exclusive = true;
        priority = "medium";
      };
      "priority/high" = {
        color = base09;
        description = "The priority is high";
        exclusive = true;
        priority = "high";
      };
      "priority/critical" = {
        color = base08;
        description = "The priority is high";
        exclusive = true;
        priority = "critical";
      };
      "BREAKING-CHANGE" = {
        color = base05;
        description = "This change breaks existing functionality";
      };
      "status/to-do" = {
        color = base0B;
        description = "This is confirmed and needs work";
        exclusive = true;
      };
      "status/in-progress" = {
        color = base0A;
        description = "This is being worked on";
        exclusive = true;
      };
      "status/needs-info" = {
        color = base09;
        description = "This needs more information to continue";
        exclusive = true;
      };
      "status/blocked" = {
        color = base08;
        description = "This is blocked due to something";
        exclusive = true;
      };
      "status/abandoned" = {
        color = base05;
        description = "This is in hiatus/abandoned until further notice";
        exclusive = true;
      };
      "status/wont-fix" = {
        color = base0E;
        description = "This issue won't be fixed";
        exclusive = true;
      };
    };
  };
}
