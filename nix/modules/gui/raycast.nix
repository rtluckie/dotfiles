{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.raycast;
in {
  options = {
    modules.gui.raycast = {
      enable =
        mkEnableOption "gui.raycast"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "raycast"
      ];
    }
  ]);
}
