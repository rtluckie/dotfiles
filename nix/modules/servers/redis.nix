{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.servers.redis;
in {
  options = {
    modules.servers.redis = {
      enable =
        mkEnableOption "servers.redis"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
        redis
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "redis-cli"
      ];
    }
  ]);
}
