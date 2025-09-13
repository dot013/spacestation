{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./capytal
    ./abaduh
    ./common

    ./secrets.nix

    ./hardware-configuration.nix
  ];

  # User settings
  programs.zsh.enable = true;

  users.users."guz" = {
    shell = pkgs.zsh;
    hashedPasswordFile = builtins.toString config.sops.secrets."guz/password".path;
    home = "/home/guz";
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "plugdev" "docker"];
    openssh.authorizedKeys.keyFiles = [
      ./.ssh/guz.pub
    ];
    packages = with pkgs;
      [
        libinput
      ]
      ++ (with inputs.dot013-nix.packages.${pkgs.system}.devkit; [
        git
        lazygit
        starship
        zellij
        zsh
      ]);
  };

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    settings = {
      default-cache-ttl = 3600 * 24;
    };
  };

  security.rtkit.enable = true;

  # Nix commands
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  programs.nh.enable = true;
  programs.nh.flake = "/home/guz/nix";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = rec {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = LC_ADDRESS;
    LC_MEASUREMENT = LC_ADDRESS;
    LC_MONETARY = LC_ADDRESS;
    LC_NAME = LC_ADDRESS;
    LC_NUMERIC = LC_ADDRESS;
    LC_PAPER = LC_ADDRESS;
    LC_TELEPHONE = LC_ADDRESS;
    LC_TIME = LC_ADDRESS;
  };

  console.keyMap = "br-abnt2";

  time.timeZone = "America/Sao_Paulo";

  # Networking
  networking = {
    networkmanager.enable = true;
    hostName = "spacestation";
    wireless.enable = false;
    dhcpcd.enable = true;
    defaultGateway = "192.168.0.1";
    interfaces."eno1".ipv4.addresses = [
      {
        address = "192.168.0.110";
        prefixLength = 24;
      }
    ];
    nameservers = ["9.9.9.9"];
  };

  # SSH/Mosh configuration
  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "forced-commands-only";
  };

  programs.mosh.enable = true;
  programs.mosh.openFirewall = true;

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
