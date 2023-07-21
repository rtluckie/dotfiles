{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.security.sops;
in {
  options = {
    modules.tools.security.sops = {
      enable =
        mkEnableOption "tools.security.sops"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        sops
      ];
    }
  ]);
}
