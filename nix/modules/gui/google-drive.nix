{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.google-drive;
in {
  options = {
    modules.gui.google-drive = {
      enable =
        mkEnableOption "gui.google-drive"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "google-drive"
      ];
    }
  ]);
}
