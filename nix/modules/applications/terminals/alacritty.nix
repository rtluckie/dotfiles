{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.terminals.alacritty;
in {
  options = {
    modules.applications.terminals.alacritty = {
      enable =
        mkEnableOption "applications.terminals.alacritty"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.alacritty ];
      my.hm.user.programs.alacritty = rec {
        enable = true;
        settings = {
          import = [
            "${config.my.dotfiles.configDir}/alacritty/gruvbox_dark.yaml"
            "${config.my.dotfiles.configDir}/alacritty/custom.yaml"
          ];
          live_config_reload = true;
          font = {
            normal = {
              family = config.my.fonts.mono.name;
              style = "Regular";
            };
            bold = {
              family = config.my.fonts.mono.name;
              style = "Bold";
            };
            italic = {
              family = config.my.fonts.mono.name;
              style = "Italic";
            };
            size = (config.my.fonts.mono.size * 0.20) + config.my.fonts.mono.size;
          };
          cursor = {
            style = "Beam";
            blinking = "Always";
          };
          key_bindings = [
            # { key = "Space";  mods= "Control";                 action= "ToggleViMode";            }
          ];
          window = {
            padding = {
              x = 20;
              y = 20;
            };
            decorations = "none";
            startup_mode = "Maximized";
            dynamic_title = false;
          };
        };
      };
    }
    {
      my.hm.configFile."alacritty/themes/alacritty" = {
        source = "${(pkgs.fetchzip {
          url = "https://github.com/alacritty/alacritty-theme/archive/0fb8868.zip";
          sha256 = "sha256-BwZ0LdSbIRiYcaKkhUHRzOOTqx09yYHsrfTcLOSCNhw=";
        })}/themes";
        recursive = true;
      };
    }
  ]);
}
