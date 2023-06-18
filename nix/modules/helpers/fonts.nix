{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.helpers.fonts;
in {
  options = {
    modules.helpers.fonts = {
      enable =
        mkEnableOption "helpers.fonts"
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
