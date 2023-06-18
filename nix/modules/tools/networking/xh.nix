{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.networking.xh;
in {
  options = {
    modules.tools.networking.xh = {
      enable =
        mkEnableOption "tools.networking.xh"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        xh
      ];
    }
  ]);
}
