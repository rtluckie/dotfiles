{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.yq;
in {
  options = {
    modules.development.tools.yq = {
      enable =
        mkEnableOption "development.tools.yq"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        yq-go
      ];
    }
  ]);
}
