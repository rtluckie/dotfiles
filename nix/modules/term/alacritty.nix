{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.alacritty;
in {
  options = {
    modules.term.alacritty = {
      enable =
        mkEnableOption "term.alacritty"
        // {
          default = false;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.alacritty ];
      my.hm.user.programs.alacritty = rec {
        enable = true;
        settings = {
          font = {
            normal = {
              family = config.my.fonts.sans.name;
              style = "Regular";
            };
            bold = {
              family = config.my.fonts.sans.name;
              style = "Bold";
            };
            italic = {
              family = config.my.fonts.sans.name;
              style = "Italic";
            };
            size = toInt config.my.fonts.sans.size;
          };
          cursor.style = "Beam";
          key_bindings = [
            # { key = "Space";  mods= "Control";                 action= "ToggleViMode";            }
          ];
          window.padding = {
            x = 12;
            y = 0;
          };
          window.decorations = "none";
          # window.dynamic_padding = false;
          # https://github.com/eendroroy/alacritty-theme/blob/master/themes/palenight.yml
          colors = {
            # Default colors
            primary = {
              background = "0x292d3e";
              foreground = "0xd0d0d0";
            };
            cursor = {
              text = "0x202331";
              cursor = "0xc792ea";
            };
            # Normal colors
            normal = {
              black = "0x292d3e";
              red = "0xf07178";
              green = "0xc3e88d";
              yellow = "0xffcb6b";
              blue = "0x82aaff";
              magenta = "0xc792ea";
              cyan = "0x89ddff";
              white = "0xd0d0d0";
            };
            # Bright colors
            bright = {
              black = "0x434758";
              red = "0xff8b92";
              green = "0xddffa7";
              yellow = "0xffe585";
              blue = "0x9cc4ff";
              magenta = "0xe1acff";
              cyan = "0xa3f7ff";
              white = "0xffffff";
            };
            indexed_colors = [
              {
                index = 16;
                color = "0xf78c6c";
              }
              {
                index = 17;
                color = "0xff5370";
              }
              {
                index = 18;
                color = "0x444267";
              }
              {
                index = 19;
                color = "0x32374d";
              }
              {
                index = 20;
                color = "0x8796b0";
              }
              {
                index = 21;
                color = "0x959dcb";
              }
            ];
          };
        };
      };
    }
  ]);
}
