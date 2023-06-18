{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.media.ffmpeg;
in {
  options = {
    modules.tools.media.ffmpeg = {
      enable =
        mkEnableOption "tools.media.ffmpeg"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        ffmpeg
      ];
    }
  ]);
}
