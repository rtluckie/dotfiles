{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.discord;
in {
  options = {
    modules.gui.discord = {
      enable =
        mkEnableOption "gui.discord"
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
