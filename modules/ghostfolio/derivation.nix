{
  lib,
  pkgs ? import <nixpkgs>,
  fetchzip,
}: let
in
  pkgs.buildNpmPackage rec {
    pname = "ghostfolio";
    version = "2.124.1";

    src = fetchzip {
      url = "https://github.com/ghostfolio/ghostfolio/archive/refs/tags/${version}.zip";
      hash = lib.fakeSha256;
    };

    npmDepsHash = lib.fakeSha256;

    preBuild = ''
      cp ./package.json $out/package.json
      cp ./package-lock.json $out/package-lock.json
      cp ./prisma/schema.prisma $out/prisma/schema.prisma

      cp ./decorate-angular-cli.js $out/decorate-angular.cli.js

      cp ./nx.json $out/nx.json
      cp ./replace.build.js $out/replace.build.js
      cp ./jest.preset.js $out/jest.preset.js
      cp ./tsconfig.base.json $out/tsconfig.base.json
      cp ./libs $out/libs
      cp ./apps $out/apps
    '';

    buildPhase = ''
      runHook preBuild

      npm run build:production

      runHook postBuild
    '';
  }
