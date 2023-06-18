{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.rectangle;
in {
  options = {
    modules.applications.misc.rectangle = {
      enable =
        mkEnableOption "applications.misc.rectangle"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "rectangle"
      ];
    }
  ]);
}
