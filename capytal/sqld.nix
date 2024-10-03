{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.spacestation-secrets.lesser;
  sqldCfg = secrets.capytal.services.sqld;
in {
  imports = [];

  environment.systemPackages = [
    pkgs.sqld
  ];

  systemd.services.sqld = with lib; let
    sqld = escapeShellArg (getExe pkgs.sqld);
  in {
    after = ["network.target" "network-online.target"];
    wants = ["network.target" "network-online.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${sqld} --http-listen-addr ${secrets.device-ip}:${toString sqldCfg.http-port} --grpc-listen-addr ${secrets.device-ip}:${toString sqldCfg.grpc-port}";
    };
  };

  networking.firewall.allowedTCPPorts = [
    8080
  ];
}
