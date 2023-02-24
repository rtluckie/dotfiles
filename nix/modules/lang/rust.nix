{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.lang.rust;
in {
  options = {
    modules.lang.rust = {
      enable =
        mkEnableOption "lang.rust"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.env = {
        RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
        CARGO_HOME = "$XDG_DATA_HOME/cargo";
      };
    }
    {
      my.user.packages = with pkgs; [
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
