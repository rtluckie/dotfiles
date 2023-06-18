{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.istat-menus;
in {
  options = {
    modules.applications.misc.istat-menus = {
      enable =
        mkEnableOption "applications.misc.istat-menus"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "istat-menus"
      ];
    }
  ]);
}
