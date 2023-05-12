{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.fig;
in {
  options = {
    modules.gui.fig = {
      enable =
        mkEnableOption "gui.fig"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "fig"
      ];
    }
  ]);
}
