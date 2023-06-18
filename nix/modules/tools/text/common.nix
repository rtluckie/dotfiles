{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.text.common;
in {
  options = {
    modules.tools.text.common = {
      enable =
        mkEnableOption "tools.text.common"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        gawk
        gnugrep
        gnused
        less
        pandoc
      ];
    }
  ]);
}
