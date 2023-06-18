{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.networking.wireguard;
in {
  options = {
    modules.tools.networking.wireguard = {
      enable =
        mkEnableOption "tools.networking.wireguard"
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
