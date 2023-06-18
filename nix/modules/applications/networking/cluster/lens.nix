{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.cluster.lens;
in {
  options = {
    modules.applications.networking.cluster.lens = {
      enable =
        mkEnableOption "applications.networking.cluster.lens"
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
