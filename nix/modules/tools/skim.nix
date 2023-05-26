{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.skim;
in {
  options = {
    modules.tools.skim = {
      enable =
        mkEnableOption "tools.skim"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.skim = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
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
  ]);
}
