{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.dive;
in {
  options = {
    modules.development.tools.dive = {
      enable =
        mkEnableOption "development.tools.dive"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        dive
      ];
    }
  ]);
}
