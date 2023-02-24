{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc;
in {
  options = {
    modules.tools.misc = {
      enable =
        mkEnableOption "tools.misc"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        ffmpeg
        fontconfig
        graphviz
        plantuml
      ];
    }
  ]);
}
