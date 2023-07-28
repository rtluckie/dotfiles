{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.admin.syft;
in {
  options = {
    modules.tools.admin.syft = {
      enable =
        mkEnableOption "tools.admin.syft"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        syft
      ];
    }
  ]);
}
