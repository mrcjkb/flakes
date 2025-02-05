{
  description = "flake template for various devShells";

  inputs = {
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
        pkgs,
        system,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          name = "nix devShell";
          buildInputs = with pkgs;
          with pkgs; [
            nil
            alejandra
          ];
        };
      };
      flake = {
        templates = rec {
          default = cabal;
          nix = {
            path = ./template/nix;
            description = ''
              A basic Nix devShell.
            '';
          };
          cabal = {
            path = ./template/cabal;
            description = ''
              A devShell template for Haskell Cabal projects.
            '';
          };
          stack = {
            path = ./template/stack;
            description = ''
              A devShell template for Haskell Stack projects.
            '';
          };
          lua = {
            path = ./template/lua;
            description = ''
              A devShell template for Lua projects.
            '';
          };
          nvim = {
            path = ./template/nvim;
            description = ''
              A devShell template for Neovim Lua plugins.
            '';
          };
          rocks-nvim = {
            path = ./template/rocks-nvim;
            description = ''
              A devShell template for debuggind rocks.nvim installs.
            '';
          };
          rust = {
            path = ./template/rust;
            description = ''
              A devShell template for Rust projects.
            '';
          };
          zig = {
            path = ./template/zig;
            description = ''
              A devShell template for Zig projects.
            '';
          };
          java = {
            path = ./template/java;
            description = ''
              A devShell template for Java projects.
            '';
          };
          python = {
            path = ./template/python;
            description = ''
              A devShell template for Python projects.
            '';
          };
          tex = {
            path = ./template/tex;
            description = ''
              A devShell template for LaTeX projects.
            '';
          };
          basic = {
            path = ./template/basic;
            description = ''
              A basic nix flake.
            '';
          };
          nixosTest = {
            path = ./template/nixosTest;
            description = ''
              A nixosTest template.
            '';
          };
          nix-unit = {
            path = ./template/nix-unit;
            description = ''
              A nix-unit template.
            '';
          };
        };
      };
    };
}
