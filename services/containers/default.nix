{...}: {
  imports = [
    ./cloudflare-funnel.nix
  ];
  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
    };
  };
}
