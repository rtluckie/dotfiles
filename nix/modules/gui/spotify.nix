{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.spotify;
in {
  options = {
    modules.gui.spotify = {
      enable =
        mkEnableOption "gui.spotify"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "spotify"
      ];
    }
  ]);
}
