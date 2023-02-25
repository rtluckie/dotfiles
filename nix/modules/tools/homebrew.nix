{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.homebrew;
in {
  options = {
    modules.tools.homebrew = {
      enable =
        mkEnableOption "tools.homebrew"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew = {
        enable = true;
        onActivation.autoUpdate = false;
        onActivation.cleanup = "zap";
        global.autoUpdate = false;
        global.brewfile = true;
        global.lockfiles = true;
        taps = [
          "homebrew/core"
          "homebrew/cask"
          "homebrew/services"
          "homebrew/cask-versions"
        ];
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "brew"
      ];
    }
  ]);
}