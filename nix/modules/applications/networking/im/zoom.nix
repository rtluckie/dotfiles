{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.im.zoom;
in {
  options = {
    modules.applications.networking.im.zoom = {
      enable =
        mkEnableOption "applications.networking.im.zoom"
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
