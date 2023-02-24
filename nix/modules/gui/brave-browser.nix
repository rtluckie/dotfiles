{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.brave-browser;
in {
  options = {
    modules.gui.brave-browser = {
      enable =
        mkEnableOption "gui.brave-browser"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "brave-browser"
      ];
    }
  ]);
}
