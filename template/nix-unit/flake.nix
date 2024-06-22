{
  description = "A very basic nix-unit example";

  outputs = {
    self,
    nixpkgs,
  }: let
    add = x: y: x + y;
  in {
    # Run this with: nix-unit --flake '.addTest'
    addTest = {
      testPasses = {
        expr = add 1 1;
        expected = 2;
      };
      testFails = {
        expr = add 1 1;
        expected = 3;
      };
    };
  };
}
