{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.fig;
in {
  options = {
    modules.applications.misc.fig = {
      enable =
        mkEnableOption "applications.misc.fig"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "fig"
      ];
    }
  ]);
}
