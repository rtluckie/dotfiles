{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.system.yabai;
in {
  options = {
    modules.applications.system.yabai = {
      enable =
        mkEnableOption "applications.system.yabai"
        // {
          default = false;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.yabai = {
        enable = true;
        # package = pkgs.yabai-5_0_1;
        enableScriptingAddition = true;
        config = {
          window_border = "on";
          window_border_width = 1;
          active_window_border_color = "0xff81a1c1";
          normal_window_border_color = "0xff3b4252";
          window_border_hidpi = "on";
          focus_follows_mouse = "autoraise";
          mouse_follows_focus = "off";
          mouse_drop_action = "stack";
          window_placement = "second_child";
          window_opacity = "off";
          window_topmost = "on";
          window_shadow = "float";
          window_origin_display = "focused";
          active_window_opacity = "1.0";
          normal_window_opacity = "1.0";
          split_ratio = "0.50";
          auto_balance = "on";
          mouse_modifier = "alt";
          mouse_action1 = "move";
          mouse_action2 = "resize";
          layout = "bsp";
          top_padding = 0;
          bottom_padding = 0;
          left_padding = 0;
          right_padding = 0;
          window_gap = 0;
          external_bar = "main:49:0";
        };

        extraConfig = ''
          # rules
          yabai -m rule --add app='^System Settings' manage=off
          yabai -m rule --add app='Yubico Authenticator' manage=off
          yabai -m rule --add app='YubiKey Manager' manage=off
          yabai -m rule --add app='YubiKey Personalization Tool' manage=off

          # signals
          yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
          yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
          yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
        '';
      };
    }
  ]);
}
