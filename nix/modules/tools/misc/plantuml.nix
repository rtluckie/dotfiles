{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.plantuml;
in {
  options = {
    modules.tools.misc.plantuml = {
      enable =
        mkEnableOption "tools.misc.plantuml"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        plantuml
      ];
    }
  ]);
}
