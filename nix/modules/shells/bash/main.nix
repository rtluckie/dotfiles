{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shells.bash;
in {
  options = {
    modules.shells.bash = {
      enable =
        mkEnableOption "shells.bash"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      programs.bash.enable = true;
      my.hm.user.programs.bash = rec {
        enable = true;
        enableCompletion = true;
        bashrcExtra = "";
        historyControl = [
          "erasedups"
          "ignoredups"
          "ignorespace"
        ];
        historyFile = "${config.my.hm.dataHome}/bash/history";
        historyFileSize = 500000;
        historyIgnore = [];
        initExtra = "";
        logoutExtra = "";
        profileExtra = "";
        sessionVariables = {};
        shellAliases = {};
        shellOptions = [
          "histappend"
          "checkwinsize"
          "extglob"
          "globstar"
          "checkjobs"
        ];
      };
    }
    {
      my.hm.user.home.packages = with pkgs; [
        bashInteractive
      ];
    }
  ]);
}
