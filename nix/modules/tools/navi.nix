{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.navi;
in {
  options = {
    modules.tools.navi = {
      enable =
        mkEnableOption "tools.navi"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.navi = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        settings = {};
      };
    }
  ]);
}
