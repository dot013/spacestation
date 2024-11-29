{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
  qbittorrentSecrets = secrets.guz.services.qbittorrent;
in {
  imports = [];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    qbittorrent-nox
  ];

  services.jellyfin = {
    enable = true;
  };

  services.jellyseerr = {
    enable = false;
    port = 8097;
    openFirewall = true;
  };

  services.sonarr = {
    enable = false;
  };

  services.radarr = {
    enable = false;
  };

  services.bazarr = {
    enable = false;
  };

  nixpkgs.overlays = [
    (final: prev: {
      qbittorrent = prev.qbittorrent.override {guiSupport = false;};
    })
  ];

  qt.enable = true;

  systemd.services.qbittorrent = let
    dataDir = "/var/lib/qbittorrent";
    configDir = "${dataDir}/.config";
  in {
    after = ["network.target"];
    description = "qBittorrent Daemon";
    wantedBy = ["multi-user.target"];
    path = [pkgs.qbittorrent-nox];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox \
          --profile=${configDir} \
          --webui-port=${toString qbittorrentSecrets.port}
      '';
      Restart = "on-success";
      User = "qbittorrent";
      Group = "qbittorrent";
      UMask = "0002";
      LimitNOFILE = 4096;
    };
    environment = {
      QBT_PROFILE = "/var/lib/qbittorrent";
      QBT_WEBUI_PORT = toString qbittorrentSecrets.port;
    };
  };

  users = {
    users."qbittorrent" = {
      group = "qbittorrent";
      home = "/var/lib/qbittorrent";
      createHome = true;
      description = "qBittorrent Daemon user";
      isSystemUser = true;
    };
    groups."qbittorrent" = {gid = null;};
  };
}
