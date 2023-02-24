{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.direnv;
in {
  options = {
    modules.tools.direnv = {
      enable =
        mkEnableOption "tools.direnv"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.direnv ];
      my.hm.user.programs.direnv = rec {
        enable = true;
        enableZshIntegration = false;
        nix-direnv = {enable = true;};
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "direnv"
      ];
    }
  ]);
}
