{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.raycast;
in {
  options = {
    modules.applications.misc.raycast = {
      enable =
        mkEnableOption "applications.misc.raycast"
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
