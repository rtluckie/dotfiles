{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.keycastr;
in {
  options = {
    modules.gui.keycastr = {
      enable =
        mkEnableOption "gui.keycastr"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "keycastr"
      ];
    }
  ]);
}
