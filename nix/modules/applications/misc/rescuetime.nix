{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.rescuetime;
in {
  options = {
    modules.applications.misc.rescuetime = {
      enable =
        mkEnableOption "applications.misc.rescuetime"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "rescuetime"
      ];
    }
  ]);
}
