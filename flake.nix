{
  description = "flake template for various devShells";

  outputs = { ... }: {
    templates = rec {
      default = cabal;
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
    };
  };

}
