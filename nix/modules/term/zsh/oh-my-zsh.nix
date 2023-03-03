{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib; (mkMerge [
    {
      my.hm.user.programs.zsh.oh-my-zsh = {
        custom = "$HOME/.config/zsh/oh-my-zsh/custom";
        plugins = [
          # 1password"
          # "adb"
          # "ag"
          "alias-finder"
          "aliases"
          # "ansible"
          # "ant"
          # "apache2-macports"
          # "arcanist"
          # "archlinux"
          # "asdf" # in module
          # "autoenv"
          # "autojump"
          # "autopep8"
          # "aws"
          # "azure"
          # "battery"
          # "bazel"
          # "bbedit"
          # "bedtools"
          # "bgnotify"
          # "bower"
          # "branch"
          # "brew" # in module
          # "bridgetown"
          # "bundler"
          # "cabal"
          # "cake"
          # "cakephp3"
          # "capistrano"
          # "cask"
          # "catimg"
          # "celery"
          # "charm"
          # "chruby"
          # "chucknorris"
          # "cloudfoundry"
          # "codeclimate"
          # "coffee"
          # "colemak"
          # "colored-man-pages"
          # "colorize"
          "command-not-found"
          # "common-aliases"
          # "compleat"
          # "composer"
          "copybuffer"
          "copyfile"
          "copypath"
          "cp"
          # "cpanm"
          # "dash"
          # "debian"
          # "deno"
          # "dircycle"
          # "direnv" # in module
          "dirhistory"
          # "dirpersist"
          # "dnf"
          # "dnote"
          # "docker"
          # "docker-compose"
          # "docker-machine"
          # "doctl"
          # "dotenv"
          # "dotnet"
          # "droplr"
          # "drush"
          # "eecms"
          # "emacs" # in module
          # "ember-cli"
          # "emoji"
          # "emoji-clock"
          # "emotty"
          # "encode64"
          # "extract" # in module/compression
          # "fabric"
          # "fancy-ctrl-z"
          # "fasd"
          # "fastfile"
          # "fbterm"
          # "fd"
          # "fig"
          # "firewalld"
          # "flutter"
          # "fluxcd"
          # "fnm"
          # "forklift"
          # "fossil"
          # "frontend-search"
          # "fzf"
          # "gas"
          # "gatsby"
          # "gcloud"
          # "geeknote"
          # "gem"
          # "genpass"
          # "gh"
          # "git"
          # "git-auto-fetch"
          # "git-escape-magic"
          # "git-extras"
          # "git-flow"
          # "git-flow-avh"
          # "git-hubflow"
          # "git-lfs"
          # "git-prompt"
          # "gitfast"
          # "github"
          # "gitignore"
          # "glassfish"
          # "globalias"
          # "gnu-utils"
          # "golang"
          # "gpg-agent"
          # "gradle"
          # "grails"
          # "grc"
          # "grunt"
          # "gulp"
          # "hanami"
          # "hasura"
          # "helm"
          # "heroku"
          # "heroku-alias"
          "history"
          "history-substring-search"
          # "hitchhiker"
          # "hitokoto"
          # "homestead"
          # "httpie"
          # "invoke"
          # "ionic"
          # "ipfs"
          # "isodate"
          # "istioctl"
          # "iterm2"
          # "jake-node"
          # "jenv"
          # "jfrog"
          # "jhbuild"
          # "jira"
          # "jruby"
          # "jsontools"
          # "juju"
          # "jump"
          # "kate"
          # "keychain"
          # "kitchen"
          # "kn"
          # "knife"
          # "knife_ssh"
          # "kops"
          # "kube-ps1"
          # "kubectl"
          # "kubectx"
          # "lando"
          # "laravel"
          # "laravel4"
          # "laravel5"
          # "last-working-dir"
          # "lein"
          # "lighthouse"
          # "lol"
          # "lpass"
          # "lxd"
          # "macos"
          # "macports"
          # "magic-enter"
          # "man"
          # "marked2"
          # "marktext"
          # "mercurial"
          # "meteor"
          # "microk8s"
          # "minikube"
          # "mix"
          # "mix-fast"
          # "mongo-atlas"
          # "mongocli"
          # "mosh"
          # "multipass"
          # "mvn"
          # "mysql-macports"
          # "n98-magerun"
          # "nanoc"
          # "nats"
          # "ng"
          # "nmap"
          # "node"
          # "nodenv"
          # "nomad"
          # "npm"
          # "nvm"
          # "oc"
          # "octozen"
          # "operator-sdk"
          # "otp"
          # "pass"
          # "paver"
          # "pep8"
          # "per-directory-history"
          # "percol"
          # "perl"
          # "perms"
          # "phing"
          # "pip"
          # "pipenv"
          # "pj"
          # "please"
          # "pm2"
          # "pod"
          # "poetry"
          # "postgres"
          # "pow"
          # "powder"
          # "powify"
          # "pre-commit"
          # "profiles"
          # "pyenv"
          # "pylint"
          # "python"
          # "qrcode"
          # "rails"
          # "rake"
          # "rake-fast"
          # "rand-quote"
          # "rbenv"
          # "rbfu"
          # "rbw"
          # "react-native"
          # "rebar"
          # "redis-cli"
          # "repo"
          # "ripgrep"
          # "ros"
          # "rsync"
          # "ruby"
          # "rust"
          # "rvm"
          # "safe-paste"
          # "salt"
          # "samtools"
          # "sbt"
          # "scala"
          # "scd"
          # "screen"
          # "scw"
          # "sdk"
          # "sfdx"
          # "sfffe"
          # "shell-proxy"
          # "shrink-path"
          # "sigstore"
          # "singlechar"
          # "skaffold"
          # "spring"
          # "sprunge"
          # "ssh-agent"
          # "stack"
          # "sublime"
          # "sublime-merge"
          # "sudo"
          # "supervisor"
          # "suse"
          # "svcat"
          # "svn"
          # "svn-fast-info"
          # "swiftpm"
          # "symfony"
          # "symfony2"
          # "systemadmin"
          # "systemd"
          # "taskwarrior"
          # "term_tab"
          # "terminitor"
          # "terraform" # in module
          # "textastic"
          # "textmate"
          "thefuck"
          # "themes"
          # "thor"
          # "tig"
          # "timer"
          # "tmux" # in module
          # "tmux-cssh"
          # "tmuxinator"
          # "toolbox"
          # "torrent"
          "transfer"
          # "tugboat"
          # "ubuntu"
          # "ufw"
          # "universalarchive"
          "urltools"
          # "vagrant"
          # "vagrant-prompt"
          # "vault"
          # "vi-mode"
          # "vim-interaction"
          # "virtualenv"
          # "virtualenvwrapper"
          # "volta"
          # "vscode"
          # "vundle"
          # "wakeonlan"
          # "watson"
          # "wd"
          # "web-search"
          # "wp-cli"
          # "xcode"
          # "yarn" # in module node.nix
          # "yii"
          # "yii2"
          # "yum"
          # "z"
          # "zbell"
          # "zeus"
          # "zoxide" # in module
          # "zsh-interactive-cd"
          # "zsh-navigation-tools"
        ];
      };
    }
  ]);
}
