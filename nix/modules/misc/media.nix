{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.misc.media;
in {
  options = {
    modules.misc.media = {
      enable =
        mkEnableOption "misc.media"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.configFile = {
        "media" = {
          source = "${config.my.dotfiles.configDir}/media";
          recursive = true;
        };
      };
    }
  ]);
}
