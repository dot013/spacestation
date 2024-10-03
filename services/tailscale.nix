{...}: {
  imports = [
    ../modules/tailscale.nix
  ];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    exitNode = true;
  };
}
