{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.nordvpn;
in {
  options = {
    modules.gui.nordvpn = {
      enable =
        mkEnableOption "gui.nordvpn"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "nordvpn"
      ];
    }
  ]);
}
