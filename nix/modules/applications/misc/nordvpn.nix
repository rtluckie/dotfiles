{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.nordvpn;
in {
  options = {
    modules.applications.misc.nordvpn = {
      enable =
        mkEnableOption "applications.misc.nordvpn"
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
