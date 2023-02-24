{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.jq;
in {
  options = {
    modules.tools.jq = {
      enable =
        mkEnableOption "tools.jq"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.jq = {
        enable = true;
      };
    }
  ]);
}
