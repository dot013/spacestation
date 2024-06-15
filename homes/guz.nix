{ config
, pkgs
, inputs
, lib
, ...
}: {
  imports = [
    inputs.dot013-environment.homeManagerModule
  ];

  programs.home-manager.enable = true;

  home.username = "guz";
  home.homeDirectory = "/home/guz";

  home.stateVersion = "23.11"; # DO NOT CHANGE
}
