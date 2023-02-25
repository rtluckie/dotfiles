{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.xh;
in {
  options = {
    modules.tools.xh = {
      enable =
        mkEnableOption "tools.xh"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        xh
      ];
    }
  ]);
}