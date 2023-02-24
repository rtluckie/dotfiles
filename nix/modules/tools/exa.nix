{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.exa;
in {
  options = {
    modules.tools.exa = {
      enable =
        mkEnableOption "tools.exa"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.exa = {
        enable = true;
        enableAliases = true;
      };
    }
  ]);
}
