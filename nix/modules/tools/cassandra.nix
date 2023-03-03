{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.cassandra;
in {
  options = {
    modules.tools.cassandra = {
      enable =
        mkEnableOption "tools.cassandra"
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
        cassandra
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "cassandra"
      ];
    }
  ]);
}
