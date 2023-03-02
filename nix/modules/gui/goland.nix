{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.goland;
in {
  options = {
    modules.gui.goland = {
      enable =
        mkEnableOption "gui.goland"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [jetbrains.goland];
    }
  ]);
}
