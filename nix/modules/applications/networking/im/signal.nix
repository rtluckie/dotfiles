{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.im.signal;
in {
  options = {
    modules.applications.networking.im.signal = {
      enable =
        mkEnableOption "applications.networking.im.signal"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "signal"
      ];
    }
  ]);
}
