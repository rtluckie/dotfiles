{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.zellij;
in {
  options = {
    modules.tools.misc.zellij = {
      enable =
        mkEnableOption "tools.misc.zellij"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.zellij = {
        enable = true;
        settings = {};
      };
    }
    {
      my.hm.user.programs.zellij = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    }
  ]);
}
