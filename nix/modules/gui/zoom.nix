{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.zoom;
in {
  options = {
    modules.gui.zoom = {
      enable =
        mkEnableOption "gui.zoom"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "zoom"
      ];
    }
  ]);
}
