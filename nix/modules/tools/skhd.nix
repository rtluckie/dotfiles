{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.skhd;
in {
  options = {
    modules.tools.skhd = {
      enable = mkEnableOption "tools.skhd";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.skhd.enable = true;
      services.skhd.skhdConfig = builtins.readFile "${config.my.dotfiles.configDir}/skhd/config.conf";
    }
  ]);
}
