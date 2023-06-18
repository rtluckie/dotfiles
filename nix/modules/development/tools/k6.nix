{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.k6;
in {
  options = {
    modules.development.tools.k6 = {
      enable =
        mkEnableOption "development.tools.k6"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        k6
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
  ]);
}
