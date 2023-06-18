{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.little-snitch;
in {
  options = {
    modules.applications.misc.little-snitch = {
      enable =
        mkEnableOption "applications.misc.little-snitch"
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
