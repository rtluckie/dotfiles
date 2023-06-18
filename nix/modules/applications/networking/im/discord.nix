{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.im.discord;
in {
  options = {
    modules.applications.networking.im.discord = {
      enable =
        mkEnableOption "applications.networking.im.discord"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        discord
      ];
    }
  ]);
}
