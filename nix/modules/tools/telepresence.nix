{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.telepresence;
in {
  options = {
    modules.tools.telepresence = {
      enable =
        mkEnableOption "tools.telepresence"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        telepresence2
      ];
    }
  ]);
}
