{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.jq;
in {
  options = {
    modules.development.tools.jq = {
      enable =
        mkEnableOption "development.tools.jq"
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
