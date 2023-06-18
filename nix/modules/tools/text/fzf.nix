{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.text.fzf;
in {
  options = {
    modules.tools.text.fzf = {
      enable =
        mkEnableOption "tools.text.fzf"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.fzf = rec {
        enable = true;
        enableZshIntegration = true;
        defaultCommand = fileWidgetCommand + " --type f";
        defaultOptions = [
          "--border"
          "--prompt='» '"
          "--pointer='▶'"
          "--marker='✓ '"
          "--reverse"
          "--tabstop 2"
          "--multi "
          "--color=bg+:-1,marker:010"
          "--separator=''"
          "--bind '?:toggle-preview'"
        ];
        fileWidgetCommand = "${pkgs.fd}/bin/fd --hidden --follow --no-ignore-vcs";
        fileWidgetOptions = ["--preview '(COLORTERM=truecolor ${pkgs.bat}/bin/bat --style=changes --wrap never --color always {} || cat {} || (${pkgs.exa}/bin/exa --tree --group-directories-first {} || ${pkgs.tree}/bin/tree -C {})) 2> /dev/null' --preview-window down:60%"];
        changeDirWidgetCommand = fileWidgetCommand + " --type d .";
        changeDirWidgetOptions = ["--preview '(${pkgs.exa}/bin/exa --tree --group-directories-first {} || ${pkgs.tree}/bin/tree -C {}) 2> /dev/null'"];
        historyWidgetOptions = ["--preview 'echo {}' --preview-window down:3:wrap:hidden --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard'"];
        tmux.enableShellIntegration = true;
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "fzf"
      ];
    }
    {
      my.env.PATH = ["$HOMEBREW_PREFIX/bin" "$PATH"];
    }
    # {
    #   my.hm.user.programs.zsh.initExtra = ''
    #     if [ ! -n "$__FIX_IT" ]; then
    #       export __FIX_IT=1
    #       omz reload

    #     fi
    #   '';
    # }
  ]);
}
