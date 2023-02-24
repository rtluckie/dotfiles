{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.rescuetime;
in {
  options = {
    modules.gui.rescuetime = {
      enable =
        mkEnableOption "gui.rescuetime"
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
