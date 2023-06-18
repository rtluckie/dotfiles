{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.servers.postgres;
in {
  options = {
    modules.servers.postgres = {
      enable =
        mkEnableOption "servers.postgres"
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
        postgresql
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "postgres"
      ];
    }
  ]);
}
