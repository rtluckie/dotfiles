{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.tmux;
in {
  options = {
    modules.term.tmux = {
      enable =
        mkEnableOption "term.tmux"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.env = {
        ZSH_TMUX_AUTOSTART = "1";
        ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
      };
    }
    {
      my.hm.user.programs.tmux = rec {
        enable = true;
        aggressiveResize = true;
        baseIndex = 1;
        clock24 = true;
        customPaneNavigationAndResize = true;
        escapeTime = 0;
        historyLimit = 50000;
        keyMode = "vi";
        prefix = "C-a";
        terminal = "screen-256color";
        sensibleOnTop = true;
        shell = "${pkgs.zsh}/bin/zsh";
        tmuxinator.enable = true;
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.resurrect;
          }
          {
            plugin = tmuxPlugins.pain-control;
          }
          {
            plugin = tmuxPlugins.yank;
          }
          {
            plugin = tmuxPlugins.continuum;
          }
          {
            plugin = tmuxPlugins.dracula;
            extraConfig = ''
              set -g @resurrect-strategy-nvim 'session'
              set -g @dracula-show-location false
              set -g @dracula-plugins "battery network"
            '';
          }
          # {
          #   plugin = tmuxPlugins.tmux-thumbs;
          #   extraConfig = ''
          #     set -g @thumbs-command 'echo -n {} | pbcopy'
          #   '';
          # }
        ];

        extraConfig = ''
          set -g mouse on
          bind-key R source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display-message "$XDG_CONFIG_HOME/tmux/tmux.conf reloaded"
          set-option -g set-clipboard on
          # set-option -g default-command "reattach-to-user-namespace -l zsh"

          # bind J display-popup -E "\
          # tmux list-panes -a -F '#{?session_attached,,#S:#I.#P}' |\
          # sed '/^$/d' |\
          # fzf --reverse --header join-pane --preview 'tmux capture-pane -pt {}'  |\
          # xargs tmux join-pane -v -s"

        '';
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "tmux"
      ];
    }
    {
      my.user.packages = with pkgs; [
        reattach-to-user-namespace
      ];
    }
  ]);
}
