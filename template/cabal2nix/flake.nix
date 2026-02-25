{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    with builtins; let
      inherit (inputs.nixpkgs) lib;
      foreach = xs: f:
        with lib;
          foldr recursiveUpdate {} (
            if isList xs
            then map f xs
            else if isAttrs xs
            then mapAttrsToList f xs
            else throw "foreach: expected list or attrset but got ${typeOf xs}"
          );

      projectSourceFilter = root:
        with lib.fileset;
          toSource {
            inherit root;
            fileset =
              fileFilter
              (file:
                builtins.any file.hasExt ["cabal" "hs" "md"])
              root;
          };

      ghcsFor = pkgs:
        with lib;
          foldlAttrs
          (
            acc: name: hp': let
              hp = builtins.tryEval hp';
              version = getVersion hp.value.ghc;
              majorMinor = versions.majorMinor version;
              ghcName = "ghc${replaceStrings ["."] [""] majorMinor}";
            in
              if hp.value ? ghc && !acc ? ${ghcName} && versionAtLeast version "9.6" && versionOlder version "9.13"
              then acc // {${ghcName} = hp.value;}
              else acc
          )
          {}
          pkgs.haskell.packages;

      hpsFor = pkgs: {default = pkgs.haskellPackages;} // ghcsFor pkgs;

      projects = with lib;
        genAttrs' (fileset.toList (fileset.fileFilter (file: file.hasExt "cabal") ./.)) (
          file: nameValuePair (removeSuffix ".cabal" (baseNameOf file)) (dirOf file)
        );
      pnames = lib.attrNames projects;
      libPnames = filter (pname: pname != "<non-lib-name>") pnames;

      haskell-overlay = pkgs:
        lib.composeManyExtensions [
          (hfinal: hprev: lib.mapAttrs (pname: dir: hfinal.callCabal2nix pname (projectSourceFilter dir) {}) projects)
        ];

      overlay = lib.composeManyExtensions [
        (final: prev: {
          haskell =
            prev.haskell
            // {
              packageOverrides = lib.composeManyExtensions [
                prev.haskell.packageOverrides
                (haskell-overlay final)
              ];
            };
          haskell-overlay = haskell-overlay final;
        })
      ];
    in
      {
        overlays = {
          default = overlay;
        };
      }
      // foreach inputs.nixpkgs.legacyPackages (
        system: pkgs': let
          pkgs = pkgs'.extend overlay;
          hps = hpsFor pkgs;
          name = "haskell-packages";
          bins = pkgs.buildEnv {
            name = "${name}-bins";
            paths = map (pname: hps.default.${pname}) pnames;
            pathsToLink = ["/bin"];
          };
          libs = pkgs.buildEnv {
            name = "${name}-libs";
            paths = map (pname: hps.default.${pname}) libPnames;
            pathsToLink = ["/lib"];
          };
          docs = pkgs.buildEnv {
            name = "${name}-docs";
            paths = map (pname: pkgs.haskell.lib.documentationTarball hps.default.${pname}) libPnames;
          };
          sdist = pkgs.buildEnv {
            name = "${name}-sdist";
            paths = map (pname: pkgs.haskell.lib.sdistTarball hps.default.${pname}) libPnames;
          };
          docsAndSdist = pkgs.linkFarm "${name}-docsAndSdist" {inherit docs sdist;};
          all = pkgs.symlinkJoin {
            name = "${name}-all";
            paths = [bins libs docsAndSdist];
          };
        in {
          packages.${system}.default = all;

          legacyPackages.${system} = pkgs;

          devShells.${system} = foreach hps (
            ghcName: hp: {
              ${ghcName} = hp.shellFor {
                packages = ps: map (pname: ps.${pname}) pnames;
                nativeBuildInputs = with pkgs';
                with haskellPackages; [
                  cabal-gild
                  cabal-install
                  fourmolu
                  ghcid
                  hp.haskell-language-server
                  nixpkgs-fmt
                ];
              };
            }
          );

          checks.${system} = {
            formatting =
              pkgs.runCommand "formatting-check"
              {
                nativeBuildInputs = [pkgs.fd pkgs.moreutils];
              }
              ''
                cp -r --preserve=timestamps "${./.}" src
                cd src
                chmod -R u+w .
                chronic "${lib.getExe inputs.self.formatter.${system}}"
                fd --type=file --changed-within=1day > "$out"
                if [ -s "$out" ]; then
                  echo "The following files were modified by the formatter:" >&2
                  cat "$out" >&2
                  exit 1
                fi
              '';
          };

          formatter.${system} = pkgs.writeShellApplication {
            name = "formatter";
            runtimeInputs = with pkgs;
            with haskellPackages; [
              cabal-gild
              fd
              fourmolu
              nixpkgs-fmt
            ];
            text = ''
              if [ "$#" -eq 0 ]; then
                fd --extension=nix -X nixpkgs-fmt
                fd --extension=hs -X fourmolu -i
                fd --extension=cabal -x cabal-gild --io
              else
                while [ "$#" -gt 0 ]; do
                  extension="''${1##*.}"
                  case "$extension" in
                      nix)
                          nixpkgs-fmt "$1"
                          ;;
                      hs)
                          fourmolu -i "$1"
                          ;;
                      cabal)
                          cabal-gild --io "$1"
                          ;;
                      *)
                          echo "Unsupported file type: $1" >&2
                          ;;
                  esac
                  shift
                done
              fi
            '';
          };
        }
      );
}
