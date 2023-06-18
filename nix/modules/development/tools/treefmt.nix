{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.treefmt;
in {
  options = {
    modules.development.tools.treefmt = {
      enable =
        mkEnableOption "development.tools.treefmt"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        treefmt
      ];
    }
  ]);
}
