{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.exa;
in {
  options = {
    modules.tools.misc.exa = {
      enable =
        mkEnableOption "tools.misc.exa"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.exa = {
        enable = true;
        enableAliases = true;
        git = true;
        icons = true;
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };
    }
  ]);
}
