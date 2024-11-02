{config, ...}: let
  secrets = config.spacestation-secrets.lesser;
  adguardCfg = secrets.guz.services.adguard;
in {
  imports = [
    ../modules/adguardhome.nix
  ];
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    port = adguardCfg.port;
    dns.filters = {
      "Hagezi's Multi PRO" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt";
      };
      "Hagezi's Badware Hoster" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/hoster.txt";
      };
      "Hagezi's DNS Bypass blocking" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/doh-vpn-proxy-bypass.txt";
      };
      "Hagezi's Dynamic DNS blocking" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/dyndns.txt";
      };
      "Hagezi's Gambling" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/gambling.txt";
      };
      "Hagezi's Native - LG webOS" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/native.lgwebos.txt";
      };
      "Hagezi's Native - Tiktok (Agressive)" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/native.tiktok.extended.txt";
      };
      "Hagezi's Native - Microsoft/Windows" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/native.winoffice.txt";
      };
      "Hagezi's Pop-up Ads" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/popupads.txt";
      };
      "Hagezi's TIF" = {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/tif.txt";
      };
    };
    settings.user_rules = [
      "@@||tumblr.com^$important"
      "@@||wordpress.com^$important"
      "@@||tailscale.com^$important"
      "@@||torproject.org^$important"
      "@@||neocities.org^$important"
    ];
  };
}
