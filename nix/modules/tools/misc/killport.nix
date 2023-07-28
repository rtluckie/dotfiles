{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.killport;
in {
  options = {
    modules.tools.misc.killport = {
      enable =
        mkEnableOption "tools.misc.killport"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        killport
      ];
    }
    {
      environment.systemPackages = with pkgs; [
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
  ]);
}
