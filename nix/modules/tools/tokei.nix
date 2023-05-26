{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.tokei;
in {
  options = {
    modules.tools.tokei = {
      enable =
        mkEnableOption "tools.tokei"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.shellAliases = {
      };
    }
    {
      my.hm.user.home.packages = with pkgs; [
        tokei
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
