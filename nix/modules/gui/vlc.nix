{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.vlc;
in {
  options = {
    modules.gui.vlc = {
      enable =
        mkEnableOption "gui.vlc"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "vlc"
      ];
    }
  ]);
}
