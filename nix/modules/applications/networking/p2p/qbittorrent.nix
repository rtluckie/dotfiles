{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.p2p.qbittorrent;
in {
  options = {
    modules.applications.networking.p2p.qbittorrent = {
      enable =
        mkEnableOption "applications.networking.p2p.qbittorrent"
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
