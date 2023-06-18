{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.editors.jetbrains-gateway;
in {
  options = {
    modules.applications.editors.jetbrains-gateway = {
      enable =
        mkEnableOption "applications.editors.jetbrains-gateway"
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
