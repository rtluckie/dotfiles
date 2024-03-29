{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.tmux;
in {
  options = {
    modules.tools.misc.tmux = {
      enable =
        mkEnableOption "tools.misc.tmux"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.sessionVariables = {
        ZSH_TMUX_AUTOSTART = "false";
        ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
      };
    }
    {
      my.hm.user.programs.tmux = {
        enable = true;
        aggressiveResize = true;
        baseIndex = 1;
        clock24 = true;
        customPaneNavigationAndResize = true;
        escapeTime = 0;
        historyLimit = 50000;
        keyMode = "vi";
        mouse = true;
        newSession = true;
        prefix = "C-a";
        resizeAmount = 10;
        sensibleOnTop = true;
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "screen-256color";
        tmuxinator.enable = false;
      };
    }
    {
      my.hm.user.programs.tmux.plugins = with pkgs; [
        tmuxPlugins.pain-control
        tmuxPlugins.copycat
        # tmuxPlugins.continuum
        # tmuxPlugins.resurrect
        {
          plugin = tmuxPlugins.dracula;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @dracula-show-location false
            set -g @dracula-plugins "battery network"
          '';
        }
        # tmuxPlugins.gruvbox
        {
          plugin = tmuxPlugins.tmux-thumbs;
          extraConfig = ''
            set -g @thumbs-command 'echo -n {} | pbcopy'
            set -g @thumbs-unique enabled
          '';
        }
      ];
    }
    {
      my.hm.user.programs.tmux.extraConfig = ''
        set -g mouse on
        bind-key R source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display-message "$XDG_CONFIG_HOME/tmux/tmux.conf reloaded"
        set-option -g default-command "reattach-to-user-namespace -l zsh"
        set-option -g set-clipboard on

        # bind J display-popup -E "\
        # tmux list-panes -a -F '#{?session_attached,,#S:#I.#P}' |\
        # sed '/^$/d' |\
        # fzf --reverse --header join-pane --preview 'tmux capture-pane -pt {}'  |\
        # xargs tmux join-pane -v -s"
      '';
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "tmux"
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
        reattach-to-user-namespace
      ];
    }
  ]);
}
