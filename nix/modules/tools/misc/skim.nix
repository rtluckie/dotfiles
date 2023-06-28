{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.skim;
in {
  options = {
    modules.tools.misc.skim = {
      enable =
        mkEnableOption "tools.misc.skim"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.skim = {
        enable = true;
        changeDirWidgetCommand = "fd --type d";
        changeDirWidgetOptions = [
          "--preview 'tree -C {} | head -200'"
        ];
        defaultCommand = "fd --type f";
        defaultOptions = [
          "--height 40%"
          "--prompt ⟫"
        ];
        fileWidgetCommand = "fd --type f";
        fileWidgetOptions = [
          "--preview 'head {}'"
        ];

        historyWidgetOptions = [
          "--tac"
          "--exact"
        ];
      };
    }
    {
      my.hm.user.programs.skim = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    }
  ]);
}
