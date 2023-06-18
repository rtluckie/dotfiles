{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.libraries;
in {
  options = {
    modules.development.libraries = {
      enable =
        mkEnableOption "development.libraries"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        zlib
      ];
    }
  ]);
}
