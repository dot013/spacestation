{ config
, lib
, pkgs
, ...
}: {
  imports = [ ];
  virtualisation.oci-containers.containers.prata-music = {
    image = "codetheweb/muse:latest";
    autoStart = true;
    volumes = [
      "/var/lib/muse/data:/data"
    ];
    environmentFiles = [
      (/. + config.sops.secrets."muse/secrets".path)
    ];
  };
}
