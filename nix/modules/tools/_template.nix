{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.GROUP.MODULE;
in {
  options = {
    modules.GROUP.MODULE = {
      enable =
        mkEnableOption "GROUP.MODULE"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.MODULE = {
        enable = true;
      };
    }
    {
      my.hm.user.home.shellAliases = {
        CHANGEME = "MODULE";
      };
    }
    {
      my.hm.user.home.packages = with pkgs; [
        xh
      ];
    }
    {
      my.hb = {
        brews = [];
        casks = [];
        taps = [];
      };
    }
  ]);
}
