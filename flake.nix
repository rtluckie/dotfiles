{
  description = "rluckie's dotfiles";

  inputs = {
    nixpkgs = {url = "github:nixos/nixpkgs/nixpkgs-unstable";};
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # cemacs = {
    #   url = "github:cmacrae/emacs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-utils.follows = "flake-utils";
    # };
    flake-utils = {url = "github:numtide/flake-utils";};
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ {
    self,
    # cemacs,
    darwin,
    # devenv,
    # devshell,
    # emacs-overlay,
    # flake-utils,
    home-manager,
    nixpkgs,
    # nur,
    rust-overlay,
    ...
  }: let
    # inherit (flake-utils.lib) eachDefaultSystem eachSystem;
    inherit (darwin.lib) darwinSystem;
    inherit
      (inputs.nixpkgs.lib)
      attrValues
      makeOverridable
      optionalAttrs
      singleton
      ;
    overlays = [
      # emacs-overlay.overlay
      # cemacs.overlay
      rust-overlay.overlays.default
      (final: prev: {devenv = inputs.devenv.defaultPackage.${prev.system};})
      (import ./nix/overlays)
    ];

    mkDarwinSystem = {modules}:
      makeOverridable darwin.lib.darwinSystem {
        inputs = inputs;
        system = "x86_64-darwin";
        modules =
          [
            home-manager.darwinModules.home-manager
            {nixpkgs.overlays = overlays;}
            ./nix/modules/systems/common
            ./nix/modules/systems/darwin
            ({lib, ...}: {
              imports = import ./nix/modules/modules.nix {
                inherit lib;
                isDarwin = true;
              };
            })
          ]
          ++ modules;
      };
  in {
    darwinConfigurations = {
      example = mkDarwinSystem {modules = [./nix/hosts/example];};
      gull = (mkDarwinSystem {modules = [./nix/hosts/gull];}).override {
        system = "aarch64-darwin";
      };
    };
    example = self.darwinConfigurations.example.system;
    gull = self.darwinConfigurations.gull.system;
  };
}
