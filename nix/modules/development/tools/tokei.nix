{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.tokei;
in {
  options = {
    modules.development.tools.tokei = {
      enable =
        mkEnableOption "development.tools.tokei"
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
      homebrew = {
        brews = [];
        casks = [];
        taps = [];
      };
    }
  ]);
}
