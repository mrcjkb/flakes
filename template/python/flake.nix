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
        python-pkgs = ps: with ps; [
          absl-py
          gflags
          pynvim
          python-lsp-server
          flake8
          git
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
