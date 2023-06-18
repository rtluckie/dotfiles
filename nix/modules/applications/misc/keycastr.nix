{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.misc.keycastr;
in {
  options = {
    modules.applications.misc.keycastr = {
      enable =
        mkEnableOption "applications.misc.keycastr"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "keycastr"
      ];
    }
  ]);
}
