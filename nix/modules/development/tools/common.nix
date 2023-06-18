{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.common;
in {
  options = {
    modules.development.tools.common = {
      enable =
        mkEnableOption "development.tools.common"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        lsof
      ];
    }
  ]);
}
