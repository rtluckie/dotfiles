{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.redis;
in {
  options = {
    modules.tools.redis = {
      enable =
        mkEnableOption "tools.redis"
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
      my.user.packages = with pkgs; [
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
