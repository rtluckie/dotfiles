{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.text;
in {
  options = {
    modules.tools.text = {
      enable =
        mkEnableOption "tools.text"
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
        graphviz
        less
        pandoc
        plantuml
        yq-go
      ];
    }
  ]);
}
