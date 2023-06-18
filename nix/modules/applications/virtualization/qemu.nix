{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.virtualization.qemu;
in {
  options = {
    modules.applications.virtualization.qemu = {
      enable =
        mkEnableOption "applications.virtualization.qemu"
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
