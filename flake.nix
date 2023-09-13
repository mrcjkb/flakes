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
    };
  };

}
