{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.google-drive;
in {
  options = {
    modules.applications.misc.google-drive = {
      enable =
        mkEnableOption "applications.misc.google-drive"
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
