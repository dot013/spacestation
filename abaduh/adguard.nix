{lib, ...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    port = 8753;
    settings = {
      filters =
        lib.mapAttrsToList (n: v: {
          enabled = true;
          id = n;
          name = n;
          url = v;
        }) {
          "Hagezi's Multi PRO" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt";

          "Hagezi's Badware Hoster" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/hoster.txt";

          "Hagezi's DNS Bypass blocking" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/doh-vpn-proxy-bypass.txt";

          "Hagezi's Dynamic DNS blocking" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/dyndns.txt";

          "Hagezi's Gambling" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/gambling.txt";

          "Hagezi's Native - LG webOS" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/native.lgwebos.txt";

          "Hagezi's Native - Tiktok (Agressive)" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/native.tiktok.extended.txt";

          "Hagezi's Native - Microsoft/Windows" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/native.winoffice.txt";

          "Hagezi's Pop-up Ads" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/popupads.txt";

          "Hagezi's TIF" = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/tif.txt";
        };
      user_rules = [
        "@@||tumblr.com^$important"
        "@@||wordpress.com^$important"
        "@@||tailscale.com^$important"
        "@@||torproject.org^$important"
        "@@||neocities.org^$important"
      ];
    };
  };

  # Ports needed to access the DNS resolver
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53 51820];
}
