{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.bash;
in {
  options = {
    modules.term.bash = {
      enable =
        mkEnableOption "term.bash"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user = {
        home = {
          sessionVariables = {
            EDITOR = "hx";
            VISUAL = "$EDITOR";
            PAGER = "less";
          };
        };
      };
    }
    {
      environment.shells = [pkgs.bashInteractive pkgs.bash];
      environment.systemPackages = [pkgs.bash];
      programs.bash.enable = true;
      programs.bash.enable = true;
    }
    {
      my.user.shell = pkgs.bash;
    }
    {
      my.hm.user.programs.bash = rec {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        autocd = true;
        defaultKeymap = "emacs";
        dotDir = ".config/bash";
        history = {
          ignoreDups = true;
          ignoreSpace = true;
          extended = true;
          ignorePatterns = ["kill *"];
          path = "${config.my.hm.dataHome}/bash/history";
          save = 500000;
          share = true;
          size = 500000;
        };
        oh-my-bash = {
          enable = true;
          plugins = [
            "command-not-found"
            "history"
            "history-substring-search"
          ];
          custom = "$HOME/.config/bash/custom";
        };
      };
    }
  ]);
}
