{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.browsers.brave;
in {
  options = {
    modules.applications.networking.browsers.brave = {
      enable =
        mkEnableOption "applications.networking.browsers.brave"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "brave-browser"
      ];
    }
  ]);
}
