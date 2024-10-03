{config, ...}: {
  imports = [];
  virtualisation.oci-containers.containers.capytal-music = {
    image = "codetheweb/muse:latest";
    autoStart = true;
    volumes = [
      "/var/lib/muse/data:/data"
    ];
    environmentFiles = [
      (/. + config.sops.secrets."discord/muse-bot/environment".path)
    ];
  };
}
