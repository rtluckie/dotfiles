{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.signal;
in {
  options = {
    modules.gui.signal = {
      enable =
        mkEnableOption "gui.signal"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "signal"
      ];
    }
  ]);
}
