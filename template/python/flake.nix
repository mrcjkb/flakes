{
  description = "devShell for Python projects";

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
        python-pkgs = ps:
          with ps; [
            absl-py
            gflags
            pynvim
            python-lsp-server
            flake8
            thrift
            paho-mqtt
            protobuf
          ];
      in {
        devShells.default = pkgs.mkShell {
          name = "python devShell";
          buildInputs = with pkgs; [
            lua-language-server
            stylua
            luajitPackages.luacheck
            (python3.withPackages python-pkgs)
          ];
        };
      };
    };
}
