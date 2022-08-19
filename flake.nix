{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";

    openal-soft_src.url = "github:kcat/openal-soft?ref=1.22.2";
    openal-soft_src.flake = false;
  };

  outputs = { self, nixpkgs, tinycmmc, openal-soft_src }:
    tinycmmc.lib.eachWin32SystemWithPkgs (pkgs:
      {
        packages = rec {
          default = openal-soft;

          openal-soft = pkgs.stdenv.mkDerivation {
            pname = "openal-soft";
            version = "1.22.2";

            src = openal-soft_src;

            nativeBuildInputs = [
              pkgs.buildPackages.cmake
              # pkgs.cmake
            ];
          };
        };
      }
    );
}
