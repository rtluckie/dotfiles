{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.cue;
in {
  options = {
    modules.development.tools.cue = {
      enable =
        mkEnableOption "development.tools.cue"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        cue
      ];
    }
  ]);
}
