{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.jetbrains-gateway;
in {
  options = {
    modules.gui.jetbrains-gateway = {
      enable =
        mkEnableOption "gui.jetbrains-gateway"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        jetbrains.gateway
      ];
    }
  ]);
}
