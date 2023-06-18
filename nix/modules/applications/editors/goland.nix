{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.editors.goland;
in {
  options = {
    modules.applications.editors.goland = {
      enable =
        mkEnableOption "applications.editors.goland"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        jetbrains.goland
      ];
    }
  ]);
}
