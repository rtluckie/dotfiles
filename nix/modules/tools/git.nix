{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.git;
in {
  options = {
    modules.tools.git = {
      enable =
        mkEnableOption "tools.git"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        gitAndTools.delta
        gitAndTools.hub
        gitAndTools.gh
        gitAndTools.tig
        gitAndTools.lazygit
        gitAndTools.gitui
        exiftool
      ];
    }
    {
      my.hm.user.programs.git = rec {
        enable = true;
        userName = config.my.name;
        aliases = {
          co = "checkout";
          w = "status -sb";
          l = "log --graph --pretty=format:'%Cred%h%Creset —%Cblue%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative --show-notes=*";

          subup = "submodule update --init";
          superpush = "push --force --tags origin refs/heads/*";
          tree = "log --pretty=oneline --decorate --graph";
        };
        userEmail = config.my.email;
        difftastic = {enable = false;};
        delta.enable = true;
        delta.options = {
          side-by-side = true;
          line-numbers = true;
          navigate = true;
        };
        includes = [
          {
            condition = "gitdir:~/projects/github.com/ec.ai/";
            contents = {
              user = {
                email = "rluckie@ec.ai";
              };
            };
          }
        ];
        signing = {
          key = config.my.gpgKey;
          signByDefault = true;
        };
        extraConfig = {
          advice = {
            addEmptyPathspec = false;
            pushNonFastForward = false;
          };
          branch.autosetupmerge = true;
          checkout = {
            defaultRemote = "origin";
          };
          commit = {
            template = "~/.config/git/message";
          };
          url."git@github.com:".insteadOf = "https://github.com";
          core = {
            editor = "$EDITOR";
            autocrlf = false;
            excludesfile = "~/.config/git/ignore";
          };
          diff = {
            algorithm = "histogram";
            colorMoved = "zebra";
            ignoreSubmodules = "dirty";
            mnemonicprefix = true;
            renamelimit = 8192;
            renames = "copies";
          };
          fetch = {
            prune = true;
          };

          github.user = config.my.githubUsername;
          init.defaultBranch = "main";
          log = {
            date = "local";
          };
          merge = {
            conflictstyle = "diff3";
            stat = true;
            ff = "only";
          };

          pull.rebase = true;
          push.default = "current";
          rebase = {
            autosquash = true;
            autostash = true;
          };
          remote.origin.prune = true;
        };
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "git"
        "gh"
      ];
    }
    {
      my.hm.configFile = {
        "git" = {
          source = "${config.my.dotfiles.configDir}/git";
          recursive = true;
        };
      };
    }
  ]);
}