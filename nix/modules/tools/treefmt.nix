{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.treefmt;
in {
  options = {
    modules.tools.treefmt = {
      enable =
        mkEnableOption "tools.treefmt"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        treefmt
      ];
    }
  ]);
}
