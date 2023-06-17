{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.idea;
in {
  options = {
    modules.gui.idea = {
      enable =
        mkEnableOption "gui.idea"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        jetbrains.idea-ultimate
      ];
    }
  ]);
}
