{
  description = "devShell for LaTeX projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = builtins.attrNames nixpkgs.legacyPackages;
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          name = "LaTeX devShell";
          buildInputs = with pkgs;
          with pkgs; [
            # scheme-full, scheme-small, ...
            # See https://nixos.wiki/wiki/TexLive
            alejandra
            texlab
            self.packages.${system}.texlive
            self.packages.${system}.xelatex
            biber
          ];
        };
        packages = {
          texlive = pkgs.texlive.combine {
            inherit
              (pkgs.texlive)
              geometry
              helvetic
              ragged2e
              relsize
              enumitem
              scheme-small
              academicons
              arydshln
              fontawesome5
              marvosym
              multirow
              ;
          };
          xelatex = with pkgs;
            runCommand "xelatex" {
              nativeBuildInputs = [makeWrapper];
            }
            ''
              mkdir -p $out/bin
              makeWrapper ${self.packages.${system}.texlive}/bin/xelatex $out/bin/xelatex \
                --prefix FONTCONFIG_FILE : ${makeFontsConf {fontDirectories = [lmodern font-awesome_4];}}
            '';
        };
      };
    };
}
