{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.editors.idea;
in {
  options = {
    modules.applications.editors.idea = {
      enable =
        mkEnableOption "applications.editors.idea"
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
