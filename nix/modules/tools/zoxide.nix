{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.zoxide;
in {
  options = {
    modules.tools.zoxide = {
      enable =
        mkEnableOption "tools.zoxide"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "zoxide"
      ];
    }
  ]);
}
