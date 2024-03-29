{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.terminals.wezterm;
in {
  options = {
    modules.applications.terminals.wezterm = {
      enable =
        mkEnableOption "applications.terminals.wezterm"
        // {
          default = false;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.alacritty ];
      my.hm.user.programs.wezterm = rec {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm';

          local selected_scheme = "Dracula";
          local scheme = wezterm.get_builtin_color_schemes()[selected_scheme]

          local C_ACTIVE_BG = scheme.selection_bg;
          local C_ACTIVE_FG = scheme.ansi[6];
          local C_BG = scheme.background;
          local C_HL_1 = scheme.ansi[5];
          local C_HL_2 = scheme.ansi[4];
          local C_INACTIVE_FG;
          local bg = wezterm.color.parse(scheme.background);
          local h, s, l, a = bg:hsla();
          if l > 0.5 then
            C_INACTIVE_FG = bg:complement_ryb():darken(0.3);
          else
            C_INACTIVE_FG = bg:complement_ryb():lighten(0.3);
          end

          scheme.tab_bar = {
            background = C_BG,
            new_tab = {
              bg_color = C_BG,
              fg_color = C_HL_2,
            },
            active_tab = {
              bg_color = C_ACTIVE_BG,
              fg_color = C_ACTIVE_FG,
            },
            inactive_tab = {
              bg_color = C_BG,
              fg_color = C_INACTIVE_FG,
            },
            inactive_tab_hover = {
              bg_color = C_BG,
              fg_color = C_INACTIVE_FG,
            }
          }

          wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
            if tab.is_active then
              return {
                {Foreground={Color=C_HL_1}},
                {Text=" " .. tab.tab_index+1},
                {Foreground={Color=C_HL_2}},
                {Text=": "},
                {Foreground={Color=C_ACTIVE_FG}},
                {Text=tab.active_pane.title .. " "},
                {Background={Color=C_BG}},
                {Foreground={Color=C_HL_1}},
                {Text="|"},
              }
            end
            return {
              {Foreground={Color=C_HL_1}},
              {Text=" " .. tab.tab_index+1},
              {Foreground={Color=C_HL_2}},
              {Text=": "},
              {Foreground={Color=C_INACTIVE_FG}},
              {Text=tab.active_pane.title .. " "},
              {Foreground={Color=C_HL_1}},
              {Text="|"},
            }
          end
          )

          return {
            leader = { key="w", mods="CTRL"},
            color_schemes = {
              [selected_scheme] = scheme
            },
            color_scheme = selected_scheme,
            font = wezterm.font("${config.my.fonts.mono.name}"),
            font_size = 22,
            tab_bar_at_bottom = true,
            tab_max_width = 96,
            hide_tab_bar_if_only_one_tab = true,
            use_fancy_tab_bar = false,
            mouse_bindings = {
              -- Ctrl-click will open the link under the mouse cursor
              {
                event = { Up = { streak = 1, button = 'Left' } },
                mods = 'CTRL',
                action = wezterm.action.OpenLinkAtMouseCursor,
              },
            },
            keys = {
              {key="a", mods="LEADER|CTRL", action=wezterm.action{SendString="\x01"}},

              -- Mode
              {key="x", mods="LEADER", action=wezterm.action.ActivateCopyMode},
              {key=" ", mods="LEADER", action=wezterm.action.QuickSelect},

              -- Pane Management
              {key="s", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
              {key="v", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
              -- {key="x", mods="LEADER", action=wezterm.action{CloseCurrentPane={confirm=false}}},

              -- Navigation
              {key = "h", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
              {key = "l", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
              {key = "k", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
              {key = "j", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
              {key="]", mods="LEADER", action=wezterm.action{ActivateTabRelative=1}},
              {key="[", mods="LEADER", action=wezterm.action{ActivateTabRelative=-1}},
              {key="1", mods="LEADER", action=wezterm.action{ActivateTab=0}},
              {key="2", mods="LEADER", action=wezterm.action{ActivateTab=1}},
              {key="3", mods="LEADER", action=wezterm.action{ActivateTab=2}},
              {key="4", mods="LEADER", action=wezterm.action{ActivateTab=3}},
              {key="5", mods="LEADER", action=wezterm.action{ActivateTab=4}},
              {key="6", mods="LEADER", action=wezterm.action{ActivateTab=5}},
              {key="7", mods="LEADER", action=wezterm.action{ActivateTab=6}},
              {key="8", mods="LEADER", action=wezterm.action{ActivateTab=7}},
              {key="9", mods="LEADER", action=wezterm.action{ActivateTab=8}},
              {key="0", mods="LEADER", action=wezterm.action{ActivateTab=-1}},
              {key="0", mods="SUPER", action=wezterm.action{ActivateTab=-1}},
            },

            window_frame = {
              font = wezterm.font({family="${config.my.fonts.mono.name}", weight="Bold"}),
              font_size = 22,
            },
            window_decorations = "RESIZE",
            window_padding = {
              left = 30,
              right = 30,
              top = 30,
              bottom = 30,
            },
          }
        '';
      };
    }
  ]);
}
