{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.istat-menus;
in {
  options = {
    modules.gui.istat-menus = {
      enable =
        mkEnableOption "gui.istat-menus"
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
