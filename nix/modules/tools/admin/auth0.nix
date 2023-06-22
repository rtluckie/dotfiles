{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.admin.auth0;
in {
  options = {
    modules.tools.admin.auth0 = {
      enable =
        mkEnableOption "tools.admin.auth0"
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
        auth0-cli
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
  ]);
}
