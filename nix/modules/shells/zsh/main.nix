{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shells.zsh;
in {
  options = {
    modules.shells.zsh = {
      enable =
        mkEnableOption "shells.zsh"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    # {

    #   my.user.shell =
    #     if pkgs.stdenv.isDarwin
    #     then [pkgs.zsh]
    #     else pkgs.zsh;
    # }
    {
      programs.zsh.enable = true;
      my.hm.user.programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        defaultKeymap = "viins";
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
        initExtra = "";
        initExtraBeforeCompInit = "";
        initExtraFirst = "";
        localVariables = {};
        loginExtra = "";
        logoutExtra = "";
        profileExtra = "";
        sessionVariables = {};
        shellAliases = {};
        shellGlobalAliases = {};
      };
    }
    # {
    #   my.hm.user.programs.zsh = with pkgs; {
    #     initExtra = ''
    #       source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    #     '';
    #   };
    # }
    # {
    #   my.hm.user.programs.zsh.initExtra = ''
    #     zstyle ':autocomplete:*' fzf-completion yes
    #   '';
    #   my.hm.user.programs.zsh.plugins = [
    #     {
    #       name = "zsh-autocomplete";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "marlonrichert";
    #         repo = "zsh-autocomplete";
    #         rev = "main";
    #         sha256 = "sha256-+w9+d7cYmPBdnqWgooh+OmscavB9JL7dVqOQyj8jJ7E=";
    #       };
    #     }
    #   ];
    # }
  ]);
}
