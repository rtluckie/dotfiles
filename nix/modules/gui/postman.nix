{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.postman;
in {
  options = {
    modules.gui.postman = {
      enable =
        mkEnableOption "gui.postman"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [pkgs.postman];
    }
  ]);
}
