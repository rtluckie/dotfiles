{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.qemu;
in {
  options = {
    modules.tools.qemu = {
      enable =
        mkEnableOption "tools.qemu"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        utm
        qemu
      ];
    }
  ]);
}
