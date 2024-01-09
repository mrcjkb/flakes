{
  description = "Basic nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs, ...}: let
    # systems = [
    #   "x86_64-linux"
    #   "x86_64-darwin"
    #   "aarch64-darwin"
    #   "aarch64-linux"
    # ];
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.hello;
  };
}
