{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.security.slsa-verifier;
in {
  options = {
    modules.tools.security.slsa-verifier = {
      enable =
        mkEnableOption "tools.security.slsa-verifier"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        slsa-verifier
      ];
    }
  ]);
}
