{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.qbittorrent;
in {
  options = {
    modules.gui.qbittorrent = {
      enable =
        mkEnableOption "gui.qbittorrent"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "qbittorrent"
      ];
    }
  ]);
}
