{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.adguardhome;
in {
    enable = true;
    openFirewall = true;
    port = 8753;
    settings = {
      http = {address = "127.0.0.1:${toString port}";};
      filtering = {
        rewrites = mapAttrsToList (domain: answer: {inherit domain answer;}) {
          "abaduh.local" = "100.86.139.22";
          "*.abaduh.local" = "100.86.139.22";
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

  services.caddy.virtualHosts."adguard.abaduh.local" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString cfg.port}
      tls internal
    '';
  };

  # Ports needed to access the DNS resolver
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53 51820];
}
