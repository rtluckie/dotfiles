{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui._1password;
in {
  options = {
    modules.gui._1password = {
      enable =
        mkEnableOption "gui.1password"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "1password"
        "1password-cli"
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "1password"
      ];
    }
  ]);
}
