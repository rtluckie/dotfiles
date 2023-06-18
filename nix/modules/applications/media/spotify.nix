{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.media.spotify;
in {
  options = {
    modules.applications.media.spotify = {
      enable =
        mkEnableOption "applications.media.spotify"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        spotify
      ];
    }
  ]);
}
