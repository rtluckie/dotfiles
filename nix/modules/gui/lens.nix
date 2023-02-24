{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.lens;
in {
  options = {
    modules.gui.lens = {
      enable =
        mkEnableOption "gui.lens"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "lens"
      ];
    }
  ]);
}
