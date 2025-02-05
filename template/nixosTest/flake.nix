{
  description = "nixosTest template";

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

        nixos-test = pkgs.callPackage ./nixos-test {};
      in {
        devShells.default = pkgs.mkShell {
          name = "nix devShell";
          buildInputs = with pkgs; [
            nil
            alejandra
          ];
        };

        packages = {
          default = nixos-test;
          inherit nixos-test;
        };

        checks = {
          default = nixos-test;
          inherit nixos-test;
        };
      };
    };
}
