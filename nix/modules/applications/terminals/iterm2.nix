{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.terminals.iterm2;
in {
  options = {
    modules.applications.terminals.iterm2 = {
      enable =
        mkEnableOption "applications.terminals.iterm2"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        iterm2
      ];
    }
  ]);
}
