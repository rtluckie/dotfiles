{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.rectangle;
in {
  options = {
    modules.gui.rectangle = {
      enable =
        mkEnableOption "gui.rectangle"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "rectangle"
      ];
    }
  ]);
}
