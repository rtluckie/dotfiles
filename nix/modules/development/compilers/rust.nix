{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.compilers.rust;
in {
  options = {
    modules.development.compilers.rust = {
      enable =
        mkEnableOption "development.compilers.rust"
        // {
          default = true;
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
      my.hm.user.home.packages = with pkgs; [
        rust-bin.stable.latest.default
        rust-analyzer-unwrapped
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "rust"
      ];
    }
  ]);
}
