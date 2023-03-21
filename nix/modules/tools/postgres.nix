{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.postgres;
in {
  options = {
    modules.tools.postgres = {
      enable =
        mkEnableOption "tools.postgres"
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
