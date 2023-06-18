{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.servers.MODULE;
in {
  options = {
    modules.servers.MODULE = {
      enable =
        mkEnableOption "servers.MODULE"
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
      homebrew = {
        brews = [];
        casks = [];
        taps = [];
      };
    }
  ]);
}
