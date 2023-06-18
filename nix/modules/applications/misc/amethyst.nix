{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.amethyst;
in {
  options = {
    modules.applications.misc.amethyst = {
      enable =
        mkEnableOption "applications.misc.amethyst"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "amethyst"
      ];
    }
  ]);
}
