{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.amethyst;
in {
  options = {
    modules.gui.amethyst = {
      enable =
        mkEnableOption "gui.amethyst"
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
