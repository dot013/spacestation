{...}: {
  imports = [
    ./prata-music.nix
  ];
  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
    };
  };
}
