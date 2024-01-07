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
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
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
            texlive.combined.scheme-medium
            biber
          ];
        };
      };
    };
}
