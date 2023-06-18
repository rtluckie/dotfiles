{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.system.skhd;
in {
  options = {
    modules.applications.system.skhd = {
      enable =
        mkEnableOption "applications.system.skhd"
        // {
          default = false;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.skhd.enable = true;
      services.skhd.skhdConfig = builtins.readFile "${config.my.dotfiles.configDir}/skhd/config.conf";
    }
  ]);
}
