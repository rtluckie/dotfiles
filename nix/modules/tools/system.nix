{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.system;
in {
  options = {
    modules.tools.system = {
      enable =
        mkEnableOption "tools.system"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        htop
        tree
      ];
    }
  ]);
}
