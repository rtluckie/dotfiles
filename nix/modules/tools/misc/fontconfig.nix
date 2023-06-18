{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.fontconfig;
in {
  options = {
    modules.tools.misc.fontconfig = {
      enable =
        mkEnableOption "tools.misc.fontconfig"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        fontconfig
      ];
    }
  ]);
}
