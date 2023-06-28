{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.direnv;
in {
  options = {
    modules.tools.misc.direnv = {
      enable =
        mkEnableOption "tools.misc.direnv"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.direnv ];
      my.hm.user.programs.direnv = {
        enable = true;
        nix-direnv = {enable = true;};
        # enableBashIntegration = true;
        # enableFishIntegration = true;
        # enableZshIntegration = true;
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "direnv"
      ];
    }
  ]);
}
