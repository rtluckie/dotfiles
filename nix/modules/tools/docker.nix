{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.docker;
in {
  options = {
    modules.tools.docker = {
      enable =
        mkEnableOption "tools.docker"
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
