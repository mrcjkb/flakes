{
  description = "flake template for various devShells";

  outputs = { ... }: {
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
      rust = {
        path = ./template/rust;
        description = ''
          A devShell template for Rust projects.
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
    };
  };

}
