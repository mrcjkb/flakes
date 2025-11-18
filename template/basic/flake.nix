{
  description = "Basic nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    lib = with nixpkgs.lib;
      nixpkgs.lib
      // {
        foreach = xs: f:
          foldr recursiveUpdate {} (
            if isList xs
            then map f xs
            else if isAttrs xs
            then mapAttrsToList f xs
            else throw "foreach: expected list or attrset but got ${typeOf xs}"
          );
        findModulesList = dir:
          pipe dir [
            builtins.readDir
            (filterAttrs (name: type: type == "directory" || hasSuffix ".nix" name && name != "default.nix"))
            attrNames
            (map (f: "${dir}/${f}"))
          ];
      };
  in
    {
      inherit lib;
    }
    // lib.foreach lib.systems.flakeExposed (
      system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        legacyPackages.${system} = pkgs;
        checks.${system} = {
        };
        devShells.${system}.default = pkgs.mkShell {
          name = "devShell";
          buildInputs = [
          ];
        };
      }
    );
}
