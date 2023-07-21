{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.networking.cluster.knative;
in {
  options = {
    modules.networking.cluster.knative = {
      enable =
        mkEnableOption "networking.cluster.knative"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        knative
      ];
    }
  ]);
}
