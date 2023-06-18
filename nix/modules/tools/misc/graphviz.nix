{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.graphviz;
in {
  options = {
    modules.tools.misc.graphviz = {
      enable =
        mkEnableOption "tools.misc.graphviz"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        graphviz
      ];
    }
  ]);
}
