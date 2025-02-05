{
  description = "devShell for debugging rocks.nvim installs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    neorocks.url = "github:nvim-neorocks/neorocks";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
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
        system,
        ...
      }: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            neorocks.overlays.default
            gen-luarc.overlays.default
          ];
        };
        luarc = pkgs.mk-luarc {
          nvim = pkgs.neovim-nightly;
          neodev-types = "nightly";
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "lua devShell";
          shellHook = ''
            ln -fs ${pkgs.luarc-to-json luarc} .luarc.json
            export NVIM_APPNAME="rocks-dots"
          '';
          buildInputs = with pkgs; [
            lua-language-server
            neovim-nightly
            (lua5_1.withPackages (ps: with ps; [luarocks]))
          ];
        };
      };
    };
}
