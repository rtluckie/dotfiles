{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.little-snitch;
in {
  options = {
    modules.gui.little-snitch = {
      enable =
        mkEnableOption "gui.little-snitch"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "little-snitch"
      ];
    }
  ]);
}
