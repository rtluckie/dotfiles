{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  # frameworks = nixpkgs.darwin.apple_sdk.frameworks;
  cfg = config.modules.development.compilers.rust;
in {
  options = {
    modules.development.compilers.rust = {
      enable =
        mkEnableOption "development.compilers.rust"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home = with config.my.hm; {
        sessionVariables = {
          RUSTUP_HOME = "${dataHome}/rust/rustup";
          CARGO_HOME = "${dataHome}/rust/cargo";
        };
      };
    }
    {
      my.hm.user.home = {
        packages = with pkgs; [
          # rustc
          # cargo
          # libgit2
          # just
          # darwin.apple_sdk.frameworks.Security
          # cargo
          # libz
          # rust-analyzer-unwrapped
          # rustc
          # darwin.libiconv
          # openssl
          # rustup
        ];
        sessionVariables.LIBRARY_PATH = ''${lib.makeLibraryPath [pkgs.libiconv]}''${LIBRARY_PATH:+:$LIBRARY_PATH}'';
      };
    }

    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "rust"
      ];
    }
  ]);
}
