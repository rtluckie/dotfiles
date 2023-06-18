{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.virtualization.docker;
in {
  options = {
    modules.applications.virtualization.docker = {
      enable =
        mkEnableOption "applications.virtualization.docker"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        docker
        docker-compose
      ];
    }
  ]);
}
