{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services
    ./modules
    ./secrets.nix
    ./capytal
  ];

  programs.nh.enable = true;
  programs.nh.flake = "/home/guz/nix";

  profiles.locale.enable = true;

  programs.zsh.enable = true;

  programs.mosh.enable = true;
  programs.mosh.openFirewall = true;

  users.users."guz" = {
    shell = pkgs.zsh;
    hashedPasswordFile = builtins.toString config.sops.secrets."guz/password".path;
    home = "/home/guz";
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "plugdev" "docker"];
    openssh.authorizedKeys.keyFiles = [
      ./.ssh/guz.pub
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    settings = {
      default-cache-ttl = 3600 * 24;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    libinput
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nixVersions.nix_2_21;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  networking = {
    networkmanager.enable = true;
    hostName = "spacestation";
    wireless.enable = false;
    dhcpcd.enable = true;
    defaultGateway = "${config.spacestation-secrets.lesser.devices.defaultGateway}";
    interfaces."eno1".ipv4.addresses = [
      {
        address = "${config.spacestation-secrets.lesser.devices.spacestation}";
        prefixLength = 24;
      }
    ];
    nameservers = ["9.9.9.9"];
  };

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "forced-commands-only";
  };

  security.rtkit.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
