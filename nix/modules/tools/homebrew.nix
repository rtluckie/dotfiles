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
        onActivation.autoUpdate = true;
        onActivation.cleanup = "zap";
        onActivation.upgrade = true;
        global.autoUpdate = true;
        global.brewfile = true;
        global.lockfiles = true;
        taps = [
          "homebrew/cask-versions"
          "homebrew/cask"
          "homebrew/core"
          "homebrew/services"
        ];
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "brew"
      ];
    }
    {
      my.hm.user.home = {
        sessionPath = [
          "/opt/homebrew/bin"
          "/opt/homebrew/sbin"
        ];
        sessionVariables = {
        };
      };
    }
  ]);
}
