{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.iterm2;
in {
  options = {
    modules.tools.iterm2 = {
      enable =
        mkEnableOption "tools.iterm2"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      homebrew = {
        brews = [];
        casks = [
          "iterm2"
        ];
        taps = [];
      };
    }
  ]);
}
