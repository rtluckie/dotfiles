{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.zsh;
in {
  options = {
    modules.term.zsh = {
      enable =
        mkEnableOption "term.zsh"
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
            EDITOR = "emacsclient --alternate-editor=\"\" --create-frame";
            VISUAL = "$EDITOR";
            PAGER = "less";
          };
        };
      };
    }
    {
      environment.shells = [pkgs.zsh];
      environment.systemPackages = [pkgs.zsh];
      programs.zsh.enable = true;
    }
    {
      my.user.shell = pkgs.zsh;
    }
    {
      my.hm.user.programs.zsh = {
        enable = true;
        enableCompletion = false;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        autocd = true;
        defaultKeymap = "emacs";
        dotDir = ".config/zsh";
        history = {
          ignoreDups = true;
          ignoreSpace = true;
          extended = true;
          ignorePatterns = ["kill *"];
          path = "${config.my.hm.dataHome}/zsh/history";
          save = 500000;
          share = true;
          size = 500000;
        };
        oh-my-zsh.enable = true;
      };
    }
    {
      my.hm.user.programs.zsh.plugins = [
        {
          name = "zsh-autocomplete";
          src = pkgs.fetchFromGitHub {
            owner = "marlonrichert";
            repo = "zsh-autocomplete";
            rev = "main";
            sha256 = "sha256-+w9+d7cYmPBdnqWgooh+OmscavB9JL7dVqOQyj8jJ7E=";
          };
        }
      ];
    }
  ]);
}
