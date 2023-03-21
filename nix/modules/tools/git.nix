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
      environment.systemPackages = with pkgs; [
        git
      ];
    }
    {
      my.hm.user.programs.zsh.profileExtra = ''
        export GIT_AUTO_FETCH_INTERVAL=1200
      '';
    }
    {
      my.hm.user.home.packages = with pkgs; [
        exiftool
        gitAndTools.delta
        gitAndTools.gh
        gitAndTools.gitui
        gitAndTools.hub
        gitAndTools.lazygit
        gitAndTools.tig
        meld
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
          {
            condition = "gitdir:~/projects/";
            contents = {
              url."git@bitbucket.org:".insteadOf = "https://bitbucket.org/";
              url."git@github.com:".insteadOf = "https://github.com/";
              url."git@gitlab.com:".insteadOf = "https://gitlab.com/";
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
        "gh"
        "git"
        "git-auto-fetch"
        "git-escape-magic"
        "git-extras"
        "gitfast"
        "github"
        "gitignore"
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
