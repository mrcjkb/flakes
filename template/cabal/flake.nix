{
  description = "devShell for Haskell Cabal projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }: flake-parts.lib.mkFlake {inherit inputs;} {
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
        devShells.default = pkgs.haskellPackages.shellFor {
          name = "Cabal devShell";
          packages = p: [];
          withHoogle = true;
          buildInputs =
            (with pkgs; [
              zlib
              haskellPackages.fast-tags
              haskell-language-server
              haskellPackages.implicit-hie
              cabal-install
            ]);
        };
      };
    };
}
