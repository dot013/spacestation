{pkgs, ...}: {
  services.forgejo.customization = {
    assets = ./assets;
    templates = ./templates;
    theme = {
      "capytal-dark" = ./themes/theme-capytal-dark.css;
      "bthree-dark" = ./themes/theme-bthree-dark.css;
    };
    options.label."Default" = {
      "scope/a11y" = {
        color = "d4b3a5";
        description = "Accessibility issues and improvements";
        exclusive = true;
      };
      "scope/i18n" = {
        color = "dbb594";
        description = "Internationalization issues and improvements";
        exclusive = true;
      };
      "scope/security" = {
        color = "ff977d";
        description = "Test suite changes";
        exclusive = true;
      };
      "scope/documentation" = {
        color = "e796f3";
        description = "Documentation changes";
        exclusive = true;
      };
      "scope/testing" = {
        color = "ff949d";
        description = "Test suite changes";
        exclusive = true;
      };
      "kind/enhancement" = {
        color = "4ccce6";
        description = "Improvement on existing functionality";
        exclusive = true;
      };
      "kind/bug" = {
        color = "70b8ff";
        description = "Something isn't working";
        exclusive = true;
      };
      "kind/feature" = {
        color = "9eb1ff";
        description = "New functionality";
        exclusive = true;
      };
      "priority/low" = {
        color = "bde56c";
        description = "The priority is low";
        exclusive = true;
        priority = "low";
      };
      "priority/medium" = {
        color = "f5e147";
        description = "The priority is medium";
        exclusive = true;
        priority = "medium";
      };
      "priority/high" = {
        color = "ff9592";
        description = "The priority is high";
        exclusive = true;
        priority = "high";
      };
      "priority/critical" = {
        color = "ff977d";
        description = "The priority is high";
        exclusive = true;
        priority = "critical";
      };
      "BREAKING-CHANGE" = {
        color = "b4b4b4";
        description = "This change breaks existing functionality";
      };
      "status/to-do" = {
        color = "71d083";
        description = "This is confirmed and needs work";
        exclusive = true;
      };
      "status/in-progress" = {
        color = "f5e147";
        description = "This is being worked on";
        exclusive = true;
      };
      "status/needs-info" = {
        color = "ffa057";
        description = "This needs more information to continue";
        exclusive = true;
      };
      "status/blocked" = {
        color = "ff977d";
        description = "This is blocked due to something";
        exclusive = true;
      };
      "status/abandoned" = {
        color = "b6ecf7";
        description = "This is in hiatus/abandoned until further notice";
        exclusive = true;
      };
      "status/wont-fix" = {
        color = "b5b3ad";
        description = "This issue won't be fixed";
        exclusive = true;
      };
    };
  };
}
