{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.navi;
in {
  options = {
    modules.applications.misc.navi = {
      enable =
        mkEnableOption "applications.misc.navi"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.navi = {
        enable = true;
        settings = {};
      };
    }
    {
      my.hm.user.programs.navi = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    }
  ]);
}
