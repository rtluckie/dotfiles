{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.pueue;
in {
  options = {
    modules.tools.misc.pueue = {
      enable =
        mkEnableOption "tools.misc.pueue"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        pueue
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
