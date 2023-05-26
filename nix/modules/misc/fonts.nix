{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.misc.fonts;
in {
  options = {
    modules.misc.fonts = {
      enable =
        mkEnableOption "misc.fonts"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.taps = [
        # "homebrew/cask-fonts"
      ];
      homebrew.casks = [
        # "font-fira-code-nerd-font"
        # "font-fira-code-nerd-font"
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
      ];
    }
  ]);
}
