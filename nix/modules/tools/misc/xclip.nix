{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.xclip;
in {
  options = {
    modules.tools.misc.xclip = {
      enable =
        mkEnableOption "tools.misc.xclip"
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
