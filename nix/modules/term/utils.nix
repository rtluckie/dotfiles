{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.dev;
in {
  options = {
    modules.term.dev = {
      enable =
        mkEnableOption "term.dev"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        xclip
      ];
    }
  ]);
}
