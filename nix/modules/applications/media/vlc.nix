{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.media.vlc;
in {
  options = {
    modules.applications.media.vlc = {
      enable =
        mkEnableOption "applications.media.vlc"
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
