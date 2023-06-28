{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shells.fish;
in {
  options = {
    modules.shells.fish = {
      enable =
        mkEnableOption "shells.fish"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      programs.fish.enable = true;
      my.hm.user.programs.fish = {
        enable = true;
        functions = {};
        interactiveShellInit = "";
        loginShellInit = "";
        plugins = [];
        shellAbbrs = {};
        shellAliases = {};
        shellInit = "";
      };
    }
  ]);
}
