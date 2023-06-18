{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.networking.telepresence;
in {
  options = {
    modules.tools.networking.telepresence = {
      enable =
        mkEnableOption "tools.networking.telepresence"
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
