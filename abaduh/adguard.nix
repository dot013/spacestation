{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.adguardhome;
in {
  services.adguardhome = rec {
    enable = true;
    openFirewall = true;
    port = 8753;
    settings = {
      http = {address = "127.0.0.1:${toString port}";};
      users = [
        {
          name = "admin";
          password = "$2a$12$ciAyKG13D2ViEsy6fACxGu.1qEwwrAfPVgaVQdYgmkmvODHYuVWPa";
        }
      ];
      theme = "dark";
      dns = {
        bind_hosts = [
          "127.0.0.1"
          (elemAt config.networking.interfaces."eno1".ipv4.addresses 0).address
          "100.86.139.22"
        ];
        upstram_dns = ["9.9.9.9"];
      };
      filtering = {
        rewrites = mkIf config.services.caddy.enable (pipe config.services.caddy.virtualHosts [
          (filterAttrs (n: v: hasSuffix ".local" n))
          (mapAttrsToList (domain: _: {
            domain = removePrefix "https://" (removePrefix "http://" domain);
            answer = "100.86.139.22";
          }))
        ]);
        parental_enabled = false;
        safe_search.enabled = false;
        safebrowsing_enabled = false;
        blocked_services = {
          ids = ["youtube"];
          schedule =
            (mapAttrs (n: v: {
                start = elemAt v 0;
                end = elemAt v 1;
              }) rec {
                sat = ["0s" "24h"];
                sun = sat;
                mon = ["18h" "24h"];
                tue = mon;
                wed = mon;
                thu = mon;
                fri = mon;
              })
            // {
              time_zone = config.time.timeZone;
            };
        };
      };
      filters =
        imap (id: url: {
          enabled = true;
          inherit id url;
        }) [
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/hoster.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/doh-vpn-proxy-bypass.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/dyndns.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/gambling.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/native.lgwebos.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/native.tiktok.extended.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/native.winoffice.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/popupads.txt"
          "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/tif.txt"
        ];
      user_rules = [
        "@@||neocities.org^$important"
        "@@||tailscale.com^$important"
        "@@||torproject.org^$important"
        "@@||tumblr.com^$important"
        "@@||wordpress.com^$important"
      ];
    };
  };

  services.caddy.virtualHosts."adguard.local" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString cfg.port}
      tls internal
    '';
  };

  # Ports needed to access the DNS resolver
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53 51820];
}
