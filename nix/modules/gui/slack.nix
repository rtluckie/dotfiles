{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.slack;
in {
  options = {
    modules.gui.slack = {
      enable =
        mkEnableOption "gui.slack"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "slack"
      ];
    }
  ]);
}
