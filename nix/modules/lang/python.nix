{
  lib,
  pkgs,
  options,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.lang.python;
in {
  options = {
    modules.lang.python = {
      enable =
        mkEnableOption "lang.python"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home = rec {
        sessionPath = [
          "$PYENV_ROOT/bin"
        ];
        sessionVariables = {
          PYENV_ROOT = "$HOME/.local/share/pyenv";
        };
      };
      my.hm.user.programs.zsh.profileExtra = ''
        export PYENV_ROOT="$HOME/.local/share/pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)"
      '';
    }
    {
      my.user.packages = with pkgs; [
        (python3.withPackages (ps:
          with ps; [
            black
            ipython
            isort
            nose
            pip
            pyflakes
            pylint
            pyright
            pytest
            python-lsp-server
            setuptools
            virtualenv
            virtualenvwrapper
          ]))
        poetry
        pipenv
        thefuck
      ];
    }
    {
      my.hm.user.home.activation.pyenv = with pkgs;
        inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
          export PATH=${pkgs.lib.makeBinPath [curl git]}:$PATH
          export PYENV_ROOT="$HOME/.local/share/pyenv"
          echo $PYENV_ROOT
          if [[ ! -d $PYENV_ROOT ]]; then
            echo "Pyenv not installed. Install now..."
            curl --silent https://pyenv.run | bash
          else
            echo "Pyenv already installed"
          fi
        '';
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "pip"
        "pipenv"
        "poetry"
        "pyenv"
        "pylint"
        "python"
        "pyenv"
      ];
    }
  ]);
}
