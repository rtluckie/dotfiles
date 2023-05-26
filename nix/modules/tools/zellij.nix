{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.zellij;
in {
  options = {
    modules.tools.zellij = {
      enable =
        mkEnableOption "tools.zellij"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.zellij = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        settings = {};
      };
    }
  ]);
}
