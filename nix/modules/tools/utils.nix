{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.utils;
in {
  options = {
    modules.tools.utils = {
      enable =
        mkEnableOption "tools.utils"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        lsof
        htop
        tree
      ];
    }
  ]);
}