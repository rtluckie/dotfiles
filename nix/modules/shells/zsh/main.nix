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
      enable = mkEnableOption "shells.zsh" // {default = true;};
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      environment = {
        # must already begin with pre-existing PATH. Also, can't use binDir here,
        # because it contains a nix store path.
        extraInit =
          concatStringsSep "\n"
          (mapAttrsToList (n: v: ''export ${n}="${v}"'') config.my.env);
        variables = {
          DOTFILES = "${config.my.dotfiles.dir}";
          DOTFILES_BIN = "${config.my.dotfiles.binDir}";
        };
        # sessionVariables = {XDG_BIN_HOME = "$HOME/.local/bin";};
        # localBinInPath = true;
        # homeBinInPath = true;
        shellAliases = {};
        interactiveShellInit = "";
        loginShellInit = "";
        shellInit = "";
      };
    }
    {
      my.hm.user = {
        home = {
          sessionVariables = {
            EDITOR = "eframe";
            VISUAL = "$EDITOR";
            PAGER = "less";
          };
        };
      };
    }
    {
      environment = {
        shells = [pkgs.zsh];
        systemPackages = with pkgs; [
          file
          git
          rsync
          vim
          zsh
        ];
        pathsToLink = ["/share/zsh"];
      };
      # localBinInPath = true;
      # homeBinInPath = true;
      # shellAliases = {};
      # interactiveShellInit = "";
      # loginShellInit = "";
      # shellInit = "";
    }
    {
      programs.zsh.enable = true;
    }
    {
      my.user.shell = pkgs.zsh;

      # my.user.shell =
      #   if pkgs.stdenv.isDarwin
      #   then [pkgs.zsh]
      #   else pkgs.zsh;
    }
    {
      my.hm.user.programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
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
