{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.text.sd;
in {
  options = {
    modules.tools.text.sd = {
      enable =
        mkEnableOption "tools.text.sd"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        sd
      ];
    }
  ]);
}
