{
  config,
  lib,
  pkgs,
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
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "pip"
        "pipenv"
        "poetry"
        "pyenv"
        "pylint"
        "python"
      ];
    }
  ]);
}
