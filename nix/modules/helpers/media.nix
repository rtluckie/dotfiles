{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.helpers.media;
in {
  options = {
    modules.helpers.media = {
      enable =
        mkEnableOption "helpers.media"
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
