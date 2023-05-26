{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.bat;
in {
  options = {
    modules.tools.bat = {
      enable =
        mkEnableOption "tools.bat"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.zsh ];
      my.hm.user.home.shellAliases = {
        cat = "bat";
      };
      my.hm.user.programs.bat = rec {
        enable = true;
        config.theme = "Dracula";
      };
    }
  ]);
}
