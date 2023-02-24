{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.gui.wireguard;
in {
  options = {
    modules.gui.wireguard = {
      enable =
        mkEnableOption "gui.wireguard"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.masApps = {
        WireGuard = 1451685025;
      };
    }
  ]);
}
